import 'package:flutter/material.dart';

import '../../../../core/widgets/section_card.dart';
import '../../../../data/mock/mock_catalog.dart';
import '../../../../data/models/app_models.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.profile,
    required this.onOpenLectures,
    required this.onOpenQuizzes,
    required this.onEditProfile,
  });

  final StudentProfile profile;
  final VoidCallback onOpenLectures;
  final VoidCallback onOpenQuizzes;
  final VoidCallback onEditProfile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final programme = MockCatalog.programmeById(profile.programmeId);
    final spotlightCourse = programme.courses.first;
    final spotlightTopic = spotlightCourse.topics.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: onEditProfile,
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Reset onboarding',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0D5C63), Color(0xFFE09F3E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${programme.name} Level ${profile.level}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  profile.institution,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.92),
                  ),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.tonal(
                      onPressed: onOpenLectures,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.18),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Continue Lectures'),
                    ),
                    OutlinedButton(
                      onPressed: onOpenQuizzes,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white54),
                      ),
                      child: const Text('Open Quizzes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Continue learning',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${spotlightCourse.code} - ${spotlightTopic.title}',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  spotlightTopic.summary,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF486581),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _StatPill(
                      label: spotlightTopic.videoDuration,
                      icon: Icons.play_circle_outline,
                    ),
                    const SizedBox(width: 12),
                    _StatPill(
                      label: '${spotlightTopic.notesCount} notes',
                      icon: Icons.note_alt_outlined,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: onOpenLectures,
                  child: const Text('Go to Topic'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SectionCard(
                  child: _DashboardMetric(
                    title: 'Quiz streak',
                    value: '5 days',
                    detail: 'Immediate feedback practice is active.',
                    icon: Icons.local_fire_department_outlined,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SectionCard(
                  child: _DashboardMetric(
                    title: 'School server',
                    value: 'Ready',
                    detail: 'Wi-Fi sync placeholder for offline-first flow.',
                    icon: Icons.wifi_tethering_outlined,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subscription snapshot',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Premium preview enabled in mock mode. Downloaded content and lock behavior can plug into this area next.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardMetric extends StatelessWidget {
  const _DashboardMetric({
    required this.title,
    required this.value,
    required this.detail,
    required this.icon,
  });

  final String title;
  final String value;
  final String detail;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: theme.colorScheme.primary),
        const SizedBox(height: 16),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          detail,
          style: theme.textTheme.bodySmall?.copyWith(color: const Color(0xFF486581)),
        ),
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F8),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
