import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/networking/db.dart';
import 'package:citycollection/screens/root_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';

import 'networking/data_repository.dart';

void main() {
  GetIt.instance
      .registerSingleton<DataRepository>(DataRepository(FirebaseDB()));
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.loggerName} ${record.message}');
  });
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CityApp',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Color(0xFF1E304F),
          backgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Colors.white,
          ),
          textTheme:
              GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme.copyWith(
                    headline1: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(color: Colors.black),
                    headline2: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Colors.black),
                    headline3: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.black),
                    headline4: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.black),
                    headline5: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.black),
                    headline6: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.black),
                  ))),
      home: RootPage(),
    );
  }
}
