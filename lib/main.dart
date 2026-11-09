import 'package:flutter/material.dart';

// Real-world scenario: a student help center where each question
// expands to show its answer, so the screen stays short and scannable.

void main() => runApp(const HelpCenterApp());

class HelpCenterApp extends StatelessWidget {
  const HelpCenterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Help Center',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const HelpCenterScreen(),
    );
  }
}

class Faq {
  final IconData icon;
  final String question;
  final String answer;
  const Faq(this.icon, this.question, this.answer);
}

const faqs = [
  Faq(Icons.wifi, 'How do I connect to campus Wi-Fi?',
      'Choose the "Campus-Students" network and sign in with your student email and portal password.'),
  Faq(Icons.menu_book, 'Where can I find my course materials?',
      'Open Canvas, go to Courses, and select your course. Slides and readings are under Modules.'),
  Faq(Icons.event, 'How do I book a meeting with my facilitator?',
      'Use the booking link in your course Announcements, or email your facilitator directly.'),
  Faq(Icons.local_library, 'When is the library open?',
      'Monday to Friday, 8:00 AM to 10:00 PM. Saturday, 9:00 AM to 5:00 PM.'),
  Faq(Icons.support_agent, 'Who do I contact for IT problems?',
      'Email the IT help desk with your student ID and a screenshot of the problem.'),
];

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  // Tracks which questions the student has opened.
  // Starts with 0 because the first tile is open on launch.
  final Set<int> _viewed = {0};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Help Center'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(child: Text('Viewed ${_viewed.length}/${faqs.length}')),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            clipBehavior: Clip.antiAlias,
            child: ExpansionTile(
              leading: Icon(faq.icon),
              title: Text(
                faq.question,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),

              // PROPERTY 1: initiallyExpanded
              // Opens the first question when the screen loads,
              // so the most common question is answered right away.
              initiallyExpanded: index == 0,

              // PROPERTY 2: backgroundColor
              // Tints the tile while it is open, so the student can
              // see which answer they are reading.
              backgroundColor: Colors.teal.shade50,

              // PROPERTY 3: onExpansionChanged
              // Runs every time the tile opens or closes. Here it
              // updates the "Viewed" counter in the app bar.
              onExpansionChanged: (isOpen) {
                if (isOpen) setState(() => _viewed.add(index));
              },

              // Layout only (not one of the three demo properties).
              shape: const Border(),
              collapsedShape: const Border(),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              expandedAlignment: Alignment.centerLeft,
              children: [Text(faq.answer)],
            ),
          );
        },
      ),
    );
  }
}
