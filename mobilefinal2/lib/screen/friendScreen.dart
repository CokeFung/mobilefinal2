import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FriendScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FriendScreenState();
}

class Friend {
  int id;
  String name;
  String email;
  String phone;
  String website;
}

class FriendScreenState extends State<FriendScreen> {
  List<Friend> ff = new List<Friend>();
  GetFriend() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      List<dynamic> list = json.decode(response.body);
      List<Friend> tmp = new List<Friend>();
      print(list);
      for (var i in list) {
        print(i);
        Friend f = new Friend();
        f.id = i;
        f.name = i;
        tmp.add(f);
      }
      return tmp;
    }
  }

  @override
  Widget build(BuildContext context) {
    GetFriend();
    return Scaffold(
      appBar: AppBar(
        title: Text('My friends'),
      ),
      body: ListView.builder(
        itemCount: ff.length,
        itemBuilder: (BuildContext context, int ind) {
          return Card(
            child: Row(
              children: <Widget>[
                Text(ff[ind].name),
              ],
            ),
          );
        },
      ),
    );
  }
}
