import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobilefinal2/object/database.dart';
import 'package:mobilefinal2/screen/homeScreen.dart';

class ProfileSetupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileSetupScreenState();
}

class Auser {
  int id;
  String username;
  String name;
  int age;
  String password;
}

class ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formkey = GlobalKey<FormState>();
  UserUtils users = UserUtils();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController quoteController = TextEditingController();
  Auser u = new Auser();

  var prefs;

  SetPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  SetUser() async {
    u.id = await prefs.getInt('userid');
    u.username = await prefs.getString('username');
    u.name = await prefs.getString('name');
    u.age = await prefs.getInt('age');
    u.password = await prefs.getString('password');
    /*
      u.username = 'l';
      u.name = 'h';
      u.age = 15;
      u.password = 'password';
      */
    setState(() {
      usernameController.text = u.username;
      passwordController.text = u.password;
      ageController.text = '${u.age}';
      nameController.text = u.name;
      quoteController.text = quote;
    });
  }

  @override
  Widget build(BuildContext context) {
    SetPrefs();
    SetUser();
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Setup'),
      ),
      body: Form(
        key: _formkey,
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(30),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'User Id',
                  hintText: 'user id',
                ),
                controller: usernameController,
                validator: (value) {
                  if (value.isEmpty)
                    return "Please fill username";
                  else if (!(value.length >= 6 && value.length <= 12))
                    return "UserID must be 6-12 characters";
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'firstname lastname',
                ),
                controller: nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill name";
                  } else {
                    var temp = value.split(' ');
                    print(temp);
                    if (temp.length != 2)
                      return "Name must be like 'firstname lastname'";
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Age',
                  hintText: 'age',
                ),
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                controller: ageController,
                validator: (value) {
                  if (value.isEmpty)
                    return "Please fill age";
                  else {
                    int age = int.parse(value);
                    if (age < 10 || age > 80) return "Age must be 10-80";
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'password',
                ),
                //obscureText: true,
                controller: passwordController,
                validator: (value) {
                  if (value.isEmpty)
                    return "Please fill password";
                  else if (value.length <= 6)
                    return "Password must be more then 6 characters";
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Quote', hintText: 'your quote'),
              ),
              Container(height: 5),
              RaisedButton(
                child: Text('SAVE'),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    //sqflite
                    await users.open('user.db');
                    Userr newUser = new Userr();
                    newUser.id = u.id;
                    newUser.username = usernameController.text;
                    newUser.password = passwordController.text;
                    newUser.name = nameController.text;
                    newUser.age = int.parse(ageController.text);
                    quote = quoteController.text;
                    users.update(newUser);
                    print('updated');
                    Navigator.of(context).pop();
                  } else {
                    Toast.show(
                      'Please fill out this form',
                      context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.BOTTOM,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
