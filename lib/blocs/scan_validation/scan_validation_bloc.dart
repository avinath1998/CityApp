import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scan_validation_event.dart';
part 'scan_validation_state.dart';

class ScanValidationBloc extends Bloc<ScanValidationEvent, ScanValidationState> {
  @override
  ScanValidationState get initialState => ScanValidationInitial();

  @override
  Stream<ScanValidationState> mapEventToState(
    ScanValidationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
