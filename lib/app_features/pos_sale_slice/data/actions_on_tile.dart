import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class POSSliceActions extends StatelessWidget {
  const POSSliceActions({super.key});

  @override
  Widget build(BuildContext context) {
    return ZiOverOptionsActionButton(
      positionType: ZiOverOptionsPosition.bottomSheet,
      style: ZiOverOptionsStyle.defaults.copyWith(showItemBorder: true),
      actions: [],
    );
  }
}