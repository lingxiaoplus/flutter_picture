import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'dart:convert';

import 'package:flutter_picture/GlobalProperties.dart';
class Recommend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecommendState();
  }
}
class RecommendState extends State<Recommend>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecommendList();
  }

  Future getRecommendList() async {
    var dio = new Dio();
    var response = await dio.get(
        GlobalProperties.BASE_URL +
            GlobalProperties.HOMEPAGE_URL,
        queryParameters: {

        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}