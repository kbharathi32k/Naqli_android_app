import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'classes/language_constants.dart';
import 'gen_l10n/app_localizations.dart';
import 'homePage.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Initializing Firebase...");
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAw2q-XYb_1TlynK7PuCHRcPZXsfWd3J_s",
          authDomain: "naqli-5825c.firebaseapp.com",
          databaseURL:
              "https://naqli-5825c-default-rtdb.europe-west1.firebasedatabase.app",
          projectId: "naqli-5825c",
          storageBucket: "naqli-5825c.appspot.com",
          messagingSenderId: "736301032077",
          appId: "1:736301032077:web:bd7a20a1eb8447a54ef8c4",
          measurementId: "G-PV5TPJPRMX"));
  print("Firebase initialized successfully!");
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    // No need for onSelectNotification in recent versions
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        debugShowCheckedModeBanner: false,
        home: MyHomePage());
  }
}
