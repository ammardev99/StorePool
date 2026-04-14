import 'package:flutter/material.dart';
import 'package:storepool/app_models/catalog_categories_table_data.dart';
import 'package:storepool/app_models/catalog_items_table_data.dart'
    show CatalogType;
import 'package:storepool/firebase_services/store/catalog_category_service.dart';
import 'package:storepool/firebase_services/store/catalog_item_service.dart';
import 'package:zi_core/zi_core_io.dart';

class CatalogForm extends StatefulWidget with ZiFormMixin {
  final String storeId;
  final CatalogType type;
  final Map<String, dynamic>? item;

  const CatalogForm({
    super.key,
    required this.storeId,
    required this.type,
    this.item,
  });

  @override
  ValueNotifier<bool> get hasChanges => ValueNotifier(true);

  @override
  ZiFormMode get mode => item == null ? ZiFormMode.add : ZiFormMode.edit;

  @override
  VoidCallback? get onClose => null;

  @override
  State<CatalogForm> createState() => _CatalogFormState();
}

class _CatalogFormState extends State<CatalogForm> {
  final _formKey = GlobalKey<FormState>();
  final _service = CatalogItemService();

  bool loading = false;

  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final skuCtrl = TextEditingController();
  final brandCtrl = TextEditingController();
  final stockCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  bool showMore = false;
  bool isLoadingCategories = false;

  final _categoryService = CatalogCategoryService();
  List<CatalogCategoriesTableData> categories = [];
  CatalogCategoriesTableData? selectedCategory;

  @override
  void initState() {
    super.initState();

    String? categoryUuid;

    if (widget.item != null) {
      final item = widget.item!;

      nameCtrl.text = item["title"] ?? '';
      priceCtrl.text = (item["price"] ?? '').toString();
      skuCtrl.text = item["sku"] ?? '';
      brandCtrl.text = item["brand"] ?? '';
      stockCtrl.text = (item["stockQty"] ?? '').toString();
      descCtrl.text = item["description"] ?? '';
      categoryUuid = item["categoryUuid"];

      showMore =
          skuCtrl.text.isNotEmpty ||
          brandCtrl.text.isNotEmpty ||
          descCtrl.text.isNotEmpty;
    }

    _loadCategories(categoryUuid: categoryUuid);
  }

  void _onChange() {
    setState(() {});
  }

  Future<void> _loadCategories({String? categoryUuid}) async {
    setState(() => isLoadingCategories = true);

    try {
      final data = await _categoryService.getCategories(
        storeId: widget.storeId,
        type: widget.type.name,
      );

      final parsed =
          data
              .map((e) => CatalogCategoriesTableData.fromMap(e))
              .where((e) => e.catalogType == widget.type.name)
              .toList();

      setState(() {
        categories = parsed;

        if (categories.isNotEmpty) {
          if (categoryUuid != null) {
            selectedCategory = categories.firstWhere(
              (e) => e.uuid == categoryUuid,
              orElse: () => categories.first,
            );
          } else {
            selectedCategory = categories.first;
          }
        }
      });
    } catch (e) {
      setState(() {
        categories = [];
      });
    } finally {
      setState(() => isLoadingCategories = false);
    }
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      if (widget.mode == ZiFormMode.add) {
        await _service.createItem(
          storeId: widget.storeId,
          title: nameCtrl.text.trim(),
          price: double.parse(priceCtrl.text.trim()),
          categoryUuid: selectedCategory?.uuid ?? '',
          catalogType: widget.type.name,
          sku: skuCtrl.text.trim(),
          brand: brandCtrl.text.trim(),
          stockQty: int.tryParse(stockCtrl.text) ?? 0,
          description: descCtrl.text.trim(),
        );
      } else {
        await _service.updateItem(
          storeId: widget.storeId,
          uuid: widget.item!["uuid"],
          title: nameCtrl.text.trim(),
          price: double.parse(priceCtrl.text.trim()),
          categoryUuid: selectedCategory?.uuid ?? '',
          catalogType: widget.type.name,
          sku: skuCtrl.text.trim(),
          brand: brandCtrl.text.trim(),
          stockQty: int.tryParse(stockCtrl.text) ?? 0,
          description: descCtrl.text.trim(),
        );
      }

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saved successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Operation failed'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ZiInput(
                label: 'Name *',
                variant: ZiInputVariant.stacked,
                controller: nameCtrl,
                enabled: true,
                onChanged: (_) => _onChange(),
                validator:
                    (v) => v == null || v.isEmpty ? 'Name required' : null,
              ),
              ziGap(12),

              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: ZiSelectB<CatalogCategoriesTableData>(
                      label: 'Category',
                      hint: 'Select category',
                      items: categories,
                      value: selectedCategory,
                      itemLabel: (e) => e.name,
                      onChanged: (v) {
                        setState(() => selectedCategory = v);
                      },
                    ),
                  ),
                  ziGap(12),
                  Expanded(
                    child: ZiInput(
                      label: 'Price *',
                      variant: ZiInputVariant.stacked,
                      controller: priceCtrl,
                      enabled: true,
                      onChanged: (_) => _onChange(),
                      validator:
                          (v) =>
                              v == null || v.isEmpty ? 'Price required' : null,
                    ),
                  ),
                ],
              ),

              ziGap(12),

              if (isLoadingCategories)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),

              ZiSwitchB(
                subtitle: "you can add more info",
                value: showMore,
                label: "Add More",
                onChanged: (value) {
                  setState(() => showMore = value);
                },
              ),

              if (showMore) ...[
                const Divider(),
                ZiInput(
                  label: 'SKU / BarCode',
                  variant: ZiInputVariant.stacked,
                  controller: skuCtrl,
                  enabled: true,
                  onChanged: (_) => _onChange(),
                ),
                ziGap(12),
                Row(
                  children: [
                    Expanded(
                      child: ZiInput(
                        label: 'Brand',
                        variant: ZiInputVariant.stacked,
                        controller: brandCtrl,
                        enabled: true,
                        onChanged: (_) => _onChange(),
                      ),
                    ),
                    ziGap(12),
                    Expanded(
                      child: ZiInput(
                        label: 'Stock Qty',
                        variant: ZiInputVariant.stacked,
                        controller: stockCtrl,
                        enabled: true,
                        onChanged: (_) => _onChange(),
                      ),
                    ),
                  ],
                ),
                ziGap(12),
                ZiInput(
                  label: 'Description',
                  variant: ZiInputVariant.stacked,
                  type: ZiInputType.multiline,
                  controller: descCtrl,
                  enabled: true,
                  onChanged: (_) => _onChange(),
                ),
              ],

              ziGap(20),

              ZiStateIndicator(
                message: 'Fill required * fields to continue',
                tone: ZiStateTone.info,
              ),

              ZiButtonB(
                expand: true,
                loading: loading,
                label: 'Save',
                action: _onSave,
              ),
            ],
          ),
        ),

        // ✅ LOADING OVERLAY
        // if (loading)
        //   Container(
        //     color: Colors.black26,
        //     child: const Center(child: CircularProgressIndicator()),
        //   ),
      ],
    );
  }
}
