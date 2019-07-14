import 'package:flutter/material.dart';
import 'package:flutter_picture/comon/ListPage.dart';
import 'package:flutter_picture/model/special_model_entity.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:convert';

import '../GlobalProperties.dart';
import '../HttpUtil.dart';

class SpecialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SpecialPageState();
  }
}

class SpecialPageState extends State<SpecialPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final GlobalKey<RefreshIndicatorState> _refreshKey = new GlobalKey();

  List<SpecialModelResAlbum> wallpapers = [];
  ScrollController _scrollController;
  int skip = 0;

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
            child: ListView.builder(
              itemBuilder: getItemWidget,
              itemCount: wallpapers.length + 1, //加上一个尾巴
            ),
            onRefresh: _handleRefresh),
        Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(0.0,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeOut);
              },
              elevation: 13.0,
              child: Icon(Icons.vertical_align_top),
            ))
      ],
    );

    return RefreshIndicator(
        key: _refreshKey,
        child: ListView.builder(
          itemBuilder: getItemWidget,
          itemCount: wallpapers.length + 1, //加上一个尾巴
        ),
        onRefresh: _handleRefresh);
  }

  Widget getItemWidget(BuildContext context, int position) {
    if (position == wallpapers.length) {
      skip += GlobalProperties.limit;
      getData();
      return Container(
          padding: const EdgeInsets.all(12.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('加载更多数据'),
              )
            ],
          ));
    }
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: wallpapers[position].cover,
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Text(
                        wallpapers[position].name,
                        style: TextStyle(color: Colors.black87, fontSize: 18.0),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      Text(
                        wallpapers[position].desc,
                        style: TextStyle(color: Colors.black38, fontSize: 16.0),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      )
                    ],
                  )),
            ],
          ),
          Divider(
            height: 2.0,
            indent: 10.0,
            endIndent: 10.0,
            color: Colors.red,
          ),
          Padding(
            padding: EdgeInsets.all(4),
            child: Row(
              children: <Widget>[
                ClipOval(
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: wallpapers[position].user.avatar,
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(wallpapers[position].user.name),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _handleRefresh() {
    skip = 0;
    wallpapers.clear();
    return getData();
  }

  Future<void> getData() async {
    var dio = HttpUtil.getDio();
    var response = await dio.get(
        GlobalProperties.BASE_URL + GlobalProperties.SPECIAL_URL,
        queryParameters: {'limit': GlobalProperties.limit, 'skip': skip});
    Map map = jsonDecode(response.toString());
    SpecialModelEntity special = SpecialModelEntity.fromJson(map);
    wallpapers.addAll(special.res.album);
    if(mounted){
      setState(() {
        wallpapers = wallpapers;
      });
    }
  }
}
