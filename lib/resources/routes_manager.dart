import 'package:easy_localization/easy_localization.dart';
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
        return //MaterialPageRoute(builder: (_) => const LoginPage());
            _fadeRoute(const LoginPage());
      case Routes.homeRoute:
        return //MaterialPageRoute(builder: (_) => const HomePage());
            _fadeRoute(const HomePage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> _fadeRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: Duration(seconds: 2),
      reverseTransitionDuration: Duration(seconds: 2),
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
                title: Text('messages.no_route_found'.tr()),
              ),
              body: Center(child: Text('messages.no_route_found'.tr())),
            ));
  }
}
