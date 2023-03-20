import 'package:flutter/material.dart';

import 'constants/navigation/route_generator.dart';
import 'constants/navigation/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serial Communication',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.kHomeScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}


