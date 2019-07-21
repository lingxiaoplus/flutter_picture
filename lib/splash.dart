import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picture/GlobalProperties.dart';
import 'package:flutter_picture/main.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_picture/model/vertical_model_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HttpUtil.dart';
import 'animation/CustomRoute.dart';
import 'animation/RxBus.dart';
import 'home/drawer/settings.dart';

void main() {
  runApp(SplashPage());
  //沉浸式
  //SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class Splash extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          brightness: Brightness.light
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {

  ChangeThemeEvent themeEvent = new ChangeThemeEvent(
      color: Colors.pink,
      brightness: Brightness.light);
  SplashPage({Key key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool is_goHome = false;
  String url = "";
  BuildContext globalContext;
  @override
  void initState() {
    super.initState();
    RxBus.instance.register(widget.themeEvent).listen(onGetData);
    getSplashPic();
  }

  void onGetData(Object event) async{
    print('颜色$event');
    ChangeThemeEvent changeThemeEvent = event;
    setState(() {
      widget.themeEvent = changeThemeEvent;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(GlobalProperties.THEME_COLOR, changeThemeEvent.position);
    prefs.setBool(GlobalProperties.THEME_BRIGHTNESS_LIGHT, changeThemeEvent.brightness==Brightness.light);
  }

  @override
  void dispose() {
    super.dispose();
    //RxBus.instance.unRegister();
  }

  Future getSplashPic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int color_int = prefs.getInt(GlobalProperties.THEME_COLOR);
    bool light = prefs.getBool(GlobalProperties.THEME_BRIGHTNESS_LIGHT);
    var dio = HttpUtil.getDio();
    var response = await dio.get(GlobalProperties.BASE_URL + GlobalProperties.VERTICAL_URLS);
    Map map = jsonDecode(response.toString());
    VerticalModelEntity entity = VerticalModelEntity.fromJson(map);
    int index = Random().nextInt(entity.res.vertical.length);
    var url = entity.res.vertical[index].img;
    setState(() {
      this.url = url;
      if(color_int != null && color_int > 0 && color_int < GlobalProperties.colors.length)
        widget.themeEvent.color = GlobalProperties.colors[color_int];
      if(light != null)
        widget.themeEvent.brightness = light?Brightness.light:Brightness.dark;
    });
    print("获取到的日图: $url");
    countDown();
  }

  void countDown(){
    var duration = new Duration(seconds: 2);
    var future = new Future.delayed(duration,()=>{goHomePage(globalContext)});
  }

  void goHomePage(BuildContext context){
    if(!is_goHome){
      /*Navigator.of(context).pushAndRemoveUntil(
          CustomRoute(HomePage()),(Route<dynamic> rout)=>false);*/
      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context)=>new HomePage()),
              (Route<dynamic> rout)=>false);
      is_goHome = true;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: widget.themeEvent.color,
          brightness: widget.themeEvent.brightness,
      ),
      home: Builder(builder: (BuildContext context){
       globalContext = context;
        return Container(
            decoration: BoxDecoration( // 背景装饰
              image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover
              ),
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Positioned(child: MaterialButton(
                  onPressed: (){
                    goHomePage(context);
                  },
                  child:
                  Text('进入应用'),
                  textColor: Colors.white,
                  color: Colors.black45,
                ),
                  top: 22.0,
                  right: 10.0,
                ),
                Positioned(
                  width: 30.0,
                  height: 30.0,
                  child: CircularProgressIndicator(strokeWidth: 2.0,),
                  bottom: 20.0,)
              ],
            )
        );
      },),
    );
    return Container(
        decoration: BoxDecoration( // 背景装饰
          image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover
          ),
        ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned(child: MaterialButton(
            onPressed: (){
              goHomePage(context);
            },
            child:
            Text('进入应用'),
            textColor: Colors.white,
            color: Colors.black45,
          ),
            top: 22.0,
            right: 10.0,
          ),
          Positioned(
            width: 30.0,
            height: 30.0,
            child: CircularProgressIndicator(strokeWidth: 2.0,),
            bottom: 20.0,)
        ],
      )
    );
  }

}
