import 'package:flutter/material.dart';
import 'package:mobilefinal2/screen/homeScreen.dart';
import 'package:mobilefinal2/screen/loginScreen.dart';
import 'package:mobilefinal2/screen/registerScreen.dart';
import 'package:mobilefinal2/screen/friendScreen.dart';
import 'package:mobilefinal2/screen/profilesetupScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(136, 14, 79, .1),
      100: Color.fromRGBO(136, 14, 79, .2),
      200: Color.fromRGBO(136, 14, 79, .3),
      300: Color.fromRGBO(136, 14, 79, .4),
      400: Color.fromRGBO(136, 14, 79, .5),
      500: Color.fromRGBO(136, 14, 79, .6),
      600: Color.fromRGBO(136, 14, 79, .7),
      700: Color.fromRGBO(136, 14, 79, .8),
      800: Color.fromRGBO(136, 14, 79, .9),
      900: Color.fromRGBO(136, 14, 79, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFFA1887F, color);
    //convert color code from
    //https://medium.com/@manojvirat457/turn-any-color-to-material-color-for-flutter-d8e8e037a837
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => new LoginScreen(),
        '/login': (BuildContext context) => new LoginScreen(),
        '/register': (BuildContext context) => RegisterScreen(),
        '/home': (BuildContext context) => HomeScreen(),
        '/friend': (BuildContext context) => FriendScreen(),
        '/profilesetup': (BuildContext context) => ProfileSetupScreen(),
      },
    );
  }
}
