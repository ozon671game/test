import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'single_post.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
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
      body: !isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SinglePost(description: posts[index]['description'], title: posts[index]['title'],)));
                  },
                  title: Text(posts[index]['title']),
                  subtitle: Text(posts[index]['description']),
                );
              }),
    );
  }
}
