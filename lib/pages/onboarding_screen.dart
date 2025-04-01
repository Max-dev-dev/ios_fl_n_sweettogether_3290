import 'package:flutter/material.dart';
import 'package:ios_fl_sweet_bonanza_3290/pages/tabs_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  final List<String> _imagePaths = [
    'assets/images/onboarding_images/1.png',
    'assets/images/onboarding_images/2.png',
    'assets/images/onboarding_images/3.png',
    'assets/images/onboarding_images/4.png',
    'assets/images/onboarding_images/5.png',
  ];

  final List<String> _buttonTexts = [
    "Next",
    "Next",
    "Next",
    "Next",
    "Start Now",
  ];

  void _nextPage() {
    if (_currentIndex < _imagePaths.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TabsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(_imagePaths[_currentIndex], fit: BoxFit.fill),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: _nextPage,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white
                ),
                child: Center(
                  child: Text(
                    _buttonTexts[_currentIndex],
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF2E1212),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
