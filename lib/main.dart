import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/profile.dart';

import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<User> usersList = [];
  bool isLoaded = false;

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('data');
    if(data != null){
      List jsonData = jsonDecode(data);
      for (var e in jsonData) {
        usersList.add(User(
          name: e['username'].toString(),
          username: e['name'],
        ));
      }
      setState(() {
        isLoaded = true;
      });
      return;
    }
    var url = Uri.parse('https://my-json-server.typicode.com/ozon671game/test/users');
    Response response = await get(url);
    if(response.statusCode == 200) {
      prefs.setString('data', response.body);
      List jsonData = jsonDecode(response.body);
      print(jsonData);
      for (var e in jsonData) {
        usersList.add(User(
            name: e['username'].toString(),
            username: e['name'],
        ));
      }
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
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Users List'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: !isLoaded ? CircularProgressIndicator() : ListView.builder(
          itemCount: usersList.length,
            itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              onTapListTile(usersList[index].username);
            },
            title: Text(usersList[index].username),
            subtitle: Text(usersList[index].name),
          );
        }),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  onTapListTile(String username) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(username: username,)));
  }
}
