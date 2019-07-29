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
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width:double.infinity,
                color: Theme.of(context).primaryColor,),
              Padding(padding: EdgeInsets.all(10),child: Image.asset("assets/last.png",width: 100,height: 100,),),
              //Padding(padding: EdgeInsets.all(4),child: Text('想不出什么骚话',style: TextStyle(fontSize: 14)),),
              Padding(padding: EdgeInsets.all(4),child: Text('1.0.0'),),
              Padding(padding: EdgeInsets.all(4),child: Text('确认过眼神，是船新版本'),),
            ],
          ),
          Positioned(child:Text('@ 2019-2020 All rights reserved.',style: TextStyle(fontSize: 14),),bottom: 100,)
        ],
      ),
    );
  }
}