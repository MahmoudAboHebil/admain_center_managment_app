import 'package:admain_center_managment_app/contexts/center_management_context/presentation/bloc/selection_cubit/selection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectionCubit extends Cubit<SelectionState> {
  SelectionCubit() : super(const SelectionState());

  /// start selection (long press)
  void startSelection(String id) {
    emit(state.copyWith(isSelectionMode: true, selectedIds: {id}));
  }

  /// toggle item
  void toggleSelection(String id) {
    final newSet = Set<String>.from(state.selectedIds);

    if (newSet.contains(id)) {
      newSet.remove(id);
    } else {
      newSet.add(id);
    }

    emit(
      state.copyWith(selectedIds: newSet, isSelectionMode: newSet.isNotEmpty),
    );
  }

  /// clear all
  void clearSelection() {
    emit(const SelectionState());
  }

  /// select all
  void selectAll(List<String> ids) {
    emit(state.copyWith(selectedIds: ids.toSet(), isSelectionMode: true));
  }
}
