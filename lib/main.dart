import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/pages/firstScreen.dart';
import 'package:suitmedia_test/pages/secondScreen.dart';
import 'package:suitmedia_test/pages/thirdScreen.dart';
import 'package:suitmedia_test/pages/nameProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NameProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Suitmedia Test',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const FirstScreen()),
        GetPage(name: '/second', page: () => const SecondScreen()),
        GetPage(name: '/third', page: () => const ThirdScreen()),
      ],
    );
  }
}
