import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'models/user.dart';
import 'posts.dart';
import 'single_post.dart';

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
      userInfo = SingleUser(
          name: jsonData['name'],
          email: jsonData['email'],
          phone: jsonData['phone'],
          website: jsonData['website'],
          address: jsonData['address'],
          working: jsonData['working'],);
      List jsonPosts = jsonData['posts'];
      List jsonAlbums = jsonData['albums'];
      print(jsonPosts);
      for (var e in jsonPosts) {
        posts.add(e);
      }
      for (var e in jsonAlbums) {
        albums.add(e);
      }
      print(posts[0]['title']);

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 235,
              child: Column(
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        onTapPosts();
                      },
                      child: Text('POSTS')),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SinglePost(description: posts[0]['description'], title: posts[0]['title'],)));
                    },
                    title: Text(posts[0]['title']),
                    subtitle: Text(posts[0]['description']),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SinglePost(description: posts[1]['description'], title: posts[1]['title'],)));
                    },
                    title: Text(posts[1]['title']),
                    subtitle: Text(posts[1]['description']),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SinglePost(description: posts[2]['description'], title: posts[2]['title'],)));
                    },
                    title: Text(posts[2]['title']),
                    subtitle: Text(posts[2]['description']),
                  ),
                ],
              ),
            ),
          ),
          Center(child: Text('ALBUMS')),
          InkWell(
            onTap: (){

            },
            child: SizedBox(
              height: 100,
              child: Row(
                children: <Widget>[
                  FlutterLogo(),
                  FlutterLogo(),
                  FlutterLogo(),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  onTapPosts() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Posts()));
  }
}
