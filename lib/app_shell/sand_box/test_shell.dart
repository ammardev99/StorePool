import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class TestShell extends StatelessWidget {
  const TestShell({super.key});

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      safeArea: true,
      appBar: ZiAppBarB(title: "Test Shell Page"),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("TestShell"), ziGap(16), Divider()],
        ),
      ),
    );
  }
}
