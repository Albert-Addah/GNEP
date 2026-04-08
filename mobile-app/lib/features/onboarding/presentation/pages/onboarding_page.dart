import 'package:flutter/material.dart';

import '../../../../core/widgets/section_card.dart';
import '../../../../data/mock/mock_catalog.dart';
import '../../../../data/models/app_models.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, required this.onComplete});

  final ValueChanged<StudentProfile> onComplete;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();
  final _institutionController = TextEditingController();

  String? _programmeId;
  String? _level;

  @override
  void dispose() {
    _contactController.dispose();
    _institutionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.onComplete(
      StudentProfile(
        contact: _contactController.text.trim(),
        programmeId: _programmeId!,
        level: _level!,
        institution: _institutionController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0D5C63), Color(0xFF247B7B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NEP',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Set up your student profile to unlock lectures, quizzes, and guided exam prep.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SectionCard(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Onboarding',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Phone or email, programme, level, and institution only.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF486581),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _contactController,
                      decoration: const InputDecoration(
                        labelText: 'Phone or Email',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your phone or email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _programmeId,
                      decoration: const InputDecoration(labelText: 'Programme'),
                      items: MockCatalog.programmes
                          .map(
                            (programme) => DropdownMenuItem(
                              value: programme.id,
                              child: Text(programme.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => _programmeId = value),
                      validator: (value) => value == null ? 'Select a programme' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _level,
                      decoration: const InputDecoration(labelText: 'Level'),
                      items: MockCatalog.levels
                          .map(
                            (level) => DropdownMenuItem(
                              value: level,
                              child: Text(level),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => _level = value),
                      validator: (value) => value == null ? 'Select your level' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _institutionController,
                      decoration: const InputDecoration(
                        labelText: 'Institution',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your institution';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _submit,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        child: const Text('Continue to Dashboard'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
