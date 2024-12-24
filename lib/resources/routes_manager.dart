import 'package:flutter/material.dart';

import '../pages/home_page/home_page.dart';
import '../pages/login_page/login_page.dart';

class Routes {
  static const String loginRoute = "/";
  static const String homeRoute = "/home_route";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      //return _fadeRoute(const LoginPage());
      case Routes.homeRoute:
        return _fadeRoute(const HomePage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> _fadeRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 800),
      reverseTransitionDuration: Duration(milliseconds: 800),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('no Route Found'),
              ),
              body: const Center(child: Text('no Route Found')),
            ));
  }
}
