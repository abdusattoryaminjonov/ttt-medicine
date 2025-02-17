import 'package:TTTMedicine/config/root_binding.dart';
import 'package:TTTMedicine/pages/account_page.dart';
import 'package:TTTMedicine/pages/add_page.dart';
import 'package:TTTMedicine/pages/gemini/chat_page.dart';
import 'package:TTTMedicine/pages/home_page.dart';
import 'package:TTTMedicine/pages/pills_page.dart';
import 'package:TTTMedicine/pages/register_page.dart';
import 'package:TTTMedicine/pages/splash_page.dart';
import 'package:TTTMedicine/services/root_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()!
      .requestNotificationsPermission();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    await RootService.init();
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyD9uXrxAE79aaLsbL27lNCodFhsa5WVnxA',
          appId: '1:593496349659:android:4d3711fc791c186fc4a5fe',
          messagingSenderId: '593496349659',
          projectId: 'medicine-b7dbe',
        )
    );
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TTTMedicine',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      initialBinding: RootBinding(),
      routes: {
        ChatPage.id :(context) => const ChatPage(),
        AccountPage.id :(context) => const AccountPage(),
        RegisterPage.id :(context) => const RegisterPage(),
        HomePage.id :(context) => const HomePage(),
        SplashPage.id :(context) => const SplashPage(),
        AddPage.id :(context) => const AddPage(),
        PillsPage.id :(context) =>const PillsPage(),
      },
    );
  }
}