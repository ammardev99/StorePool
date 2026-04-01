import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

import '../../app_shell_io.dart';

class ZiSplashScreen extends StatefulWidget {
  const ZiSplashScreen({super.key});

  @override
  State<ZiSplashScreen> createState() => _ZiSplashScreenState();
}

class _ZiSplashScreenState extends State<ZiSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ZAppGateView()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      layoutMode: ZiLayoutMode.fullWidth,
      safeArea: false,
      showPagePadding: false,
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(gradient: ZiColors.gradientTB),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) => Opacity(opacity: _opacity.value, child: child),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                Image.asset(ShellData.appSplash.image!, height: 120),
                const Spacer(),
                Text(
                  ShellData.appSplash.description!,
                  style: ZiTypoStyles.bodyMedium.copyWith(
                    color: ZiColors.surface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
