import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'dart:convert';

import 'package:flutter_picture/GlobalProperties.dart';
import 'package:flutter_picture/comon/BannerWidget.dart';
import 'package:flutter_picture/comon/ListPage.dart';
import 'package:transparent_image/transparent_image.dart';

import '../HttpUtil.dart';

class Recommend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecommendState();
  }
}
class RecommendState extends State<Recommend> with AutomaticKeepAliveClientMixin{
  int skip = 0;
  List<Picture> wallpapers = [];
  List<BannerItem> bannerList = [];
  GlobalKey<RefreshIndicatorState> _refreshKey = new GlobalKey();

  ScrollController _scrollController;
  double scrollDistance = 0.0;
  final String _scrollDistanceIdentifier = 'scrollDistanceIndentifier';  //tag

  @override
  void initState() {
    super.initState();
    getRecommendList();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.removeListener(_handleScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      //加载更多
      skip+=30;
      getRecommendList();
    }
    scrollDistance = _scrollController.position.pixels;
    PageStorage.of(context).writeState(context, scrollDistance,
        identifier: _scrollDistanceIdentifier);
    setState(() {});
  }

  Future getRecommendList() async {
    var dio = HttpUtil.getDio();
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

    getBannerData(map);
    setState(() {
      wallpapers = wallpapers;
      bannerList = bannerList;
    });
  }

  void getBannerData(Map map){
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
      String cover = item['value']['lcover'];
      String title = item['value']['desc'];
      if(cover == null) continue;
      print('图片： ${cover}');
      print('标题： ${title}');
      var bannerItem = BannerItem.defaultBannerItem(cover, title);
      bannerList.add(bannerItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshKey,
        child: ListPage(
            wallpapers,
            headerList: [1],
            itemWidgetCreator: getItemWidget,
            headerCreator: (BuildContext context, int position){
              if(position == 0){
                print('添加bannerwidget');
                return BannerWidget(180.0, bannerList,
                  bannerPress: (int position, BannerItem entity){

                  },);
              }else{
                print('添加padding');
                return Padding(padding: EdgeInsets.all(10.0), child:
                Text('$position -----header------- '),);
              }
            },
          scrollController: _scrollController,
        ),
        onRefresh: _handleRefresh);
  }

  Future<Null> _handleRefresh() async{
    bannerList.clear();
    wallpapers.clear();
    skip=0;
    return getRecommendList();
  }

  Widget getItemWidget(BuildContext context, int position) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: EdgeInsets.all(4.0),
      child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: wallpapers[position].preview + GlobalProperties.imgRule_230,
          width: 300,
          height: 200,
          fit: BoxFit.cover
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;


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