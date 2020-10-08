import 'package:citycollection/blocs/tagged_bins/tagged_bins_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/networking/db.dart';
import 'package:citycollection/networking/repositories/bin_disposal_repository.dart';
import 'package:citycollection/screens/authentication/forget_password_screen.dart';
import 'package:citycollection/screens/got_trash/got_trash_screen.dart';
import 'package:citycollection/screens/home_screen.dart';
import 'package:citycollection/screens/authentication/login_screen.dart';
import 'package:citycollection/screens/me/redemptions_screen.dart';
import 'package:citycollection/screens/authentication/registration_screen.dart';
import 'package:citycollection/screens/me/see_trash_disposals_screen.dart';
import 'package:citycollection/screens/root_page.dart';
import 'package:citycollection/screens/me/see_tagged_bins_screen.dart';
import 'package:citycollection/screens/general/take_picture_screen.dart';
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
import 'networking/repositories/data_repository.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  FirebaseDB db = FirebaseDB();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp defaultApp = await Firebase.initializeApp();
  GetIt.instance.registerSingleton<DataRepository>(DataRepository(db));
  GetIt.instance
      .registerSingleton<BinDisposalRepository>(BinDisposalRepository(db));
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.loggerName} ${record.message}');
  });
  // runApp(DevicePreview(
  //   enabled: false,
  //   builder: (context) => MyApp(),
  // ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
                FirebaseAuthService(), GetIt.instance<DataRepository>()),
          ),
          BlocProvider<BinDisposalBloc>(
            create: (context) =>
                BinDisposalBloc(GetIt.instance<BinDisposalRepository>()),
          ),
          BlocProvider<TaggedBinsBloc>(
              create: (context) =>
                  TaggedBinsBloc(GetIt.instance<DataRepository>()))
        ],
        child: MaterialApp(
          // builder: DevicePreview.appBuilder,
          // locale: DevicePreview.of(context).locale,
          title: 'Ekva',
          initialRoute: "/",
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
              case ForgetPasswordScreen.routeName:
                return MaterialPageRoute(builder: (context) {
                  return ForgetPasswordScreen();
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

              case GotTrashScreen.routeName:
                return MaterialPageRoute(builder: (context) {
                  final Map<String, dynamic> map = settings.arguments;
                  return GotTrashScreen(
                    selectedBin: map["taggedBin"],
                  );
                });
              case SeeTaggedBinsScreen.routeName:
                return MaterialPageRoute(builder: (context) {
                  return SeeTaggedBinsScreen();
                });
              case RedemptionsScreen.routeName:
                return MaterialPageRoute(builder: (context) {
                  return RedemptionsScreen();
                });
              case SeeTrashDisposalsScreen.routeName:
                return MaterialPageRoute(builder: (context) {
                  return SeeTrashDisposalsScreen();
                });
              default:
                return MaterialPageRoute(builder: (context) {
                  return RootPage();
                });
            }
          },
          theme: ThemeData(
              dialogTheme: DialogTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)))),
              primarySwatch: CityColors.primary_teal,
              primaryColor: CityColors.primary_teal,
              accentColor: CityColors.primary_teal,
              scaffoldBackgroundColor: Colors.white,
              cardColor: Colors.white,
              errorColor: Colors.redAccent,
              iconTheme: IconThemeData(color: CityColors.primary_teal),
              inputDecorationTheme: InputDecorationTheme(
                  focusColor: Colors.transparent,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true),
              accentTextTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                      .copyWith(
                          button: GoogleFonts.poppins(
                              color: CityColors.primary_teal)),
              appBarTheme: AppBarTheme(
                  color: Colors.white,
                  textTheme:
                      GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
                  iconTheme: IconThemeData(color: Colors.black)),
              buttonColor: CityColors.primary_teal,
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  buttonColor: CityColors.primary_teal),
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
        ));
  }
}
