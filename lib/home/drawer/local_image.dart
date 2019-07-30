import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picture/animation/CustomRoute.dart';
import 'package:flutter_picture/comon/ListPage.dart';

import '../../GlobalProperties.dart';
import '../../image_viewpager.dart';
class LocalImagePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LocalImagePageState();
  }
}
class LocalImagePageState extends State<LocalImagePage>{
  static const platform = const MethodChannel('flutter.io/local_image');
  @override
  void initState() {
    super.initState();
    _getLocalImages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("本地图片"),
      ),
      body: ListPage(
        pictures,
        mainAxisExtent: 200.0,
        have_footer: false,
        itemWidgetCreator: getItemWidget,
        onLoadMore: (){

        },
      ),
    );
  }

  Widget getItemWidget(BuildContext context, int position) {
    return Card(
        elevation: 4.0,
        margin: EdgeInsets.all(4.0),
        child: InkWell(
          child: Hero(
              tag: GlobalProperties.HERO_TAG_LOAD_IMAGE + "$position",  //注意这个TAG！！！ 因为在listview中，所以必须再加上位置
              child: Image.file(new File(pictures[position]),fit: BoxFit.cover,)),
          onTap: () {
            /*Navigator.push(
                context,
                CustomRoute(ImageViewPage(
                  images: pictures,
                  position: position,
                  imageRule: false,
                )));*/
          },
        ));
  }

  List<String> pictures = [];
  Future<void> _getLocalImages() async {
    try{
      List<dynamic> list = await platform.invokeMethod("getLocalImages");
      list.forEach((f)=>{
        pictures.add(f)
      });
      setState(() {

      });
      print('获取到的本地图片$pictures');
    } on PlatformException catch(e){
      print("错误： $e");
    }
  }
}