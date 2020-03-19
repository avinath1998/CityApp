import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'appbar_event.dart';
part 'appbar_state.dart';

class AppbarBloc extends Bloc<AppbarEvent, AppbarState> {
  @override
  AppbarState get initialState => AppbarInitial();

  @override
  Stream<AppbarState> mapEventToState(
    AppbarEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
