import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/screens/login_page.dart';
import 'package:uber_clone/screens/registration_page.dart';

import 'dataproviders/app_data.dart';
import 'firebase_options.dart';
import 'screens/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => AppData(),
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Brand-Regular',
        primarySwatch: Colors.blue,
      ),
      routes: {
        RegistrationPage.id: (context) => RegistrationPage(),
        LoginPage.id: (context) => const LoginPage(),
        MainPage.id: (context) => MainPage(),
      },
      initialRoute: MainPage.id,
    ),
  ));
}
