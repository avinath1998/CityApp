part of 'garbage_type_selection_bloc.dart';

@immutable
abstract class GarbageTypeSelectionState {}

class GarbageTypeSelectionInitial extends GarbageTypeSelectionState {
  final List<GarbageType> garbageList;
  GarbageTypeSelectionInitial(this.garbageList);
}

class GarbageTypeSelectionChangedState extends GarbageTypeSelectionState {
  final List<GarbageType> garbageList;
  GarbageTypeSelectionChangedState(this.garbageList);
}
