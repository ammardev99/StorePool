import 'package:flutter/material.dart';
import 'package:storepool/app_features/pos_sale_slice/data/form.dart';
import 'package:storepool/app_features/pos_sale_slice/data/hold_cart.dart';
import 'package:storepool/app_features/pos_sale_slice/tile_widget.dart';
import 'package:zi_core/zi_core_io.dart';

class POSSaleSliceView extends StatefulWidget {
  const POSSaleSliceView({super.key});

  @override
  State<POSSaleSliceView> createState() => _POSSaleSliceViewState();
}

class _POSSaleSliceViewState extends State<POSSaleSliceView> {
  bool isNewSale = false;

  /// ✅ DUMMY DATA
  final List<Map<String, dynamic>> dummyItems = [
    {"name": "Product 1", "phone": "123456789", "price": 200, "qty": 1},
    {"name": "Product 2", "phone": "987654321", "price": 300, "qty": 2},
  ];

  /// ================= FORM =================
  void _openForm() {
    ziFormView(
      context,
      type: ZiFormViewType.dialog,
      title: "Add Item",
      form: const POSSliceForm(),
    );
  }

  /// ================= CHECKOUT UI =================
  void _showCheckoutBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: ZiColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// TOP ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "5 Items (12)",
                    style: ZiTypoStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "3,500",
                        style: ZiTypoStyles.bodyMd.copyWith(
                          color: ZiColors.gray,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      ziGap(8),
                      Text(
                        "Rs 3,000",
                        style: ZiTypoStyles.titleLg.copyWith(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              ziGap(12),

              /// DISCOUNT + PAID
              Row(
                children: [
                  Expanded(child: _inputBox(label: "Discount", value: "500")),
                  ziGap(10),
                  Expanded(
                    child: _inputBox(
                      label: "Paid:",
                      value: "4,000",
                      valueColor: Colors.green,
                    ),
                  ),
                ],
              ),

              ziGap(10),

              /// EXTRA + CHANGE
              Row(
                children: [
                  Expanded(child: _inputBox(label: "Extra:", value: "00")),
                  ziGap(10),
                  Expanded(
                    child: _inputBox(
                      label: "Change:",
                      value: "500",
                      valueColor: Colors.orange,
                    ),
                  ),
                ],
              ),

              ziGap(12),

              /// CUSTOMER
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: ZiColors.grayLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Customer Name",
                    border: InputBorder.none,
                  ),
                ),
              ),

              ziGap(6),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "phone no",
                  style: ZiTypoStyles.bodyMd.copyWith(color: ZiColors.gray),
                ),
              ),

              ziGap(12),

              /// BUTTON
              ZiButtonB(expand: true, label: "Save & Print", action: () {}),
            ],
          ),
        );
      },
    );
  }

  Widget _inputBox({
    required String label,
    required String value,
    Color valueColor = Colors.black,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: ZiColors.grayLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(label, style: ZiTypoStyles.bodyMd),
          const Spacer(),
          Text(
            value,
            style: ZiTypoStyles.bodyMd.copyWith(
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      appBar: ZiAppBarB(
        title: "POS Sale",
        centerTitle: true,

        /// ✅ SHOW PAUSE ONLY IN NEW SALE
        actions:
            isNewSale
                ? [
                  IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: () {
                      ziShowFeedOver(
                        context,
                        type: ZiFeedOverType.bottomSheet,
                        body: const HoldCart(),
                      );
                    },
                  ),
                ]
                : [],
      ),
      showPagePadding: false,
      body: isNewSale ? _buildNewSaleUI() : _buildCenterContent(),
    );
  }

  /// ================= EMPTY =================
  Widget _buildCenterContent() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NO Order/Cart Found',
              textAlign: TextAlign.center,
              style: ZiTypoStyles.titleXl.copyWith(fontWeight: FontWeight.bold),
            ),
            ziGap(10),
            Text(
              'you can add personal details to strong the pos store profile',
              textAlign: TextAlign.center,
              style: ZiTypoStyles.bodyMd,
            ),
            ziGap(100),
            ZiButtonB(
              expand: true,
              label: 'New Sale',
              action: () {
                setState(() {
                  isNewSale = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ================= POS UI =================
  Widget _buildNewSaleUI() {
    return Column(
      children: [
        ziGap(10),

        /// SEARCH + ADD
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: ZiColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ZiColors.white),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search,color: ZiColors.grayLight,),
                      ziGap(10),
                      const Expanded(
                        child:
                        //  TextField(
                        //   decoration: InputDecoration(
                        //     hintText: 'scan SKU code' ,
                        //     hintStyle: TextStyle(color: ZiColors.grayLight),
                        //     border: InputBorder.none,
                            
                        //   ),
                        // ),
                        ZiInput(
                          hint: 'scan SKU code',
                          enabled: false,
                          variant: ZiInputVariant.filled
                          // variant: ZiInputVariant.none,
                        ),
                      ),
                      const Icon(Icons.qr_code_scanner,
                      color: ZiColors.grayLight,
                      ),
                    ],
                  ),
                ),
              ),
              ziGap(10),

              /// ADD BUTTON
              InkWell(
                onTap: _openForm,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ZiColors.grayLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: ZiColors.white),
                ),
              ),
            ],
          ),
        ),

        ziGap(20),

        /// LIST
        Expanded(
          child: ListView.builder(
            itemCount: dummyItems.length,
            itemBuilder: (context, index) {
              final item = dummyItems[index];

              return POSSaleSliceTile(
                item: item,
                onTap: () {},
                onIncrease: () {},
                onDecrease: () {},
                onDelete: () {},
              );
            },
          ),
        ),

        /// ✅ CHECKOUT BUTTON FIXED
        Padding(
          padding: const EdgeInsets.all(12),
          child: ZiButtonB(
            expand: true,
            label: "Checkout",
            action: _showCheckoutBottomSheet,
          ),
        ),
      ],
    );
  }
}
