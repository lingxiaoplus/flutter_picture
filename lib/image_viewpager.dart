import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:transparent_image/transparent_image.dart';

import 'GlobalProperties.dart';
import 'HttpUtil.dart';
import 'home/drawer/local_image.dart';

class ImageViewPage extends StatefulWidget {
  List<String> images;
  int position;
  bool imageRule;

  ImageViewPage({Key key,
    @required List<String> this.images,
    int this.position = 0,
    bool this.imageRule = true})
      : super(key: key);

  @override
  _ImageViewPageState createState() =>
      _ImageViewPageState(position: this.position);
}

class _ImageViewPageState extends State<ImageViewPage> with TickerProviderStateMixin{
  _ImageViewPageState({int this.position = 0}) : super();
  PageController _pageController;
  int position = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool showProgress = false;
  double progress = 0.0;
  AnimationController _colorAnimationController;
  Animation<Color> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.position,
    );
    _colorAnimationController = AnimationController(vsync: this);
    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(
        _colorAnimationController
    );

  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: GlobalProperties.HERO_TAG_LOAD_IMAGE + "$position",
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          title: Text('${position + 1}/${widget.images.length}'),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  _scaffoldKey.currentState
                      .showSnackBar(SnackBar(content: Text('评论')));
                  showModalBottomSheet(context: context, builder: (BuildContext context){
                    return LocalImagePage();
                  });
                }),
            IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  _scaffoldKey.currentState
                      .showSnackBar(SnackBar(content: Text('分享')));
                }),
            IconButton(
                icon: const Icon(Icons.file_download),
                onPressed: () {
                  saveFile(widget.images[position]);
                }),
          ],
        ),
        body: Stack(
          children: <Widget>[
            PageView.builder(
              itemBuilder: _itemViewBuild,
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (int position) {
                setState(() {
                  this.position = position;
                });
              },
            ),
            Offstage(
              offstage: !showProgress,
              child: LinearProgressIndicator(
                  value: progress,
                  valueColor: _colorAnimation),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveFile(String url) async {
    setState(() {
      showProgress = true;
    });
    var dio = HttpUtil.getDio();
    var response = await dio.get(
        url,
        options: Options(
            responseType: ResponseType.bytes
        ),
        onReceiveProgress: (int count, int total) {
          setState(() {
            progress = count.toDouble() / total.toDouble();
            _colorAnimationController.value = progress;
          });
        }
    );
    List<int> bytes = response.data;
    var filePath = await ImagePickerSaver.saveFile(
        fileData: Uint8List.fromList(bytes));
    //var saveFile = File.fromUri(Uri.parse(filePath));
    setState(() {
      showProgress = false;
    });
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text('下载成功，文件保存在${filePath}')));
  }

  Widget _itemViewBuild(BuildContext context, int position) {
    /*return FadeInImage.assetNetwork(
        placeholder: 'assets/ic_next_video_placeholder.png',
        image: widget.images[position] + GlobalProperties.ImgRule_720,
        width: 50,
        height: 50,
        fit: BoxFit.fitWidth);*/
    return GestureDetector(
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: widget.images[position],
        fit: BoxFit.fitWidth,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
