class SelectionState {
  final Set<String> selectedIds;
  final bool isSelectionMode;

  const SelectionState({
    this.selectedIds = const {},
    this.isSelectionMode = false,
  });

  SelectionState copyWith({Set<String>? selectedIds, bool? isSelectionMode}) {
    return SelectionState(
      selectedIds: selectedIds ?? this.selectedIds,
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
    );
  }
}
