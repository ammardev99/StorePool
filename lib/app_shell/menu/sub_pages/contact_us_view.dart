import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView>
    with SingleTickerProviderStateMixin {
  // ← required for vsync

  // ← was missing commas — all items were merged into one string
  final List<String> contactType = [
    'Question',
    'Suggestions',
    'Feedback',
    'Report Bug',
    // 'Schedule Call',
    // 'Attachments',
  ];

  late final TabController _tabController;
  String _activeType = 'Contact Us';

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: contactType.length,
      vsync: this, // ← was commented out, caused crash
      initialIndex: 0,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      final type = contactType[_tabController.index];
      if (_activeType == type) return;
      setState(() => _activeType = type);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      appBar: ZiAppBarB(title: "Contact Us"),
      body: Column(
        children: [
          ZiTabBar(
            controller: _tabController, // ← was `controller` (undefined)
            type: ZiTabBarType.filter,
            tabs: contactType.map((e) => Tab(text: e)).toList(),
          ),
          ziGap(16),
          Text(_activeType, style: ZiTypoStyles.titleLg),
          ziGap(16),
          ZiInput(label: "Subject", variant: ZiInputVariant.stacked),
          ziGap(16),
          ZiInput(
            label: "Message",
            variant: ZiInputVariant.stacked,
            type: ZiInputType.multiline,
          ),
          ziGap(20),
          ZiButtonB(expand: true, label: "Submit", action: () {}),
        ],
      ),
    );
  }
}
