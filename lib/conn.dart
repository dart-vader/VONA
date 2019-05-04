import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:vonaapp/widgets.dart';

class Conn extends StatefulWidget {
  @override
  _ConnState createState() => _ConnState();
}

class _ConnState extends State<Conn> {
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          _connectionStatus = result.toString();
          print(_connectionStatus);
          if (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile) {
            setState(() {});
          }
        });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future getData() async {
    http.Response response = await http.get(
        "https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == HttpStatus.OK) {
      var result = jsonDecode(response.body);

      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Vona")),
      body: new FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              //var mydata = snapshot.data;
              return Center(
                child: new MyExploreWidget(),

              );
            }
          }
      ),
    );
  }
}


