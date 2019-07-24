import 'package:flutter/material.dart';
import 'package:flutter_picture/animation/RxBus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../GlobalProperties.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  List<Item> _data;
  bool openDark = false;
  bool openDalyImage = true;  //是否开启日图

  bool isColorExpanded = false;

  @override
  void initState() {
    super.initState();
    print('>>>>>>>>>>>>>>  ${GlobalProperties.colors.length}');
    _data = generateItems(GlobalProperties.colors.length);
    getLocalProperties();
  }

  void getLocalProperties() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool light = prefs.getBool(GlobalProperties.THEME_BRIGHTNESS_LIGHT);
    bool dalyImage = prefs.getBool(GlobalProperties.OPEN_DALY_IMAGE);
    if (light != null) {
      setState(() {
        openDark = !light;
      });
    }
    if(dalyImage != null){
      setState(() {
        openDalyImage = dalyImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            _buildPanel(),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                InkWell(
                  child: _buildSwitch(
                      ListTile(
                        title: Text('夜间模式'),
                        leading: getSvg('assets/md-cloudy-night.svg'), )
                      ,openDark,
                      changedLightTheme),
                  onTap: () {
                    changedLightTheme(openDark);
                  },
                ),
                InkWell(
                  child: _buildSwitch(
                      ListTile(
                        title: Text('${openDalyImage?"开启":"关闭"}首页启动图片'),
                        leading: getSvg('assets/img_daly.svg'), )
                      ,openDalyImage,
                      changeDalyImage),
                  onTap: () {
                    changeDalyImage(openDalyImage);
                  },
                )
              ],
            ),
            DecoratedBox(
                decoration: BoxDecoration(
                    border: Border(
                        top: Divider.createBorderSide(context,
                            color: Colors.cyan, width: 25),
                        bottom: Divider.createBorderSide(context,
                            color: Colors.cyan, width: 25)))),
          ],
        ),
      ),
    );
  }

  void changedLightTheme(bool opened){
    setState(() {
      openDark = !opened;
    });
    postBrightChanged(openDark);
  }

  void changeDalyImage(bool opened) async{
    setState(() {
      openDalyImage = !opened;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(GlobalProperties.OPEN_DALY_IMAGE, openDalyImage);
  }

  void postBrightChanged(bool opened) {
    ChangeThemeEvent event;
    if (opened) {
      event = new ChangeThemeEvent(brightness: Brightness.dark);
    } else {
      event = new ChangeThemeEvent(brightness: Brightness.light);
    }
    RxBus.instance.post(event);
  }

  List<Item> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return Item(
          headerValue: 'Panel $index',
          expandedValue: 'This is item number $index',
          color: GlobalProperties.colors[index]);
    });
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          isColorExpanded = !isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return InkWell(
              child: ListTile(
                title: Text(
                  '主题换肤',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                leading: getSvg('assets/ic_theme.svg',
                    color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                setState(() {
                  isColorExpanded = !isExpanded;
                });
              },
            );
          },
          body: Wrap(
            children: _data.asMap().keys.map((index) {
              return InkWell(
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: _data[index].color)),
                  ),
                ),
                onTap: () {
                  var themeData = Theme.of(context).copyWith(
                    brightness: Brightness.light,
                    primaryColor: _data[index].color,
                  );

                  ChangeThemeEvent event = new ChangeThemeEvent(
                      color: _data[index].color, position: index);
                  RxBus.instance.post(event);
                },
              );
            }).toList(),
          ),
          isExpanded: isColorExpanded,
        ),
      ],
    );
  }

  Widget _buildSwitch(ListTile listTile,bool opened,ValueChanged<bool> valueChanged) {
    return Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: listTile,
          ),
          Expanded(
            flex: 1,
            child: Switch.adaptive(
              value: opened,
              activeColor: Colors.pink,
              onChanged: valueChanged,
            ),
          )
        ],
      );
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Card(
              margin: EdgeInsets.only(top: 4.0,bottom: 4.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: listTile,
                      ),
                      Expanded(
                        flex: 1,
                        child: Switch.adaptive(
                          value: opened,
                          activeColor: Colors.pink,
                          onChanged: valueChanged,
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 2.0,
                    color: Colors.grey,
                  )
                ],
              ),
            )
        ),
      ],
    );
  }

  Widget getSvg(String name, {Color color}) {
    var pic = SvgPicture.asset(
      name,
      color: color,
    );
    return SizedBox(
      width: 25,
      height: 25,
      child: pic,
    );
  }
}

class Item {
  Item(
      {this.expandedValue,
      this.headerValue,
      this.isExpanded = false,
      this.color = Colors.white});

  String expandedValue;
  String headerValue;
  bool isExpanded;
  Color color;
}

class ChangeThemeEvent {
  MaterialColor color;
  int position;
  Brightness brightness;

  ChangeThemeEvent(
      {this.color, this.brightness = Brightness.light, this.position = 0});
}
