import 'package:flutter/material.dart';
import 'resources/routes_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmetics App Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.loginRoute,
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
