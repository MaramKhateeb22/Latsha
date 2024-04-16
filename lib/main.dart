import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mopidati/auth/login.dart';
import 'package:mopidati/auth/sign_up.dart';
import 'package:mopidati/auth/splash.dart';
import 'package:mopidati/screens/ReportUser/ReportUser.dart';
import 'package:mopidati/screens/ReverseUser/ReverseUser.dart';
import 'package:mopidati/screens/home/home.dart';
import 'package:mopidati/screens/newReserve/mapReveerse/mapReverse.dart';
import 'package:mopidati/screens/newReserve/newReserve.dart';
import 'package:mopidati/screens/report/mapReport/mapReport.dart';
import 'package:mopidati/utiles/constants.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.getToken().then(
    (value) {
      print('FcM Valur:$value');
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
          BotToast.showSimpleNotification(
            title: message.notification!.title ?? '',
            subTitle: message.notification!.body ?? '',
            // duration: const Duration(seconds: 5),
          );
        }
      },
    );
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Warning: Don't arbitrarily adjust the position of calling the BotToastInit function
    final botToastBuilder = BotToastInit(); //1. call BotToastInit
    return MaterialApp(
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()],
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
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: backgroundColor,
        //textbutton
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: pColor,
            textStyle: const TextStyle(
              fontSize: 20, // حجم النص
            ),
          ),
        ),
        //text
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
              color: pColor, fontSize: 25, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: pColor),
          bodySmall: TextStyle(color: pColor),
        ),
        //appbar theme
        appBarTheme: const AppBarTheme(
          color: pColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.white24,
          ),
        ),
        //icon theme
        iconTheme: const IconThemeData(color: pColor),
        //inuprtdecoration theme
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            // تعريف حاشية الحقل المفعل
            borderSide: BorderSide(color: pColor),
            // تعيين لون الحاشية
            gapPadding: 2,
          ),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: sColor)),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MyHomePage(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/ReverseUser': (context) => const ReverseUser(),
        '/ReportUser': (context) => const ReportUser(),
        '/MapReport': (context) => const MapReport(),
        '/MapReverse': (context) => const MapReverse(),
        '/NewReverseScreen': (context) => const NewReverseScreen(),
      },
    );
  }
}
