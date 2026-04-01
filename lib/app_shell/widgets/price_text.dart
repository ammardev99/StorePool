import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class ZiPriceText extends StatelessWidget {
  final num value;
  final String symbol;

  const ZiPriceText({super.key, required this.value, this.symbol = '₨.'});

  @override
  Widget build(BuildContext context) {
    return Text(
      ZiFormatter.currencyNumber(value, symbol: symbol),
      style: ZiTypoStyles.noSm.copyWith(color: ZiColors.primary),
    );
  }
}
