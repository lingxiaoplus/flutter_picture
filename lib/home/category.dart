import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_picture/comon/ListPage.dart';
import 'package:flutter_picture/model/category_model_entity.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:convert';

import '../GlobalProperties.dart';
import '../HttpUtil.dart';


class CategoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  final GlobalKey<RefreshIndicatorState> _refreshKey = new GlobalKey();
  List<CategoryModelResCategory> wallpapers = [];
  ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: _refreshKey,
        child: ListPage(
          wallpapers,
          have_footer: false,
          itemWidgetCreator: getItemWidget,
          scrollController: _scrollController,
        ),
        onRefresh: _handleRefresh);;
  }

  Widget getItemWidget(BuildContext context, int position) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: EdgeInsets.all(4.0),
      child: Stack(
        alignment:Alignment.center,
        children: <Widget>[
          FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: wallpapers[position].cover,
              width: 300,
              height: 200,
              fit: BoxFit.cover
          ),
          Padding(
            padding: EdgeInsets.all(4),
            child: Text(
              wallpapers[position].rname,
              style: TextStyle(color: Colors.white,fontSize: 20.0)),),
        ],
      ),
    );
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: wallpapers[position].cover,
              width: 300,
              height: 160,
              fit: BoxFit.cover
          ),
          Padding(
            padding: EdgeInsets.all(4),
            child: Text(wallpapers[position].rname,),)
        ],
      ),
    );
  }

  Future<void> _handleRefresh() {
    return getData();
  }

  Future<void> getData() async{
    var dio = HttpUtil.getDio();
    var response = await dio.get(
        GlobalProperties.BASE_URL +
            GlobalProperties.CATEGORY_URL);
    Map map =  jsonDecode(response.toString());
    CategoryModelEntity category = CategoryModelEntity.fromJson(map);
    if(category.res.category.length%2 != 0 && category.res.category.length>1){
      category.res.category = category.res.category.sublist(0,category.res.category.length-1);
    }
    // mounted 为 true 表示当前页面挂在到构件树中，为 false 时未挂载当前页面
    if(mounted){
      setState(() {
        wallpapers = category.res.category;
      });
    }
  }
}