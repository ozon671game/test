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
  late SingleUser userInfo;
  List posts = [];
  List albums = [];

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
      var jsonPosts = jsonData['posts'];
      print(jsonPosts);
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
    return !isLoaded ? Center(child: CircularProgressIndicator()) : Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
      ),
      body: ListView(
        children: <Widget>[
          Text(userInfo.name),
          Text(userInfo.email),
          Text(userInfo.phone),
          Text(userInfo.website),
          Text(userInfo.working['working_name']),
          Text(userInfo.working['bs']),
          Text(userInfo.working['catchPhrase']),

        ],
      ),
    );
  }
}
