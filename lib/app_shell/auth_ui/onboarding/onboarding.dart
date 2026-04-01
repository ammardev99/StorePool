import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../../app_shell_io.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int _index = 0;
  var styleType = OnboardingStyles.s2SkipNext;

  void _next() {
    if (_index == ShellData.onboarding.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      ); // Navigator.pushReplacement(
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _skip() {
    _controller.animateToPage(
      ShellData.onboarding.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      body: ListView(
        children: [
          if (styleType == OnboardingStyles.s1BottomRow) ziGap(30),
          if (styleType == OnboardingStyles.s2SkipNext)
            Align(
              alignment: Alignment.centerRight,
              child:
                  _index != ShellData.onboarding.length - 1
                      ? ZiButtonBText(label: 'Skip', onTap: _skip)
                      : ziGap(48),
            ),

          // content
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: PageView.builder(
              controller: _controller,
              itemCount: ShellData.onboarding.length,
              onPageChanged: (i) {
                setState(() => _index = i);
              },
              itemBuilder: (_, i) => _buildPage(i),
            ),
          ),
          // Actions
          // Action style 1
          if (styleType == OnboardingStyles.s1BottomRow) ...{
            // Indicators
            _pageIndicator(),
            ziGap(40),

            /// Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  if (_index != ShellData.onboarding.length - 1) ...{
                    ZiButtonB(
                      variant: ZiButtonVariantB.secondary,
                      label: 'Skip',
                      action: _skip,
                    ),
                    ziGap(10),
                  },
                  // ZiButtonBText(label: 'Skip', onTap: _skip),
                  // const Spacer(),
                  Expanded(
                    flex: 2,
                    child: ZiButtonB(
                      expand: true,
                      label:
                          _index == ShellData.onboarding.length - 1
                              ? 'Continue'
                              : 'Next',
                      action: _next,
                    ),
                  ),
                ],
              ),
            ),
          },
          // Action style 2
          if (styleType == OnboardingStyles.s2SkipNext)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _pageIndicator(),
                  ZiButtonB(
                    label:
                        _index == ShellData.onboarding.length - 1
                            ? 'Continue to App'
                            : 'Next →',
                    variant:
                        _index == ShellData.onboarding.length - 1
                            ? ZiButtonVariantB.primary
                            : ZiButtonVariantB.outline,
                    action: _next,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Page UI
  Widget _buildPage(int i) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(ShellData.onboarding[i].image!, height: 280),
          ziGap(20),
          heroSectionContent(
            title: ShellData.onboarding[i].title,
            content: ShellData.onboarding[i].info,
            isTitle: true,
          ),
        ],
      ),
    );
  }

  // Indicator
  Widget _pageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        ShellData.onboarding.length,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _index == i ? 32 : 8,
          decoration: BoxDecoration(
            color: _index == i ? ZiColors.primary : ZiColors.grayLight,
            borderRadius: BorderRadius.circular(ZiRadius.sm),
          ),
        ),
      ),
    );
  }
}

enum OnboardingStyles { s1BottomRow, s2SkipNext }
