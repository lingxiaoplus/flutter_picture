import 'package:flutter/material.dart';
import 'package:flutter_picture/animation/CustomRoute.dart';
import 'package:flutter_picture/comon/ListPage.dart';
import 'package:flutter_picture/model/gank_welfare_model_entity.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:convert';

import '../GlobalProperties.dart';
import '../HttpUtil.dart';
import '../image_viewpager.dart';

class GankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GankPageState();
  }
}

class GankPageState extends State<GankPage> with AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin  {
  @override
  bool get wantKeepAlive => true;
  final GlobalKey<RefreshIndicatorState> _refreshKey = new GlobalKey();
  List<GankWelfareModelResult> wallpapers = [];
  List<String> images = [];
  GlobalKey<ListPageState> _listPageKey = new GlobalKey();

  final limit = 30;
  int page = 1;
  double scrollDistance = 0.0;

  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        RefreshIndicator(
            key: _refreshKey,
            child: ListPage(
              wallpapers,
              key: _listPageKey,
              mainAxisExtent: 300.0,
              itemWidgetCreator: getItemWidget,
              onLoadMore: (){
                page++;
                getData();
              },
            ),
            onRefresh: _handleRefresh),
        Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              heroTag: "bt2",
              onPressed: () {
                _listPageKey.currentState.smoothToPosition(0,
                     Duration(milliseconds: 1000));
              },
              elevation: 13.0,
              child: Icon(Icons.vertical_align_top),
            ))
      ],
    );
  }

  Widget getItemWidget(BuildContext context, int position) {
    return Card(
        elevation: 4.0,
        margin: EdgeInsets.all(4.0),
        child: InkWell(
          child: Hero(
              tag: GlobalProperties.HERO_TAG_LOAD_IMAGE + "$position",  //注意这个TAG！！！ 因为在listview中，所以必须再加上位置
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image:
                wallpapers[position].url,

                fit: BoxFit.cover,
              )),
          onTap: () {
            Navigator.push(
                context,
                CustomRoute(ImageViewPage(
                  images: images,
                  position: position,
                  imageRule: false,
                )));
          },
        ));
  }

  Future<void> _handleRefresh() {
    page = 1;
    wallpapers.clear();
    return getData();
  }

  Future<void> getData() async {
    var dio = HttpUtil.getDio();
    var response = await dio.get(GlobalProperties.GANKURL + "$limit/$page");
    Map map = jsonDecode(response.toString());
    GankWelfareModelEntity welfare = GankWelfareModelEntity.fromJson(map);
    wallpapers.addAll(welfare.results);
    for (var item in welfare.results) {
      images.add(item.url);
    }
    if (mounted) {
      setState(() {});
    }
  }
}
