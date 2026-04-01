import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../app_shell_io.dart';

enum PlanType { free, standard, pro }

class UpgradeDialog {
  static void show(
    BuildContext context, {
    PlanType currentPlan = PlanType.free,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _UpgradeDialogContent(currentPlan: currentPlan),
    );
  }
}

class _UpgradeDialogContent extends StatefulWidget {
  final PlanType currentPlan;

  const _UpgradeDialogContent({required this.currentPlan});

  @override
  State<_UpgradeDialogContent> createState() => _UpgradeDialogContentState();
}

class _UpgradeDialogContentState extends State<_UpgradeDialogContent> {
  PlanType? selectedPlan;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 540),
        child: Stack(
          children: [
            Column(
              // shrinkWrap: true,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                Flexible(
                  fit: FlexFit.loose,
                  // it takcking full how i can make it take min heigh
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
                    shrinkWrap: true,
                    children: [
                      _buildPlanCard(
                        planType: PlanType.free,
                        title: "Free",
                        price: "\$0",
                        period: "forever",
                        tagline: "Perfect for personal use",
                        features: [
                          "10 personal projects",
                          "3 phases per project",
                          "Unlimited tasks",
                          "Basic project management",
                          "Mobile & web access",
                          "Email support (48hrs)",
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildPlanCard(
                        planType: PlanType.standard,
                        title: "Standard",
                        price: "\$19",
                        period: "/month",
                        tagline: "Great for small teams",
                        isPopular: true,
                        features: [
                          "100 projects",
                          "10 phases per project",
                          "Unlimited tasks",
                          "Team collaboration & sharing",
                          "View/Edit/Comment permissions",
                          "Offline mode",
                          "Priority email support",
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildPlanCard(
                        planType: PlanType.pro,
                        title: "Business",
                        price: "\$49",
                        period: "/month",
                        tagline: "Built for power users & teams",
                        features: [
                          "1000 projects",
                          "25 phases per project",
                          "Unlimited tasks",
                          "Advanced team collaboration",
                          "Granular access controls",
                          "Offline mode",
                          "Real-time team chat",
                          "Task comments & mentions",
                          "Advanced analytics",
                          "Priority support & onboarding",
                        ],
                      ),
                      ziGap(12),
                      _buildFeatureComparison(),
                    ],
                  ),
                ),
                // gapBox(10),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildFixedFooter(context),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(bottom: 0, top: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: ZiColors.primary.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.workspace_premium_rounded,
              size: 36,
              color: ZiColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          // Text(
          //   "Choose Your Plan",
          //   style: ZiTypoStyles.titleLg.copyWith(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 24,
          //   ),
          // ),
          // const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified_user_outlined,
                size: 14,
                color: ZiColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                "30-day money-back guarantee",
                style: ZiTypoStyles.caption.copyWith(
                  color: ZiColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "Tap any plan to see all features",
            style: ZiTypoStyles.bodyMedium.copyWith(color: ZiColors.textDark),
            textAlign: TextAlign.center,
          ),

          ziGap(2),
          Divider(height: 2, thickness: 1, color: ZiColors.border),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required PlanType planType,
    required String title,
    required String price,
    required String period,
    required String tagline,
    required List<String> features,
    bool isPopular = false,
  }) {
    final isSelected = selectedPlan == planType;
    final isCurrent = widget.currentPlan == planType;
    final isExpanded = isSelected;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = isSelected ? null : planType;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color:
              isSelected
                  ? ZiColors.primary.withValues(alpha: 0.08)
                  : ZiColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? ZiColors.primary : ZiColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: ZiColors.primary.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : null,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Plan Icon
                  // AnimatedContainer(
                  //   duration: const Duration(milliseconds: 200),
                  //   width: 48,
                  //   height: 48,
                  //   decoration: BoxDecoration(
                  //     color:
                  //         isSelected
                  //             ? ZiColors.primary
                  //             : ZiColors.primary.withValues(alpha: 0.1),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Icon(
                  //     isSelected
                  //         ? Icons.check_circle_rounded
                  //         : _getPlanIcon(planType),
                  //     color: isSelected ? Colors.white : ZiColors.primary,
                  //     size: 28,
                  //   ),
                  // ),
                  // const SizedBox(width: 16),
                  // Plan Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: ZiTypoStyles.titleMd.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (isCurrent) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: ZiColors.success.withValues(
                                    alpha: 0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: ZiColors.success.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "ACTIVE",
                                  style: ZiTypoStyles.caption.copyWith(
                                    color: ZiColors.success,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                            ],
                            if (isPopular) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      ZiColors.primary,
                                      ZiColors.primary.withValues(alpha: 0.8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "POPULAR",
                                      style: ZiTypoStyles.caption.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            if (!isPopular && !isCurrent) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  gradient: ZiColors.gradientLR,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Pro",
                                      style: ZiTypoStyles.caption.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          tagline,
                          style: ZiTypoStyles.caption.copyWith(
                            color: ZiColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Price & Expand Indicator
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        price,
                        style: ZiTypoStyles.titleLg.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ZiColors.primary,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        period,
                        style: ZiTypoStyles.caption.copyWith(
                          color: ZiColors.textSecondary,
                        ),
                      ),
                      // const SizedBox(height: 4),
                      // AnimatedRotation(
                      //   turns: isExpanded ? 0.5 : 0,
                      //   duration: const Duration(milliseconds: 300),
                      //   child: Icon(
                      //     Icons.keyboard_arrow_down_rounded,
                      //     color: ZiColors.primary,
                      //     size: 20,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            // Expandable Features List
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: ZiColors.border),
                    const SizedBox(height: 8),
                    ...features.map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 18,
                              color: ZiColors.success,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                feature,
                                style: ZiTypoStyles.bodyMedium.copyWith(
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState:
                  isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFixedFooter(BuildContext context) {
    final canUpgrade =
        selectedPlan != null && selectedPlan != widget.currentPlan;
    final planName = selectedPlan != null ? _getPlanName(selectedPlan!) : "";

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // if (!canUpgrade && selectedPlan != null)
          // Container(
          //   padding: const EdgeInsets.all(12),
          //   margin: const EdgeInsets.only(bottom: 12),
          //   decoration: BoxDecoration(
          //     color: ZiColors.success.withValues(alpha: 0.1),
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(
          //       color: ZiColors.success.withValues(alpha: 0.3),
          //     ),
          //   ),
          //   child: Row(
          //     children: [
          //       Icon(Icons.check_circle, size: 18, color: ZiColors.success),
          //       const SizedBox(width: 12),
          //       Expanded(
          //         child: Text(
          //           "You're already on this plan",
          //           style: ZiTypoStyles.caption.copyWith(
          //             color: ZiColors.success,
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Row(
            children: [
              Expanded(
                child: ZiButtonB(
                  label: "Cancel",
                  variant: ZiButtonVariantB.outline,
                  action: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ZiButtonB(
                  label:
                      canUpgrade
                          ? "Upgrade to $planName"
                          : selectedPlan != null
                          ? "Current Plan"
                          : "Select a Plan",
                  disabled: !canUpgrade,
                  action:
                      canUpgrade
                          ? () => _handleUpgrade(context, planName)
                          : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────

  // IconData _getPlanIcon(PlanType plan) {
  //   switch (plan) {
  //     case PlanType.free:
  //       return Icons.favorite;
  //     case PlanType.standard:
  //       return Icons.groups_rounded;
  //     case PlanType.pro:
  //       return Icons.rocket_launch_rounded;
  //   }
  // }

  String _getPlanName(PlanType plan) {
    switch (plan) {
      case PlanType.free:
        return "Free";
      case PlanType.standard:
        return "Standard";
      case PlanType.pro:
        return "Business";
    }
  }

  Future<void> _handleUpgrade(BuildContext context, String planName) async {
    Navigator.pop(context);
    final phoneNumber = "923424264494";
    final message = "Hi, I want to upgrade my *${ShellData.appInfo.title}* account from ${_getPlanName(widget.currentPlan)} to $planName plan.";
    final encodedMessage = Uri.encodeComponent(message);
    final whatsappUrl = "https://api.whatsapp.com/send/?phone=$phoneNumber&text=$encodedMessage&type=phone_number&app_absent=0";
    try {
      final uri = Uri.parse(whatsappUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (!context.mounted) return;
        ZiFeedback.snackbar(
          context,
          message: "Could not open WhatsApp. Please install WhatsApp first.",
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ZiFeedback.snackbar(
        context,
        message: "Failed to open WhatsApp. Please try again.",
      );
    }
  }

  Widget _buildFeatureComparison() {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ZiColors.surface,
        // gradient: LinearGradient(
        //   colors: [
        //     ZiColors.info.withValues(alpha: 0.08),
        //     ZiColors.info.withValues(alpha: 0.03),
        //   ],
        // ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ZiColors.info.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.compare_arrows_rounded,
                size: 20,
                color: ZiColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                "Quick Comparison",
                style: ZiTypoStyles.titleSm.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _comparisonRow("Projects", "10", "100", "1000"),
          _comparisonRow("Phases", "3", "10", "25"),
          _comparisonRow("Team Sharing", "—", "✓", "✓"),
          _comparisonRow("Offline Mode", "—", "✓", "✓"),
          _comparisonRow("Team Chat", "—", "—", "✓"),
          _comparisonRow("Task Comments", "—", "—", "✓"),
        ],
      ),
    );
  }

  Widget _comparisonRow(
    String feature,
    String free,
    String standard,
    String pro,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              feature,
              style: ZiTypoStyles.caption.copyWith(
                color: ZiColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _comparisonCell(free, PlanType.free),
                _comparisonCell(standard, PlanType.standard),
                _comparisonCell(pro, PlanType.pro),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _comparisonCell(String value, PlanType planType) {
    final isSelected = selectedPlan == planType;
    return Container(
      width: 40,
      alignment: Alignment.center,
      child: Text(
        value,
        style: ZiTypoStyles.caption.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? ZiColors.primary : ZiColors.textDark,
        ),
      ),
    );
  }
}
