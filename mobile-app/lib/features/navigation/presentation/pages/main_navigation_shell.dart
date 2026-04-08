import 'package:flutter/material.dart';

import '../../../../data/models/app_models.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../lectures/presentation/pages/lectures_page.dart';
import '../../../quizzes/presentation/pages/quizzes_page.dart';
import '../../../shared/presentation/pages/placeholder_page.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({
    super.key,
    required this.profile,
    required this.onResetOnboarding,
  });

  final StudentProfile profile;
  final VoidCallback onResetOnboarding;

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _selectedIndex = 0;

  void _goToTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        profile: widget.profile,
        onOpenLectures: () => _goToTab(1),
        onOpenQuizzes: () => _goToTab(2),
        onEditProfile: widget.onResetOnboarding,
      ),
      LecturesPage(profile: widget.profile),
      QuizzesPage(profile: widget.profile),
      const PlaceholderPage(
        title: 'Exam Hall',
        subtitle: 'Reserved for locked, time-controlled institutional exams.',
        icon: Icons.shield_outlined,
      ),
      const PlaceholderPage(
        title: 'Companion',
        subtitle: 'This tab will host the calm, admin-approved AI tutor experience.',
        icon: Icons.support_agent_outlined,
      ),
      const PlaceholderPage(
        title: 'Library',
        subtitle: 'This tab will surface downloaded lectures, notes, and quizzes.',
        icon: Icons.local_library_outlined,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _goToTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Lectures',
          ),
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz),
            label: 'Quizzes',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'Exam Hall',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Companion',
          ),
          NavigationDestination(
            icon: Icon(Icons.library_books_outlined),
            selectedIcon: Icon(Icons.library_books),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}
