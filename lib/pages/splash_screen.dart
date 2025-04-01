import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ios_fl_sweet_bonanza_3290/pages/onboarding_screen.dart';
import 'package:ios_fl_sweet_bonanza_3290/pages/tabs_screen.dart';

class FirstRunService {
  static final FirstRunService _instance = FirstRunService._internal();

  bool _firstRun = true;

  factory FirstRunService() => _instance;

  FirstRunService._internal();

  bool get isFirstRun => _firstRun;

  void markAsCompleted() {
    _firstRun = false;
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  void _handleNavigation() {
    final isFirstRun = FirstRunService().isFirstRun;

    if (isFirstRun) {
      FirstRunService().markAsCompleted();
    }

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => isFirstRun ? OnboardingScreen() : const TabsScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/splash_background.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
