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
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  List comments = [];
  bool isLoaded = false;

  getData() async {
    var url = Uri.parse(
        'https://my-json-server.typicode.com/ozon671game/test/comments');
    Response response = await get(url);
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      print(jsonData);
      for (var e in jsonData) {
        comments.add(e);
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
        actions: [
          IconButton(onPressed: (){
            addComm(context);
          }, icon: Icon(Icons.add)),
        ],
      ),
      body: !isLoaded ? CircularProgressIndicator() :ListView(
      children: <Widget>[
        Text(widget.title),
        Text(widget.description),
        Divider(height: 2, indent: 2, color: Colors.black,),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(comments[index]['username']),
                subtitle: Text(comments[index]['text']),
              );
            },
          ),
      ],
        ),
    );
  }

  addComm(context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 800,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter text comment',
                    ),
                      controller: controller1,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Name',
                      ),
                      controller: controller2,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Email',
                      ),
                      controller: controller3,
                    ),
                    IconButton(onPressed: (){
                      putCom();
                      Navigator.pop(context);
                    }, icon: Icon(Icons.add)),
                  ],
                ),
              ),
            ),
          );
        });
  }

  putCom() async {
    var url = Uri.parse(
        'https://my-json-server.typicode.com/ozon671game/test/comments');
    Response response = await post(url, body: {
      'text': controller1.text,
      'username': controller2.text,
      'email': controller3.text,
    });
  }
}
