import 'package:flutter/material.dart';
import 'package:storepool/app_features/items_slice/data/actions_on_tile.dart';
import 'package:storepool/app_shell/widgets/price_text.dart';
import 'package:storepool/app_shell/widgets/zi_info_tag.dart';
import 'package:zi_core/zi_core_io.dart';

class CatalogItemTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final String categoryName;
  final String currencySign;
  final String storeId; // ✅ NEW

  const CatalogItemTile({
    super.key,
    required this.item,
    required this.categoryName,
    required this.currencySign,
    required this.storeId, // ✅ NEW
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = item["isActive"] ?? true;

    return InkWell(
      splashColor: ZiColors.accent,
      onTap: isActive ? () {} : null,
      child: Opacity(
        opacity: isActive ? 1.0 : 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: ZiColors.border)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item["title"] ?? '',
                            style: ZiTypoStyles.titleMd,
                          ),
                        ),
                        if (!isActive)
                          Text(
                            'Inactive',
                            style: ZiTypoStyles.caption.copyWith(
                              color: ZiColors.error,
                            ),
                          )
                        else ...{
                          if ((item["stockQty"] ?? 0) > 0)
                            ZiInfoTag(
                              tag: 'Qty',
                              value: item["stockQty"].toString(),
                            ),
                          if ((item["soldCount"] ?? 0) > 0)
                            ZiInfoTag(
                              tag: 'Sold',
                              value: item["soldCount"].toString(),
                            ),
                        },
                      ],
                    ),
                    ziGap(4),

                    Row(
                      children: [
                        if (item["sku"] != null)
                          ZiInfoTag(
                            icon: Icons.qr_code_2_rounded,
                            value: item["sku"],
                          ),
                        if (item["brand"] != null)
                          ZiInfoTag(
                            icon: Icons.flag_rounded,
                            value: item["brand"],
                          ),
                      ],
                    ),
                    ziGap(4),

                    Row(
                      children: [
                        if (item["description"] != null) ...{
                          Text('Des:', style: ZiTypoStyles.caption),
                          ziGap(4),
                          Text(
                            item["description"],
                            style: ZiTypoStyles.caption,
                          ),
                        },
                      ],
                    ),
                    ziGap(4),

                    Row(
                      children: [
                        Text(
                          (item["id"] ?? '').toString(),
                          style: ZiTypoStyles.caption,
                        ),
                        ziGap(4),
                        Icon(Icons.category, size: 16, color: ZiColors.grayLight),
                        ziGap(8),
                        Text(categoryName, style: ZiTypoStyles.caption),
                        const Spacer(),
                        ZiPriceText(
                          symbol: currencySign,
                          value: item["price"] ?? 0,
                        ),
                        ziGap(4),
                      ],
                    ),
                  ],
                ),
              ),

              // ✅ PASS storeId HERE
              CatalogItemTileActions(
                item: item,
                storeId: storeId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}