import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String quote;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  print(directory.path);
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/quote.txt');
}

Future<String> readQuote() async {
  try {
    final file = await _localFile;

    // Read the file
    String contents = await file.readAsString();
    if (contents == '' || contents == null)
      return "Don't have quote yet.";
    else
      return contents;
  } catch (e) {
    // If encountering an error, return 0
    return "Don't have quote yet.";
  }
}

Future<File> writeQuote(String quote) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString(quote);
}

class HomeScreenState extends State<HomeScreen> {
  var prefs;
  String name;
  @override
  void initState() {
    super.initState();
    readQuote().then((String v) {
      setState(() {
        quote = v;
      });
    });
  }

  SetPrefs() async {
    prefs = await SharedPreferences.getInstance();
    name = await prefs.getString('name');
  }

  @override
  Widget build(BuildContext Context) {
    SetPrefs();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(30),
            children: <Widget>[
              Text(
                'Hello ' + name,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Text(
                quote,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Container(height: 10),
              RaisedButton(
                child: Text('PROFILE SETUP'),
                onPressed: () {
                  /*
                  writeQuote('today is my day');
                  readQuote().then((String v) {
                    setState(() {
                      quote = v;
                    });
                  });
                  */
                  Navigator.pushNamed(context, '/profilesetup');
                },
              ),
              RaisedButton(
                child: Text('MY FRIENDS'),
                onPressed: () {
                  Navigator.pushNamed(context, '/friend');
                },
              ),
              RaisedButton(
                child: Text('SIGN OUT'),
                onPressed: () {
                  prefs.clear();
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
