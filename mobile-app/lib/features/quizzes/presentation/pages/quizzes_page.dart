import 'package:flutter/material.dart';

import '../../../../core/widgets/section_card.dart';
import '../../../../data/mock/mock_catalog.dart';
import '../../../../data/models/app_models.dart';

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({super.key, required this.profile});

  final StudentProfile profile;

  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  QuizMode _mode = QuizMode.topic;
  List<QuizQuestion> _questions = const [];
  int _currentIndex = 0;
  int? _selectedAnswer;
  int _score = 0;
  bool _showSummary = false;

  @override
  void initState() {
    super.initState();
    _startQuiz();
  }

  void _startQuiz() {
    setState(() {
      _questions = MockCatalog.questionsForProfile(widget.profile, _mode);
      _currentIndex = 0;
      _selectedAnswer = null;
      _score = 0;
      _showSummary = false;
    });
  }

  void _selectAnswer(int index) {
    if (_selectedAnswer != null) {
      return;
    }

    final isCorrect = index == _questions[_currentIndex].correctIndex;

    setState(() {
      _selectedAnswer = index;
      if (isCorrect) {
        _score += 1;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex == _questions.length - 1) {
      setState(() {
        _showSummary = true;
      });
      return;
    }

    setState(() {
      _currentIndex += 1;
      _selectedAnswer = null;
    });
  }

  String get _modeLabel {
    return switch (_mode) {
      QuizMode.topic => 'Topic Quiz',
      QuizMode.course => 'Course Practice',
      QuizMode.level => 'Level Practice',
      QuizMode.mockExam => 'Mock Exam',
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Quizzes')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Practice area',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Mocked to match the immediate-feedback practice behavior in AGENTS.md.'),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: QuizMode.values
                      .map(
                        (mode) => ChoiceChip(
                          label: Text(
                            switch (mode) {
                              QuizMode.topic => 'Topic Quiz',
                              QuizMode.course => 'Course Practice',
                              QuizMode.level => 'Level Practice',
                              QuizMode.mockExam => 'Mock Exam',
                            },
                          ),
                          selected: _mode == mode,
                          onSelected: (_) {
                            setState(() {
                              _mode = mode;
                            });
                            _startQuiz();
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (_questions.isNotEmpty && !_showSummary)
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$_modeLabel - Question ${_currentIndex + 1} of ${_questions.length}',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: (_currentIndex + 1) / _questions.length,
                    minHeight: 10,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _questions[_currentIndex].prompt,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(
                    _questions[_currentIndex].options.length,
                    (index) {
                      final option = _questions[_currentIndex].options[index];
                      final selected = _selectedAnswer == index;
                      final isCorrect = index == _questions[_currentIndex].correctIndex;

                      Color? tileColor;
                      if (_selectedAnswer != null) {
                        if (isCorrect) {
                          tileColor = const Color(0xFFDFF6E5);
                        } else if (selected) {
                          tileColor = const Color(0xFFFDE6E6);
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          onTap: () => _selectAnswer(index),
                          tileColor: tileColor ?? const Color(0xFFF8FBFD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          title: Text(option),
                        ),
                      );
                    },
                  ),
                  if (_selectedAnswer != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _selectedAnswer == _questions[_currentIndex].correctIndex ? 'Correct' : 'Not quite',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: _selectedAnswer == _questions[_currentIndex].correctIndex
                            ? const Color(0xFF12733D)
                            : const Color(0xFFB42318),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(_questions[_currentIndex].explanation),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _nextQuestion,
                      child: Text(
                        _currentIndex == _questions.length - 1 ? 'Finish Practice' : 'Next Question',
                      ),
                    ),
                  ],
                ],
              ),
            ),
          if (_showSummary)
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Practice complete',
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text('You scored $_score out of ${_questions.length} in $_modeLabel.'),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _startQuiz,
                    child: const Text('Practice Again'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
