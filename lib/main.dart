import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mopidati/home/home.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mopidati/utiles/constants.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: const Locale("ar", "AE"),
      title: 'Flutter Demo',
      theme: ThemeData(

        iconTheme: IconThemeData(color: pColor),
    inputDecorationTheme:const InputDecorationTheme(
    enabledBorder: OutlineInputBorder( // تعريف حاشية الحقل المفعل
    borderSide: BorderSide(color: pColor),


    // تعيين لون الحاشية
    gapPadding: 2,
    ),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: sColor)),

      ),),
      initialRoute: '/',
      routes: {
        '/':(context) => MyHomePage(),
      },

    );
  }
}