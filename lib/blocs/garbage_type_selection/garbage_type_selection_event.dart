part of 'garbage_type_selection_bloc.dart';

@immutable
abstract class GarbageTypeSelectionEvent {}

class GarbageTypeAddedEvent extends GarbageTypeSelectionEvent {
  final GarbageType _garbageTypeSelection;
  GarbageTypeAddedEvent(this._garbageTypeSelection);
}

class GarbageTypeRemovedEvent extends GarbageTypeSelectionEvent {
  final GarbageType _garbageTypeSelection;
  GarbageTypeRemovedEvent(this._garbageTypeSelection);
}
