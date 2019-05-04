import'package:flutter/material.dart';

class Texty extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Container(child: new Text('This Works'));
  }
}

class MyExploreWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var assetsImage = new AssetImage('assets/no-wifi.jpg');
    var image = new Image(image: assetsImage, width: 300,height:400);
    return new Container(
        alignment: Alignment.center,
        color: Colors.white,
        margin: EdgeInsets.all(10.0),
        child: image
    );

  }
}