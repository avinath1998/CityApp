import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scan_validation_event.dart';
part 'scan_validation_state.dart';

class ScanValidationBloc
    extends Bloc<ScanValidationEvent, ScanValidationState> {
  ScanValidationBloc() : super(ScanValidationInitial());

  @override
  Stream<ScanValidationState> mapEventToState(
    ScanValidationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
