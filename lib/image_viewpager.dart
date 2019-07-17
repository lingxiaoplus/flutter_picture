import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'GlobalProperties.dart';

class ImageViewPage extends StatefulWidget {
  List<String> images;
  int position;

  ImageViewPage(
      {Key key, @required List<String> this.images, int this.position = 0})
      : super(key: key);

  @override
  _ImageViewPageState createState() => _ImageViewPageState(position: this.position);
}

class _ImageViewPageState extends State<ImageViewPage> {
  _ImageViewPageState(
      {int this.position = 0})
      : super();
  PageController _pageController;
  int position = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.position,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('${position+1}/${widget.images.length}'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('评论')));
                }),
            IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('分享')));
                }),
            IconButton(
                icon: const Icon(Icons.file_download),
                onPressed: () {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('下载')));
                }),
          ],
        ),
        body: PageView.builder(
          itemBuilder: _itemViewBuild,
          controller: _pageController,
          itemCount: widget.images.length,
          onPageChanged: (int position) {
            setState(() {
              this.position = position;
            });
          },
        ),
      ),
    );
  }

  Widget _itemViewBuild(BuildContext context, int position) {
    return FadeInImage.assetNetwork(
        placeholder: 'assets/ic_next_video_placeholder.png',
        image: widget.images[position] + GlobalProperties.ImgRule_720,
        width: 50,
        height: 50,
        fit: BoxFit.fitWidth);
  }
}
