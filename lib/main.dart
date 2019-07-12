import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picture/home/recommend.dart';

import 'package:flutter_picture/home/category.dart';

import 'home/gank.dart';
import 'home/special.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var tabTitles = ["推荐", "分类", "最新", "专辑"];
  TabController tabController;

  //定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();
  var appbarText = Text('推荐');

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    tabController = TabController(length: tabTitles.length, vsync: this)
      ..addListener(() {
        setState(() {
          appbarText = Text(tabTitles[tabController.index]);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: appbarText,
        leading: new IconButton(
            icon: Image.asset(
              'assets/ic_appbar_menu.png',
              width: 20,
              height: 20,
            ),
            onPressed: () {
              print('打开抽屉');
              //Scaffold.of(context).openDrawer();
              _globalKey.currentState.openDrawer();
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search,color: Colors.white,),
              onPressed: () => _globalKey.currentState
                  .showSnackBar(SnackBar(content: Text('搜索')))),
          PopupMenuButton(
            padding: EdgeInsets.all(1.0),
            onSelected: (String value) {},
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text('查看下载图片')
                    ],
                  ),
                  value: '查看下载图片',
                ),
                PopupMenuItem(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text('设置')
                    ],
                  ),
                  value: '设置',
                ),PopupMenuItem(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text('反馈')
                    ],
                  ),
                  value: '查看下载图片',
                ),
                PopupMenuItem(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text('关于')
                    ],
                  ),
                  value: '关于',
                )
              ];
            },
          ),
        ],
        bottom: TabBar(
          tabs: tabTitles.map((String title) => new Tab(text: title)).toList(),
          isScrollable: false,
          labelPadding: EdgeInsets.all(1),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.white,
          controller: tabController,
        ),
      ),
      drawer: new MenuDrawer(),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          Recommend(),
          CategoryPage(),
          GankPage(),
          SpecialPage(),
        ],
      ),
    );
  }
}

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeLeft: true,
        removeRight: true,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.network(
                  "http://img5.adesk.com/5d1c6b03e7bce7213b64a529?imageView2/3/h/720",
                  height: 200.0,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'hahahhaha',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  bottom: 10.0,
                )
              ],
            ),
            Expanded(
                child: ListView(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('首页'),
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('手机壁纸'),
                ),
                ListTile(
                  leading: const Icon(Icons.cake),
                  title: const Text('cosplay.la'),
                ),
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('以图搜图'),
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('退出软件'),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
