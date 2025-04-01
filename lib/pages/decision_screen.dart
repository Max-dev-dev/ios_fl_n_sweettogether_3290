import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_sweet_bonanza_3290/cubit/saved_objectives/saved_objectives_cubit.dart';
import 'package:share_plus/share_plus.dart';

class DecisionScreen extends StatefulWidget {
  const DecisionScreen({super.key});

  @override
  State<DecisionScreen> createState() => _DecisionScreenState();
}

class _DecisionScreenState extends State<DecisionScreen> {
  bool showTabs = false;
  int currentIndex = 0;
  late List<String> selectedObjectives;

  final List<String> allObjectives = [
    'Plan a surprise date for your partner.',
    'Cook a meal together.',
    'Give your partner a compliment they’ve never heard before.',
    'Share a meaningful memory with your partner.',
    'Hold hands for 10 minutes without saying a word.',
    'Watch the sunset or sunrise together.',
    'Plan your dream vacation together.',
    'Share a song that reminds you of your partner.',
    'Send a thoughtful message to your partner during the day.',
    'Compliment each other’s appearance in a creative way.',
    'Surprise your partner with their favorite treat or snack.',
    'Take a walk together, hand in hand, and talk about your future.',
    'Make a playlist of songs that remind you of your relationship.',
    'Take a 10-minute break from everything and just cuddle.',
    'Share a funny story that made you laugh today.',
    'Ask your partner what their perfect day would look like.',
    'Try a new activity or hobby together.',
    'Send a message with only emojis to express how you feel.',
    'Give your partner a meaningful gift that reminds you of them.',
    'Plan a romantic picnic, even if it’s indoors.',
    'Create a photo album of your favorite moments together.',
    'Share three things you love about each other.',
    'Create a list of relationship goals together.',
    'Do something thoughtful for your partner without them asking.',
    'Write down your wishes for your partner in the coming year.',
    'Watch a romantic movie and hold each other close.',
    'Share an inside joke and laugh together.',
    'Spend the day doing something your partner loves, even if it’s not your thing.',
    'Send a random “I love you” text during the day.',
    'Write a love letter to each other.',
  ];

  void generateObjectives() {
    final random = Random();
    final shuffled = [...allObjectives]..shuffle(random);
    setState(() {
      selectedObjectives = shuffled.take(2).toList();
      showTabs = true;
      currentIndex = 0;
    });
  }

  void shareObjective(String text) {
    final message = '''
💕 Today's relationship challenge:

$text

Let's keep the spark alive!
#RomanticChallenge
''';
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/decision_background.png',
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: showTabs ? _buildTabsView() : _buildStartView(),
          ),
        ),
      ],
    );
  }

  Widget _buildStartView() {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        const Text(
          'Decision generator',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: generateObjectives,
          child: Container(
            margin: const EdgeInsets.all(24),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/decision_icon.png'),
                  const SizedBox(width: 10.0),
                  const Text(
                    'Get an assignment',
                    style: TextStyle(
                      color: Color(0xFF2E1212),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 100.0),
      ],
    );
  }

  Widget _buildTabsView() {
    final text = selectedObjectives[currentIndex];
    final isSaved = context.watch<SavedObjectivesCubit>().isSaved(text);

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          const Text(
            'Decision generator',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 100),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Text('Day 1', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 12),
                Text(
                  'Objectives ${currentIndex + 1}:',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                if (currentIndex == 0)
                  _pinkButton('Next', () => setState(() => currentIndex = 1)),
                if (currentIndex == 1)
                  _pinkButton(
                    'Previous',
                    () => setState(() => currentIndex = 0),
                  ),
                const SizedBox(height: 12),
                _pinkButton('Share', () => shareObjective(text)),
                const SizedBox(height: 12),
                isSaved
                    ? _yellowButton('Saved', () {})
                    : _pinkButton('Save', () {
                      context.read<SavedObjectivesCubit>().addObjective(text);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pinkButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
        decoration: BoxDecoration(
          color: const Color(0xFFDF89C5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _yellowButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
        decoration: BoxDecoration(
          color: const Color(0xFFFED766),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}

class SavedObjectivesScreen extends StatelessWidget {
  const SavedObjectivesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final saved = context.watch<SavedObjectivesCubit>().state;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Saved',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              if (saved.isEmpty)
                SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'You have not stored anything yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: saved.length,
                    itemBuilder: (context, index) {
                      final objective = saved[index];
                      final isLast = index == saved.length - 1;

                      return Container(
                        margin: EdgeInsets.only(bottom: isLast ? 100 : 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Objectives ${index + 1}:',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(objective),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    final message = '''
💕 Here's something we saved to do together:

$objective

Still up for it? 💌
''';
                                    Share.share(message);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 24,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFDF89C5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'Share',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<SavedObjectivesCubit>()
                                        .removeObjective(objective);
                                  },
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Color(0xFFDF89C5),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
