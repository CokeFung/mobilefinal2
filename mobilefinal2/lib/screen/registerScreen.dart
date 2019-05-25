import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilefinal2/object/database.dart';
import 'package:toast/toast.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  UserUtils users = UserUtils();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext Context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Form(
        key: _formkey,
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(30),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'User ID',
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
                  labelText: 'name',
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
                obscureText: true,
                controller: passwordController,
                validator: (value) {
                  if (value.isEmpty)
                    return "Please fill password";
                  else if (value.length <= 6)
                    return "Password must be more then 6 characters";
                },
              ),
              Container(height: 5),
              RaisedButton(
                child: Text('REGISTER'),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    //sqflite
                    await users.open('user.db');
                    Userr newUser = new Userr();
                    newUser.username = usernameController.text;
                    newUser.password = passwordController.text;
                    newUser.name = nameController.text;
                    newUser.age = int.parse(ageController.text);
                    users.insert(newUser);
                    print('registered');
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
