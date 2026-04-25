// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../app_shell_io.dart';

// data of appInfo
// ── App Logo ─────────────────────────────────────────────────────
// ── App Name ──────────────────────────────────────────────────────
// ── App info ──────────────────────────────────────────────────────
// ── App description ──────────────────────────────────────────────────────
// data of appAbout
// ── info - Our Vision ──────────────────────────────────────────────────────
// ── description ──────────────────────────────────────────────────────
// ── items ──────────────────────────────────────────────────────
// data of appFeatures
// ── info ──────────────────────────────────────────────────────
// ── items ──────────────────────────────────────────────────────
// data of appContact
// ──  title──────────────────────────────────────────────────────
// ──  info──────────────────────────────────────────────────────
// ──  items──────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────────────────
// AboutPageView — Presentation Layer only, zero business logic
// Data: ShellData.appInfo / appAbout / appFeatures / appContact / appDevelopers
// ─────────────────────────────────────────────────────────────────────────────

class AboutPageView extends StatelessWidget {
  const AboutPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      backgroundColor: ZiColors.background,
      appBar: ZiAppBarB(title: 'About App'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ziGap(24),

            // ── App Logo + Identity ───────────────────────────────────
            _AppLogoSection(),
            ziGap(20),

            _AppIdentitySection(),
            const SizedBox(height: 28),
            const ShellDivider(),
            ziGap(24),

            // ── Our Vision ────────────────────────────────────────────
            ShellSectionHeader(
              label: ShellData.appAbout.info,
              icon: Icons.visibility_outlined,
            ),
            ziGap(12),

            if (ShellData.appAbout.description != null)
              ShellDescriptionCard(text: ShellData.appAbout.description!),
            ziGap(20),

            // ── Our Mission ───────────────────────────────────────────
            const ShellSectionHeader(
              label: 'Our Mission',
              icon: Icons.flag_outlined,
            ),
            ziGap(12),

            if (ShellData.appAbout.items != null)
              ShellNumberedList(items: ShellData.appAbout.items!),
            ziGap(24),

            const ShellDivider(),
            ziGap(24),

            // ── Current Features ──────────────────────────────────────
            ShellSectionHeader(
              label: ShellData.appFeatures.info,
              icon: Icons.rocket_launch_outlined,
            ),
            ziGap(12),

            if (ShellData.appFeatures.items != null)
              ShellFeatureList(
                items:
                    ShellData.appFeatures.items!
                        .where((e) => !e.contains('(Coming Soon)'))
                        .toList(),
                isComingSoon: false,
              ),
            ziGap(20),
            ShellSectionHeader(
              label: "Coming Soon",
              icon: Icons.watch_later_outlined,
            ),
            ziGap(20),

            // ── Coming Soon ───────────────────────────────────────────
            if (ShellData.appFeatures.description != null) ...[
              ShellSectionHeader(
                label: ShellData.appFeatures.description!,
                icon: Icons.schedule_outlined,
              ),
              ziGap(12),
            ],
            if (ShellData.appFeatures.items != null)
              ShellFeatureList(
                items:
                    ShellData.appFeatures.items!
                        .where((e) => e.contains('(Coming Soon)'))
                        .map((e) => e.replaceAll(' (Coming Soon)', ''))
                        .toList(),
                isComingSoon: true,
              ),
            ziGap(24),
            const ShellDivider(),
            ziGap(24),
            // ── Contact ───────────────────────────────────────────────
            ShellSectionHeader(
              label: ShellData.appContact.title,
              icon: Icons.contact_support_outlined,
            ),
            const SizedBox(height: 6),
            Text(ShellData.appContact.info, style: ZiTypoStyles.bodyMd),
            ziGap(12),
            if (ShellData.appContact.items != null)
              ShellContactList(items: ShellData.appContact.items!),
            ziGap(24),
            // ── Developer Credit ──────────────────────────────────────
            const ShellDeveloperCredit(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ── App Logo ──────────────────────────────────────────────────────────────────

class _AppLogoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: ZiColors.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: ZiColors.accent,
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child:
            ShellData.appInfo.image != null
                ? Image.asset(ShellData.appInfo.image!, fit: BoxFit.contain)
                : Icon(Icons.store_rounded, size: 36, color: ZiColors.primary),
      ),
    );
  }
}

// ── App Identity ──────────────────────────────────────────────────────────────

class _AppIdentitySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ShellData.appInfo.title, style: ZiTypoStyles.titleXl),
        const SizedBox(height: 6),
        Row(
          children: [
            Container(
              width: 24,
              height: 3,
              decoration: BoxDecoration(
                color: ZiColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              ShellData.appInfo.info,
              style: ZiTypoStyles.titleSm.copyWith(color: ZiColors.primary),
            ),
          ],
        ),
        if (ShellData.appInfo.description != null) ...[
          const SizedBox(height: 10),
          Text(ShellData.appInfo.description!, style: ZiTypoStyles.bodyMd),
        ],
      ],
    );
  }
}
