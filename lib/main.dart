import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_app/views/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, statusBarColor: Colors.white));
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      )),
      home: HomeView(),
    );
  }
}
