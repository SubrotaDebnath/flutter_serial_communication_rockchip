

import 'package:flutter/material.dart';
import 'package:flutter_serial_communication_rockchip/constants/navigation/routes.dart';

import '../../presentation/screens/error_screens/navigation_error_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/port_connect_screen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;


    switch (settings.name) {

      case Routes.kHomeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
        case Routes.kPortConnectScreen:
        return MaterialPageRoute(builder: (_) => const PortConnectScreen());



    //Error pages
      default:
        return MaterialPageRoute(builder: (_) => const NavigationErrorScreen());
    }
  }
}