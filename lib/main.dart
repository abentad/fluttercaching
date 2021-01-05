import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

void main() async {
  //await for hive to initialize before running the app
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoComplete',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [];
  //creates a box for the hive database
  Box box;
  //opens the box called data we created into the directory of the app
  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('data');
    return;
  }

  //takes a jsondecoded response and adds each item in the array into the hive box
  Future addData(data) async {
    //clears old data inside the box before adding new ones
    await box.clear();
    //loops through each data inside array of datas found from api and adds it into the hive box
    for (var d in data) {
      box.add(d);
    }
  }

  //gets all data from api
  Future<bool> getAllData() async {
    //opens the box using the function we wrote
    await openBox();
    //the api end point
    String url = "https://abisfoodrecipeapi.herokuapp.com/search?term=cheese";
    try {
      //gets the data from the api
      var response = await http.get(url);
      //json decodes the response body of the api
      var jsonDecodedData = jsonDecode(response.body);
      //adds the jsondecoded data into the hive box using the function we wrote
      await addData(jsonDecodedData);
    } catch (SocketException) {
      //checks whether there is internet or not using SocketException
      print('no internet');
    }

    //get the data from DB
    //creates a list that holds all values of the hive box after converting it to map and then to list
    var myMap = box.toMap().values.toList();
    //if the list is empty just add empty string to the data variable created at the beginning
    if (myMap.isEmpty) {
      data.add("empty");
    } else {
      //if the list is not empty add all values inside the myMap list to the list data
      data = myMap;
    }
    //returns true
    return Future.value(true);
  }

  Future<void> updateData() async {
    String url = "https://abisfoodrecipeapi.herokuapp.com/search?term=cheese";
    try {
      var response = await http.get(url);
      var jsonDecodedData = jsonDecode(response.body);
      await addData(jsonDecodedData);
      setState(() {});
    } catch (SocketException) {
      //will display a toast at the bottom of the screen indicating there is no internet
      Toast.show("No Internet", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
