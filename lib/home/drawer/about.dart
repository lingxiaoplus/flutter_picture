import 'package:flutter/material.dart';
class AboutPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AboutPageState();
  }
}

class AboutPageState extends State<AboutPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width:double.infinity,
            color: Theme.of(context).primaryColor,),
          Text('flutter'),
        ],
      ),
    );
  }
}