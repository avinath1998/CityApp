import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:citycollection/networking/db.dart';
import 'package:citycollection/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'home_screen.dart';
import 'large_loading_screen.dart';
import 'login_screen.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  GetIt getIt = GetIt.instance;
  final AuthBloc _authBloc = AuthBloc(FirebaseAuthService());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIt.registerSingleton(DataRepository(FirebaseDB()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authBloc.add(CheckIfSignedInEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => _authBloc,
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, AuthState state) {
            if (state is SignedInState) {
              return HomeScreen();
            } else if (state is SignedOutState) {
              return LoginScreen();
            } else if (state is SignInFailedState) {
              return LoginScreen(errorMsg: state.errorMsg);
            } else if (state is SigningInWaitingState) {
              return LoginScreen(isWaiting: true);
            } else if (state is AuthInitial) {
              return LoginScreen();
            }
          },
        ));
  }
}
