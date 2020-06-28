import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/models/garbage_type.dart';
import 'package:meta/meta.dart';

part 'garbage_type_selection_event.dart';
part 'garbage_type_selection_state.dart';

class GarbageTypeSelectionBloc
    extends Bloc<GarbageTypeSelectionEvent, GarbageTypeSelectionState> {
  List<GarbageType> _selectedGarbageType = List();

  @override
  GarbageTypeSelectionState get initialState =>
      GarbageTypeSelectionInitial(_selectedGarbageType);

  @override
  Stream<GarbageTypeSelectionState> mapEventToState(
    GarbageTypeSelectionEvent event,
  ) async* {
    if (event is GarbageTypeAddedEvent) {
      print("event");

      GarbageType selectedType = _selectedGarbageType.firstWhere((type) {
        if (type.garbageType == event._garbageTypeSelection.garbageType) {
          print("found");
          return true;
        } else {
          return false;
        }
      }, orElse: () {
        print("not");
        return null;
      });

      if (selectedType != null) {
        selectedType.count += 1;
        print("is not null");
      } else {
        print("is null");
        _selectedGarbageType.add(event._garbageTypeSelection);
      }
      yield (GarbageTypeSelectionChangedState(_selectedGarbageType));
    } else if (event is GarbageTypeRemovedEvent) {
      GarbageType selectedType = _selectedGarbageType.firstWhere((type) {
        if (type.garbageType == event._garbageTypeSelection.garbageType) {
          return true;
        } else {
          return false;
        }
      }, orElse: () {
        return null;
      });

      if (selectedType != null) {
        if (selectedType.count == 1) {
          _selectedGarbageType.remove(event._garbageTypeSelection);
        } else {
          selectedType.count -= 1;
        }
      }
    }
    yield (GarbageTypeSelectionChangedState(_selectedGarbageType));
  }
}
