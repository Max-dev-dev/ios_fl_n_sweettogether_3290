import 'dart:async';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Player {
  final String name;
  final Color color;

  Player({required this.name, required this.color});
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            const Text(
              'A game for two',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 60.0),
            const Text(
              'The rules of the game:',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'It’s very simple: you and your partner answer questions about your relationship together or remotely, and you have to answer each question in 10 seconds.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StartGameScreen()),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(24),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Color(0xFF2E1212),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
}

class StartGameScreen extends StatelessWidget {
  const StartGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, 
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'A game for two',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/start_game_background.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  'Are you ready to play?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 50.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PlayersSetupScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(24),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Let\'s go!',
                        style: TextStyle(
                          color: Color(0xFF2E1212),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class PlayersSetupScreen extends StatefulWidget {
  const PlayersSetupScreen({super.key});

  @override
  State<PlayersSetupScreen> createState() => _PlayersSetupScreenState();
}

class _PlayersSetupScreenState extends State<PlayersSetupScreen> {
  final TextEditingController _player1NameController = TextEditingController();
  final TextEditingController _player2NameController = TextEditingController();

  Color _player1Color = Colors.blue;
  Color _player2Color = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned.fill(
        //   child: Container(color: Colors.pink.shade100),
        // ),
        Scaffold(
          //backgroundColor: Colors.transparent,
          appBar: AppBar(title: const Text('A game for two')),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text('Player 1'),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _player1NameController,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _player1Color =
                                  _player1Color == Colors.blue
                                      ? Colors.red
                                      : Colors.blue;
                            });
                          },
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: _player1Color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Player 2'),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _player2NameController,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _player2Color =
                                  _player2Color == Colors.purple
                                      ? Colors.green
                                      : Colors.purple;
                            });
                          },
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: _player2Color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 150),
                    GestureDetector(
                      onTap: () {
                        final player1 = Player(
                          name:
                              _player1NameController.text.isEmpty
                                  ? 'Player1'
                                  : _player1NameController.text,
                          color: _player1Color,
                        );
                        final player2 = Player(
                          name:
                              _player2NameController.text.isEmpty
                                  ? 'Player2'
                                  : _player2NameController.text,
                          color: _player2Color,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => QuestionScreen(
                                  player1: player1,
                                  player2: player2,
                                  questions: _questions,
                                ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Start',
                            style: TextStyle(
                              color: Color(0xFF2E1212),
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class QuestionScreen extends StatefulWidget {
  final Player player1;
  final Player player2;
  final List<String> questions;

  const QuestionScreen({
    super.key,
    required this.player1,
    required this.player2,
    required this.questions,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _turnIndex = 0;
  int _timeLeft = 10;
  Timer? _timer;

  void _shareQuestion() async {
    final currentQuestion = widget.questions[_turnIndex];

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('shared_questions') ?? [];
    if (!saved.contains(currentQuestion)) {
      saved.add(currentQuestion);
      await prefs.setStringList('shared_questions', saved);
    }

    await Share.share(currentQuestion);
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timeLeft = 10;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft--;
      });

      if (_timeLeft <= 0) {
        _nextTurn();
      }
    });
  }

  void _nextTurn() {
    _timer?.cancel();

    if (_turnIndex == 0) {
      setState(() {
        _turnIndex = 1;
      });
      _startTimer();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EndGameScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final player = _turnIndex == 0 ? widget.player1 : widget.player2;
    final question = widget.questions[_turnIndex];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              "A game for two",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border(top: BorderSide(color: player.color, width: 4)),
              ),
              child: Column(
                children: [
                  Text(
                    "Questions for the ‘${player.name}’ player",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _shareQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD684BD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      child: Text(
                        "Share",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    "Time left $_timeLeft is 10 second",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _timeLeft / 10.0,
                    backgroundColor: Colors.white,
                    color: player.color,
                    minHeight: 8,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: GestureDetector(
                onTap: _nextTurn,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Color(0xFF2E1212),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EndGameScreen extends StatelessWidget {
  const EndGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/added_background.png',
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Image.asset('assets/images/done_icon.png', height: 200),
                const Text(
                  'The end!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20.0),
                const Text(
                  'Congratulations on completing the game, we hope it was useful for you and you learned something new about each other.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(24),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Back home',
                        style: TextStyle(
                          color: Color(0xFF2E1212),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

final List<String> _questions = [
  "What's your partner's favorite color?",
  "What's their dream vacation destination?",
  "What's your partner's biggest fear?",
  "What is their favorite type of music?",
  "What is their go-to comfort food?",
  "What’s the most embarrassing thing that’s happened to your partner?",
  "What's their favorite season of the year?",
  "What’s your partner’s biggest pet peeve?",
  "What was the first movie you watched together?",
  "What’s your partner’s favorite hobby?",
  "What’s your partner's guilty pleasure TV show?",
  "What is their favorite type of cuisine?",
  "What's your partner's favorite holiday?",
  "What’s their dream job?",
  "What’s their favorite animal?",
  "What’s the best gift your partner ever gave you?",
  "What’s your partner's favorite childhood memory?",
  "What is something that always makes them laugh?",
  "What's their idea of a perfect day together?",
  "What’s something your partner can’t live without?",
  "What's their most embarrassing childhood story?",
  "What’s their biggest talent?",
  "What's your partner's favorite dessert?",
  "What’s their idea of a perfect date night?",
  "What’s their favorite book or author?",
  "What’s your partner's favorite way to relax?",
  "What’s their dream car?",
  "What's the most adventurous thing they've ever done?",
  "What’s their favorite sport to watch?",
  "What’s something they’ve always wanted to learn?",
  "What’s their favorite place to go on a date?",
  "What’s your partner's least favorite food?",
  "What’s their favorite type of movie?",
  "What’s their favorite type of weather?",
  "What’s their favorite song?",
  "What’s their go-to drink order?",
  "What’s their favorite board game?",
  "What’s your partner’s favorite activity to do together?",
  "What’s their biggest achievement?",
  "What’s your partner’s favorite TV series?",
  "What’s their favorite place to relax?",
  "What’s their idea of a fun day out?",
  "What’s their dream vacation activity?",
  "What’s their favorite clothing brand?",
  "What’s your partner’s biggest goal in life?",
  "What’s their most memorable travel experience?",
  "What’s their biggest insecurity?",
  "What’s their favorite way to spend time alone?",
  "What’s something they love about you?",
  "What’s their favorite game to play together?",
  "What’s your partner's favorite memory of you two together?",
  "What’s their dream house like?",
  "What’s the most romantic thing they’ve done for you?",
  "What’s their favorite thing about your relationship?",
  "What’s their favorite sport to play?",
  "What’s their favorite type of vacation (beach, mountain, city)?",
  "What’s the most thoughtful gift your partner has ever received?",
];
