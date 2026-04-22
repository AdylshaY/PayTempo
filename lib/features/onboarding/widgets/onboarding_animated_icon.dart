import 'package:flutter/material.dart';
import 'package:subscription_tracker/app/theme/app_theme.dart';
import 'package:lottie/lottie.dart';

class OnboardingAnimatedIcon extends StatefulWidget {
  const OnboardingAnimatedIcon({super.key});

  @override
  State<OnboardingAnimatedIcon> createState() => _OnboardingAnimatedIconState();
}

class _OnboardingAnimatedIconState extends State<OnboardingAnimatedIcon>
    with SingleTickerProviderStateMixin {
  static const String _assetPath = 'assets/lottie/onboarding_lottie.json';

  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 0.94,
      end: 1.04,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double size = (constraints.maxWidth * 0.75).clamp(0.0, 400.0);
        final double innerPadding = size * 0.1;

        return ScaleTransition(
          scale: _scale,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(innerPadding),
            child: Lottie.asset(
              _assetPath,
              repeat: true,
              animate: true,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
