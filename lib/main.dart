import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/networking/db.dart';
import 'package:citycollection/networking/repositories/bin_disposal_repository.dart';
import 'package:citycollection/screens/got_trash_screen.dart';
import 'package:citycollection/screens/home_screen.dart';
import 'package:citycollection/screens/login_screen.dart';
import 'package:citycollection/screens/registration_screen.dart';
import 'package:citycollection/screens/root_page.dart';
import 'package:citycollection/screens/take_picture_screen.dart';
import 'package:citycollection/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/bin_disposal/bin_disposal_bloc.dart';
import 'models/tagged_bin.dart';
import 'networking/data_repository.dart';

void main() {
  FirebaseDB db = FirebaseDB();
  GetIt.instance.registerSingleton<DataRepository>(DataRepository(db));
  GetIt.instance
      .registerSingleton<BinDisposalRepository>(BinDisposalRepository(db));
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.loggerName} ${record.message}');
  });
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(FirebaseAuthService()),
          ),
          BlocProvider<BinDisposalBloc>(
            create: (context) =>
                BinDisposalBloc(GetIt.instance<BinDisposalRepository>()),
          ),
        ],
        child: MaterialApp(
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.of(context).locale,
          title: 'CityApp',
          initialRoute: LoginScreen.routeName,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case LoginScreen.routeName:
                final Map<String, dynamic> map = settings.arguments;
                return MaterialPageRoute(builder: (context) {
                  return LoginScreen(
                    isWaiting: map != null ? map["isWaiting"] : false,
                    errorMsg: map != null ? map["errorMsg"] : null,
                  );
                });
              case RegistrationScreen.routeName:
                return MaterialPageRoute(builder: (context) {
                  return RegistrationScreen();
                });
              case HomeScreen.routeName:
                return MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                });
              case TakePictureScreen.routeName:
                return MaterialPageRoute(builder: (context) {
                  final Map<String, dynamic> map = settings.arguments;
                  return TakePictureScreen(
                    message: map["message"],
                  );
                });
              case TakePictureScreen.routeName:
                return MaterialPageRoute(builder: (context) {
                  final Map<String, dynamic> map = settings.arguments;
                  return TakePictureScreen(
                    message: map["message"],
                  );
                });
              case GotTrashScreen.routeName:
                return MaterialPageRoute(builder: (context) {
                  final Map<String, dynamic> map = settings.arguments;
                  return GotTrashScreen(
                    selectedBin: map["taggedBin"],
                  );
                });
            }
          },
          theme: ThemeData(
              dialogTheme: DialogTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)))),
              primarySwatch: CityColors.primary_teal,
              accentColor: CityColors.primary_teal,
              backgroundColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              cardColor: Colors.white,
              errorColor: Colors.redAccent,
              appBarTheme: AppBarTheme(
                  color: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black)),
              buttonColor: CityColors.primary_teal,
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  buttonColor: CityColors.primary_teal),
              textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context)
                  .textTheme
                  .copyWith(
                    button: Theme.of(context).textTheme.button.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    bodyText1: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black),
                    subtitle1: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: CityColors.primary_teal,
                        fontWeight: FontWeight.bold),
                    subtitle2: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    headline1: Theme.of(context).textTheme.headline1.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    headline2: Theme.of(context).textTheme.headline2.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    headline3: Theme.of(context).textTheme.headline3.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    headline4: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    headline5: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    headline6: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ))),
          home: RootPage(),
        ));
  }
}
