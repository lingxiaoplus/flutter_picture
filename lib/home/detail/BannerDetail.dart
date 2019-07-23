import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_picture/animation/CustomRoute.dart';
import 'package:flutter_picture/comon/ListPage.dart';
import 'package:flutter_picture/model/banner_model_entity.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../GlobalProperties.dart';
import '../../HttpUtil.dart';
import '../../image_viewpager.dart';

class BannerDetail extends StatefulWidget {
  String id;

  BannerDetail({Key key, String this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BannerState(id: id);
  }
}

class BannerState extends State<BannerDetail>
    with SingleTickerProviderStateMixin {
  BannerState({String this.id}) : super();
  var tabTitles = ["最新", "最热"];
  TabController tabController;
  Text appbarText;
  final String id;
  int skip = 0;
  List<BannerModelResWallpaper> bannerWallpaper = [];
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    if (!id.isEmpty) tabTitles = [];
    tabController = TabController(length: tabTitles.length, vsync: this)
      ..addListener(() {
        setState(() {
          appbarText = Text(tabTitles[tabController.index]);
        });
      });
    getBannerDetail();

  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  Future<void> getBannerDetail() async {
    var dio = HttpUtil.getDio();
    var response = await dio.get(
        GlobalProperties.BASE_URL +
            GlobalProperties.BANNER_URL +
            "/album/$id/wallpaper",
        queryParameters: {
          'limit': GlobalProperties.limit,
          'skip': skip,
          'order': 'new',
        });
    Map map = jsonDecode(response.toString());
    BannerModelEntity bannerModel = BannerModelEntity.fromJson(map);
    bannerModel.res.wallpaper.forEach((f)=>{
      images.add(f.img)
    });
    setState(() {
      bannerWallpaper.addAll(bannerModel.res.wallpaper);
    });
  }

  Future<void> _handleRefresh() async {
    bannerWallpaper.clear();
    getBannerDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ddd'),
          bottom: !id.isEmpty ?null: TabBar(
            tabs:
            tabTitles.map((String title) => new Tab(text: title)).toList(),
            isScrollable: false,
            labelPadding: EdgeInsets.all(1),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            controller: tabController,
          ),
        ),
        body: RefreshIndicator(
            child: ListPage(
              bannerWallpaper,
              itemWidgetCreator: getItemWidget,
            ),
            onRefresh: _handleRefresh),
      ),
    );
  }

  Widget getItemWidget(BuildContext context, int position) {
    return GestureDetector(
      child: Hero(
      tag: GlobalProperties.HERO_TAG_LOAD_IMAGE + "$position",
      child: Card(
          color: Colors.white,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.all(4.0),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: bannerWallpaper[position].preview +
                GlobalProperties.imgRule_230,
            width: 300,
            height: 200,
            fit: BoxFit.cover,
          )),
      ),
      onTap: () {
        Navigator.push(
            context,
            CustomRoute(ImageViewPage(
              images: images,
              position: position,
            )));
        /*Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new ImageViewPage(
                  images: images,
                  position: position,
                )));*/
      },
    );
  }
}
