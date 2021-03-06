import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/userProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false, 
            title: 'Charoenkrung App',
            theme: ThemeData(
              fontFamily: 'Prompt',
              visualDensity: VisualDensity.adaptivePlatformDensity,
              accentColor: Config.accentColor,
              primaryColor: Config.primaryColor,
              primaryColorDark: Config.darkColor
            ),
            home: Home()));
  }
}
