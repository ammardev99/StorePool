// ─── Zi_Slice: View ───────────────────────────────────────────────────────────
// ROLE: List screen only. No business logic. Reads ViewModel via ref.watch.
// RULE: Never call Repository directly. Only ViewModel + Controller.
// RENAME: XxxSliceView → YourFeatureView
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../../widgets/analytics_card.dart';

class DashboardSliceView extends StatefulWidget {
  const DashboardSliceView({super.key});

  @override
  State<DashboardSliceView> createState() => _DashboardSliceViewState();
}

class _DashboardSliceViewState extends State<DashboardSliceView> {
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    ZiLogger.log("Loading items...");
    // DO: fetch from API
    setState(() {});
  }

  // ignore: unused_element
  Future<void> _delete(String uuid) async {
    ZiLogger.log("Delete: $uuid");
    // DO: delete API
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      body:Padding(
  padding: const EdgeInsets.all(15),
  child: Builder(
    builder: (context) {
      // 🔹 Dummy state
      final bool isLoading = false;
      final String? error = null;

      // 🔹 Dummy data
      final totalProjects = 12;
      final totalPhases = 8;
      final totalTasks = 45;
      final completedTasks = 30;
      final pendingTasks = 15;

      // ignore: dead_code
      if (isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (error != null) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              ziGap(10),
              ZiButtonB(
                label: "Retry",
                action: () {
                  debugPrint("Retry clicked");
                },
              ),
            ],
          ),
        );
      }

      return Column(
        children: [
          // ✅ Header
          Hero(
            tag: 'dashboard-hero',
            child: Text('Dashboard', style: ZiTypoStyles.titleLg.copyWith(
              color: ZiColors.primary,
              fontWeight: FontWeight.bold,
            )),
          ),
          ziGap(10),

          // ✅ Dashboard title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dashboard', style: ZiTypoStyles.titleMd),
              IconButton(
                onPressed: () {
                  debugPrint("Refresh clicked");
                },
                icon: Icon(
                  Icons.refresh_rounded,
                  color: ZiColors.grayLight,
                ),
                tooltip: 'Refresh Analytics',
              ),
            ],
          ),

          ziGap(10),

          // ✅ Analytics Row 1
          Row(
            children: [
              AnalyticsCard(
                label: "Projects",
                count: "$totalProjects",
              ),
              ziGap(10),
              AnalyticsCard(
                label: "Phases",
                count: "$totalPhases",
              ),
            ],
          ),

          ziGap(10),

          // ✅ Analytics Row 2
          Row(
            children: [
              AnalyticsCard(
                label: "All Tasks",
                count: "$totalTasks",
              ),
              ziGap(10),
              AnalyticsCard(
                backgroundColor: ZiColors.gainG,
                                labelColor: Colors.white,

                label: "Complete",
                count: "$completedTasks",
              ),
              ziGap(10),
              AnalyticsCard(
                backgroundColor: ZiColors.lossR,
                labelColor: Colors.white,
                label: "Pending",
                count: "$pendingTasks",
              ),
            ],
          ),

          ziGap(10),

          const Spacer(),
        ],
      );
    },
  ),
),
      
    );
  }
}
