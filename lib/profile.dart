import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'models/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool isLoaded = false;
  SingleUser? userInfo;

  getData() async {
    var url = Uri.parse(
        'https://my-json-server.typicode.com/ozon671game/test/profile');
    Response response = await get(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      userInfo = SingleUser(
          name: jsonData['name'],
          email: jsonData['email'],
          phone: jsonData['phone'],
          website: jsonData['website'],
          address: jsonData['address'],
          working: jsonData['working'],);
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded ? CircularProgressIndicator() : Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
      ),
      body: Column(
        children: <Widget>[

        ],
      ),
    );
  }
}
