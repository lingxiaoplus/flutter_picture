import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'dart:convert';

import 'package:flutter_picture/GlobalProperties.dart';

import 'ListPage.dart';
import 'comon/BannerWidget.dart';
class Recommend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecommendState();
  }
}
class RecommendState extends State<Recommend>{
  int skip = 0;
  List<Picture> wallpapers = [];
  List<BannerItem> bannerList = [];
  @override
  void initState() {
    super.initState();
    getRecommendList();
  }

  Future getRecommendList() async {
    var dio = new Dio();
    var response = await dio.get(
        GlobalProperties.BASE_URL +
            GlobalProperties.HOMEPAGE_URL,
        queryParameters: {
          'limit': GlobalProperties.limit,
          'skip': skip
        });
    Map map =  jsonDecode(response.toString());
    List wall = map['res']['wallpaper'];
    for(var item in wall){
      Picture picture = Picture();
      picture.preview = item['preview'];
      wallpapers.add(picture);
    }

    List list = map['res']['homepage'];
    if(list.length > 0){
      list = list.sublist(1,list.length);
    }

    List items = [];
    for(var item in list){
      if(item['type'] == 13){
        items = item['items'];
        break;
      }
    }
    for(var item in items){
      String cover = item['value']['cover'];
      String title = item['value']['desc'];
      print('图片： ${cover}');
      print('标题： ${title}');
      var bannerItem = BannerItem.defaultBannerItem(cover, title);
      bannerList.add(bannerItem);
    }
    setState(() {

    });
  }

  static GlobalKey<ScaffoldState> _globalKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ListPage(
      wallpapers,
      headerList: [1,2],
      itemWidgetCreator: getItemWidget,
      headerCreator: (BuildContext context, int position){
        if(position == 0){
          return BannerWidget(180.0, bannerList,key: _globalKey,);
        }else{
          return Padding(padding: EdgeInsets.all(10.0), child:
          Text('$position -----header------- '),);
        }
      },
    );
  }

  Widget getItemWidget(BuildContext context, int position) {
    return Image.network(wallpapers[position].preview,width: 100,height: 100,);
  }
}
class Picture{
  String img;  //原始图片地址
  List<String> tag;  //标签类别
  double atime;    //时间
  String preview; //压缩过后的图片地址
  String id;
  String store;
  String desc;
}

class BannerPic{
  String cover; //图片地址
  String id;
  String name;
  String desc;
}