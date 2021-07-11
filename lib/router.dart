import 'package:flutter/material.dart';
import 'package:housy_task_2/screens/home_screen.dart';
import 'package:housy_task_2/screens/login_screen.dart';
import 'package:housy_task_2/screens/registration_screen.dart';
import 'package:housy_task_2/screens/welcome_screen.dart';

import 'constants.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => WelcomePage(),
        );
      case LOGIN_SCREEN:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case REGISTRATION_SCREEN:
        return MaterialPageRoute(
          builder: (_) => RegistrationScreen(),
        );
      case HOME_SCREEN:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      default:
        return null!;
    }
  }
}
