import 'package:flutter/material.dart';
import 'package:mobilefinal2/object/database.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  UserUtils users = UserUtils();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isfound = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formkey,
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(30),
            children: <Widget>[
              Image.network(
                'https://www.pokemoncenter.com/wcsstore/MarketingContent/detective-pikachu/landing_detective-pikachu_header_mobile.jpg',
                height: 200,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'username',
                ),
                //keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) return 'Please fill username';
                },
                controller: usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'password',
                  hintText: 'password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) return 'Please fill password';
                },
                controller: passwordController,
              ),
              Container(height: 5),
              RaisedButton(
                child: Text('LOGIN'),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    List<Userr> getAllUser = new List<Userr>();
                    await users.open('user.db');
                    getAllUser = await users.getAllUsers();
                    if (getAllUser.isNotEmpty)
                      for (Userr i in getAllUser) {
                        if (i.username == usernameController.text &&
                            i.password == passwordController.text) {
                          isfound = true;
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('signin', true);
                          prefs.setInt('userid', i.id);
                          prefs.setString('username', i.username);
                          prefs.setString('password', i.password);
                          prefs.setString('name', i.name);
                          prefs.setInt('age', i.age);
                          break;
                        }
                      }
                    if (isfound) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      Toast.show(
                        'Invalid user or password',
                        context,
                        duration: Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM,
                      );
                    }
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
              Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  child: Text(
                    'Register new account',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.green[600],
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
