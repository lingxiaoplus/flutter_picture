import 'dart:convert';

import 'package:flutter/material.dart';

import '../GlobalProperties.dart';
import 'category.dart';
import 'detail/VerticalDetail.dart';

class VerticalPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return VerticalPageState();
  }

}

class VerticalPageState extends State<VerticalPage>
    with SingleTickerProviderStateMixin{
  var tabTitles = ["最新", "最热"];
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabTitles.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('手机壁纸'),
          bottom: TabBar(
            tabs:
            tabTitles.map((String title) => new Tab(text: title)).toList(),
            isScrollable: false,
            labelPadding: EdgeInsets.all(1),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            controller: tabController,
          ),
        ),
        body: TabBarView(
            controller: tabController,
            children: <Widget>[
              VerticalDetail(url: GlobalProperties.BASE_URL + GlobalProperties.VERTICAL_URL + "?order=new"),
              VerticalDetail(url: GlobalProperties.BASE_URL + GlobalProperties.VERTICAL_URL + "?order=hot"),
        ]),
      ));
  }
}