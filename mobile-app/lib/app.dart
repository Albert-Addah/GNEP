import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'data/models/app_models.dart';
import 'features/navigation/presentation/pages/main_navigation_shell.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';

class NepApp extends StatefulWidget {
  const NepApp({super.key});

  @override
  State<NepApp> createState() => _NepAppState();
}

class _NepAppState extends State<NepApp> {
  StudentProfile? _profile;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NEP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: _profile == null
          ? OnboardingPage(
              onComplete: (profile) {
                setState(() {
                  _profile = profile;
                });
              },
            )
          : MainNavigationShell(
              profile: _profile!,
              onResetOnboarding: () {
                setState(() {
                  _profile = null;
                });
              },
            ),
    );
  }
}
