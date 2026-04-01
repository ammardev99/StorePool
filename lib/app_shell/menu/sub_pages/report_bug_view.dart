import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class ReportBugView extends StatelessWidget {
  const ReportBugView({super.key});

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      safeArea: true,
      appBar: ZiAppBarB(title: "Report Bug"),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            ziGap(20),
            ZiInput(label: "Bug Page", variant: ZiInputVariant.stacked),
            ziGap(16),
            ZiInput(label: "Bug Heading", variant: ZiInputVariant.stacked),
            ziGap(16),
            ZiInput(label: "Bug Details", variant: ZiInputVariant.stacked),
            ziGap(20),
            ZiButtonB(expand: true, label: "Submit", action: () {}),
          ],
        ),
      ),
    );
  }
}
