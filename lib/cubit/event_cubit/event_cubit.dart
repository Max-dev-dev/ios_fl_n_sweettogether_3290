import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarEventModel {
  final String title;
  final String description;
  final DateTime date;

  CalendarEventModel({
    required this.title,
    required this.description,
    required this.date,
  });
}


class CalendarEventCubit extends Cubit<List<CalendarEventModel>> {
  CalendarEventCubit() : super([]);

  void addEvent(CalendarEventModel event) {
    final updated = List<CalendarEventModel>.from(state)..add(event);
    emit(updated);
  }
}
