import 'package:flutter/material.dart';
import 'core/color/colors.dart';
import 'flutter_sheets/flutter_sheets.dart';
import 'features/views/home_page_view/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterSheets.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor),
          useMaterial3: true,
        ),
        home: const HomePageView());
  }
}
