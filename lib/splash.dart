import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picture/GlobalProperties.dart';
import 'package:flutter_picture/main.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:math';

void main() {
  runApp(Splash());
  //沉浸式
  //SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class Splash extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }

}

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool is_goHome = false;
  String url = "";
 /* void _incrementCounter() {
    setState(() {
      url;
    });
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSplashPic();
  }

  Future getSplashPic() async {
    var dio = new Dio();
    var response = await dio.get(GlobalProperties.BASE_URL + GlobalProperties.VERTICAL_URLS);
    Map map = jsonDecode(response.toString());
    List images = map['res']['vertical'];
    int index = Random().nextInt(images.length);
    var url = images[index]['img'];
    setState(() {
      this.url = url;
    });
    print("获取到的日图: $url");
    countDown();
  }

  void countDown(){
    var duration = new Duration(seconds: 5);
    new Future.delayed(duration,goHomePage);
  }

  void goHomePage(){
    if(!is_goHome){
      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context)=>new HomePage(title: '浏览')),
              (Route<dynamic> rout)=>false);
      is_goHome = true;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration( // 背景装饰
          image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover
          ),
        ),
      child: Stack(
        children: <Widget>[
          Positioned(child: MaterialButton(
            onPressed: goHomePage,
            child:
            Text('进入应用'),
            textColor: Colors.white,
            color: Colors.black45,
          ),
            top: 22.0,
            right: 10.0,
          )
        ],
      )
//      child: Scaffold(
//        backgroundColor: Colors.transparent,
//        appBar: AppBar(
//          elevation: 0,//appbar的阴影
//        ),
//      ),
    );
  }

}
