import 'package:flutter/material.dart';

import '../../../../core/widgets/section_card.dart';
import '../../../../data/mock/mock_catalog.dart';
import '../../../../data/models/app_models.dart';

class LecturesPage extends StatefulWidget {
  const LecturesPage({super.key, required this.profile});

  final StudentProfile profile;

  @override
  State<LecturesPage> createState() => _LecturesPageState();
}

class _LecturesPageState extends State<LecturesPage> {
  late Programme _selectedProgramme;
  Course? _selectedCourse;
  Topic? _selectedTopic;

  @override
  void initState() {
    super.initState();
    _selectedProgramme = MockCatalog.programmeById(widget.profile.programmeId);
  }

  void _selectProgramme(Programme programme) {
    setState(() {
      _selectedProgramme = programme;
      _selectedCourse = null;
      _selectedTopic = null;
    });
  }

  void _selectCourse(Course course) {
    setState(() {
      _selectedCourse = course;
      _selectedTopic = null;
    });
  }

  void _selectTopic(Topic topic) {
    setState(() {
      _selectedTopic = topic;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Lectures')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lecture flow',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Programme -> Course -> Topic'),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: MockCatalog.programmes
                      .map(
                        (programme) => ChoiceChip(
                          label: Text(programme.name),
                          selected: programme.id == _selectedProgramme.id,
                          onSelected: (_) => _selectProgramme(programme),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader(
                  title: 'Courses',
                  subtitle: _selectedProgramme.description,
                ),
                const SizedBox(height: 16),
                ..._selectedProgramme.courses.map(
                  (course) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      tileColor: _selectedCourse?.id == course.id
                          ? const Color(0xFFE3F2F2)
                          : const Color(0xFFF8FBFD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      title: Text('${course.code} - ${course.name}'),
                      subtitle: Text(course.description),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _selectCourse(course),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (_selectedCourse != null)
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionHeader(
                    title: 'Topics',
                    subtitle: 'Select a topic to preview lecture, notes, quiz, and companion entry points.',
                  ),
                  const SizedBox(height: 16),
                  ..._selectedCourse!.topics.map(
                    (topic) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        tileColor: _selectedTopic?.id == topic.id
                            ? const Color(0xFFFFF4E1)
                            : const Color(0xFFF8FBFD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        title: Text(topic.title),
                        subtitle: Text(topic.summary),
                        trailing: const Icon(Icons.play_arrow_outlined),
                        onTap: () => _selectTopic(topic),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (_selectedCourse != null) const SizedBox(height: 16),
          if (_selectedTopic != null)
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedTopic!.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(_selectedTopic!.summary),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _TopicActionCard(
                          icon: Icons.ondemand_video_outlined,
                          title: 'Lecture',
                          subtitle: _selectedTopic!.videoDuration,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _TopicActionCard(
                          icon: Icons.description_outlined,
                          title: 'Notes',
                          subtitle: '${_selectedTopic!.notesCount} sections',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _TopicActionCard(
                          icon: Icons.quiz_outlined,
                          title: 'Topic Quiz',
                          subtitle: '${_selectedTopic!.questionBank.length} questions',
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: _TopicActionCard(
                          icon: Icons.support_agent_outlined,
                          title: 'Companion',
                          subtitle: 'Ask for guided help',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(color: const Color(0xFF486581)),
        ),
      ],
    );
  }
}

class _TopicActionCard extends StatelessWidget {
  const _TopicActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(subtitle, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
