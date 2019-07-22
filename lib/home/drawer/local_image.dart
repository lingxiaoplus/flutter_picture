import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class LocalImagePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return null;
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
    );
  }

  List<String> pictures;
  Future<void> _getLocalImages() async {
    try{
      final List<String> list = await platform.invokeMethod("getLocalImages");
      pictures = list;
      print('获取到的本地图片$list');
    } on PlatformException catch(e){
      pictures = [];
    }
    setState(() {

    });
  }
}