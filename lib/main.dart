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
  var tabTitles = ["推荐","分类","最新","专辑"];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: new IconButton(
              icon: Image.asset('assets/ic_appbar_menu.png',width: 20,height: 20,),
              onPressed:()=>SnackBar(content: Text('hello'),duration: Duration(seconds: 2))),
          actions: <Widget>[
            IconButton(
                icon: Image.asset('assets/ic_appbar_search.png',width: 20,height: 20,),
                onPressed: null),
            IconButton(
                icon: Image.asset('assets/ic_appbar_more.png',width: 20,height: 20,),
                onPressed: null),
          ],
          bottom: TabBar(
            tabs: tabTitles.map((String title)=> new Tab(text: title)).toList(),
            isScrollable: false,
            labelPadding: EdgeInsets.all(1),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
