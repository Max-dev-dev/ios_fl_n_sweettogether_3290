import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ios_fl_sweet_bonanza_3290/cubit/event_cubit/event_cubit.dart';
import 'package:intl/intl.dart';

class CalendarEventScreen extends StatefulWidget {
  const CalendarEventScreen({super.key});

  @override
  State<CalendarEventScreen> createState() => _CalendarEventScreenState();
}

class _CalendarEventScreenState extends State<CalendarEventScreen> {
  bool isListView = false;
  final DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Calendar of events',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddEventStep1Screen(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Text(
                      'Add an event',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF2E1212),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isListView = !isListView;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      isListView ? 'View as calendar' : 'View by list',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF2E1212),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              isListView ? _buildEventList() : _buildCalendar(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return BlocBuilder<CalendarEventCubit, List<CalendarEventModel>>(
      builder: (context, events) {
        final eventDates = events.map((e) => _normalizeDate(e.date)).toSet();

        return Container(
          height: 420,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.all(12),
          child: TableCalendar(
            focusedDay: today,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              leftChevronIcon: const Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
              rightChevronIcon: const Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.black),
              weekdayStyle: TextStyle(color: Colors.black),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: Color(0xFFFF81D8),
                shape: BoxShape.circle,
              ),
              markerDecoration: const BoxDecoration(
                color: Color(0xFFFF81D8),
                shape: BoxShape.circle,
              ),
              defaultTextStyle: const TextStyle(color: Colors.black),
              weekendTextStyle: const TextStyle(color: Colors.black),
            ),
            selectedDayPredicate: (day) {
              return eventDates.contains(_normalizeDate(day));
            },
            onDaySelected: (selectedDay, focusedDay) {},
          ),
        );
      },
    );
  }

  Widget _buildEventList() {
    return BlocBuilder<CalendarEventCubit, List<CalendarEventModel>>(
      builder: (context, events) {
        if (events.isEmpty) {
          return const Text('No events yet.');
        }

        final sorted = [...events]..sort((a, b) => a.date.compareTo(b.date));

        return Column(
          children:
              sorted.map((event) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd.MM.yyyy').format(event.date),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          final formattedDate = DateFormat(
                            'dd MMMM yyyy',
                          ).format(event.date);
                          final message = '''


📅 When: $formattedDate
📌 What: ${event.title}

${event.description}

Let's make this day unforgettable 🌟
''';

                          Share.share(message);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 40,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFDF89C5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Share',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}

class AddEventStep1Screen extends StatefulWidget {
  const AddEventStep1Screen({super.key});

  @override
  State<AddEventStep1Screen> createState() => _AddEventStep1ScreenState();
}

class _AddEventStep1ScreenState extends State<AddEventStep1Screen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adding new event',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title'),
              SizedBox(height: 10.0),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Description '),
              SizedBox(height: 10.0),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Have a date by the sea at sunset',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => AddEventStep2Screen(
                            title: _titleController.text,
                            description: _descriptionController.text,
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
            ],
          ),
        ),
      ),
    );
  }
}

class AddEventStep2Screen extends StatefulWidget {
  final String title;
  final String description;

  const AddEventStep2Screen({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<AddEventStep2Screen> createState() => _AddEventStep2ScreenState();
}

class _AddEventStep2ScreenState extends State<AddEventStep2Screen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
       // backgroundColor: Colors.transparent,
        title: const Text(
          'Adding new event',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate,
                onDateTimeChanged: (date) {
                  selectedDate = date;
                },
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                final event = CalendarEventModel(
                  title: widget.title,
                  description: widget.description,
                  date: selectedDate,
                );

                context.read<CalendarEventCubit>().addEvent(event);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const EventSuccessScreen()),
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
                    'Ok',
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
    );
  }
}

class EventSuccessScreen extends StatelessWidget {
  const EventSuccessScreen({super.key});

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
                  'Successfully added an event',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
                        'Done',
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
