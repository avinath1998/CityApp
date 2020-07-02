import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:citycollection/networking/db.dart';
import 'package:citycollection/screens/onboarding_screen.dart';
import 'package:citycollection/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //BlocProvider.of<AuthBloc>(context).add(CheckIfSignedInEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, AuthState state) {
        return AnimatedSwitcher(
          duration: Duration(seconds: 2),
          switchInCurve: Curves.easeOut,
          layoutBuilder: (context, widgets) {
            if (state is SignedInState) {
              return HomeScreen();
            } else if (state is SignedOutState) {
              return OnboardingScreen(isWaiting: false);
            } else if (state is SignInFailedState) {
              return OnboardingScreen(errorMsg: state.errorMsg);
            } else if (state is SigningInWaitingState) {
              return OnboardingScreen(isWaiting: true);
            } else if (state is AuthInitial) {
              return OnboardingScreen(isWaiting: false);
            } else {
              return OnboardingScreen(isWaiting: false);
            }
          },
        );
      },
    );
  }
}
