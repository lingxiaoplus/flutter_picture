import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: '浏览'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  var tabTitles = ["推荐", "分类", "最新", "专辑"];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  //定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
  static GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      child: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: Text(widget.title),
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
                icon: Image.asset(
                  'assets/ic_appbar_search.png',
                  width: 20,
                  height: 20
                ),
                onPressed: () => _globalKey.currentState
                    .showSnackBar(SnackBar(content: Text('搜索')))),
            IconButton(
                icon: Image.asset(
                  'assets/ic_appbar_more.png',
                  width: 20,
                  height: 20,
                ),
                onPressed: () {}),
          ],
          bottom: TabBar(
            tabs:
                tabTitles.map((String title) => new Tab(text: title)).toList(),
            isScrollable: false,
            labelPadding: EdgeInsets.all(1),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
          ),
        ),
        drawer: new MenuDrawer(),
        body: TabBarView(
          children: tabTitles.map((e) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                e,
                textScaleFactor: 5,
              ),
            );
          }).toList(),
        ),
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
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.network(
                  "http://s.cn.bing.net/th?id=OHR.PeelCastle_ZH-CN6366204379_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp",
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
