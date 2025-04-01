import 'package:flutter/material.dart';
import 'package:ios_fl_sweet_bonanza_3290/pages/calendar_event_screen.dart';
import 'package:ios_fl_sweet_bonanza_3290/pages/decision_screen.dart';
import 'package:ios_fl_sweet_bonanza_3290/pages/game_screen.dart';

class TabsScreen extends StatefulWidget {
  final int initialTabIndex;

  const TabsScreen({super.key, this.initialTabIndex = 0});

  @override
  TabsScreenState createState() => TabsScreenState();
}

class TabsScreenState extends State<TabsScreen> {
  late int selectedIndex;

  final List<Widget> _pages = [
    SavedObjectivesScreen(),
    CalendarEventScreen(),
    DecisionScreen(),
    GameScreen(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialTabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[selectedIndex],
          Positioned(
            bottom: 40,
            left: 30,
            right: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTabItem(0, Icons.bookmark_border),
                  _buildTabItem(1, Icons.calendar_today_outlined, isPink: true),
                  _buildTabItem(2, Icons.favorite_border),
                  _buildTabItem(3, Icons.question_answer_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, IconData iconData, {bool isPink = false}) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Icon(
        iconData,
        size: 30,
        color:
            isSelected
                ? Color(0xFFB22E89)
                : Colors.black.withOpacity(0.6),
      ),
    );
  }
}
