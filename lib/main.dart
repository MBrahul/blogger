import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/home/home.dart';
import 'package:flutter_application_3/screens/login/login.dart';
import 'package:flutter_application_3/screens/sign%20up/signup.dart';
import 'package:flutter_application_3/screens/splash/splash.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// Initialize FFI
  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}

// favorite button
// user screen
// logout
