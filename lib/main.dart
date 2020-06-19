import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http ;
import 'package:convert/convert.dart';

void main() => runApp(new MaterialApp(
  home: new HomePage() ,
));

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage>{

  final String url = "https://swapi.dev/api/people";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
      //encode the url
      Uri.encodeFull(url),
      headers: {"Accept":"application/json"}
    );
    print(response.body);
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Retrieve JSON via GTTP GET"),
      ),
      body: new ListView.builder(
        itemCount: data==null?0:data.length,
        itemBuilder: (BuildContext context , int index){
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Column(
                      children: <Widget>[
                        new Text("Name : "+data[index]['name']),
                        new Text("Height : "+data[index]['height']),
                        new Text("Mass : "+data[index]['mass']),
                        new Text("Gender : "+data[index]['gender']),
                        new Text("Birth Year : "+data[index]['birth_year']),
//                       new Text(data[index]['films'].toString()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}