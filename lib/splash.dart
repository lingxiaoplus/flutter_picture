import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picture/main.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
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
  String url = "https://img.zcool.cn/community/0372d195ac1cd55a8012062e3b16810.jpg";
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
    var response = await dio.get("https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1");
    Map map = jsonDecode(response.toString());
    var image = map['images'][0];
    var url = "http://s.cn.bing.net${image['url']}";
    setState(() {
      this.url = url;
    });
    print("获取到的日图: $url");
    countDown();
  }

  void countDown(){
    var duration = new Duration(seconds: 3);
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
              image: NetworkImage('https://img.zcool.cn/community/03'
                  '72d195ac1cd55a8012062e3b16810.jpg'),
              fit: BoxFit.cover
          ),
        ),
      child: Stack(
        children: <Widget>[
          Positioned(child: MaterialButton(
            onPressed: goHomePage,
            child:
            Text('进入应用'),
            textColor: Colors.grey,
            color: Colors.white30,
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
