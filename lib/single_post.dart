import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SinglePost extends StatefulWidget {
  const SinglePost({Key? key, required this.title, required this.description}) : super(key: key);
  final String title, description;

  @override
  State<SinglePost> createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {

  List posts = [];
  bool isLoaded = false;

  getData() async {
    var url = Uri.parse(
        'https://my-json-server.typicode.com/ozon671game/test/posts');
    Response response = await get(url);
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      print(jsonData);
      for (var e in jsonData) {
        posts.add(e);
      }
      print(posts.first['title']);
      print(posts.first['description']);

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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(widget.title),
            Text(widget.description),
            // ListView.builder(itemBuilder: ())
          ],
        ),
      ),
    );
  }
}
