import 'package:flutter_bloc/flutter_bloc.dart';

class SavedObjectivesCubit extends Cubit<List<String>> {
  SavedObjectivesCubit() : super([]);

  void addObjective(String objective) {
    if (!state.contains(objective)) {
      emit([...state, objective]);
    }
  }

  void removeObjective(String objective) {
    emit(state.where((item) => item != objective).toList());
  }

  bool isSaved(String objective) => state.contains(objective);
}
