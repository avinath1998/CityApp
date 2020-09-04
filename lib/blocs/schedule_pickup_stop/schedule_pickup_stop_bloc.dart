import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:citycollection/networking/data_repository.dart';

part 'schedule_pickup_stop_event.dart';
part 'schedule_pickup_stop_state.dart';

class SchedulePickupStopBloc
    extends Bloc<SchedulePickupStopEvent, SchedulePickupStopState> {
  final DataRepository _dataRepository;

  SchedulePickupStopBloc(this._dataRepository)
      : super(SchedulePickupStopInitial());
  @override
  Stream<SchedulePickupStopState> mapEventToState(
    SchedulePickupStopEvent event,
  ) async* {}
}
