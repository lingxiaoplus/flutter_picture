import 'package:flutter/material.dart';
import 'package:flutter_picture/animation/RxBus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../GlobalProperties.dart';
class SettingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingPage>{
  List<Item> _data;
  bool openDark = false;

  bool isColorExpanded = false;
  @override
  void initState() {
    super.initState();
    print('>>>>>>>>>>>>>>  ${GlobalProperties.colors.length}');
    _data = generateItems(GlobalProperties.colors.length);
    getLocalProperties();
  }

  void getLocalProperties() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool light = prefs.getBool(GlobalProperties.THEME_BRIGHTNESS_LIGHT);
    if(light != null){
      setState(() {
        openDark = !light;
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
            Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Flex(direction: Axis.horizontal,children: <Widget>[
                        Expanded(
                          flex: 7,
                          child:InkWell(
                            child: ListTile(
                              title: Text('夜间模式'),
                              leading: const Icon(Icons.theaters),
                            ),
                            onTap: (){
                              setState(() {
                                openDark = !openDark;
                              });
                              postBrightChanged(openDark);
                            },
                          ),
                        ),
                        Expanded(
                            flex:1,
                            child: Switch.adaptive(
                                value: openDark,
                                activeColor: Colors.pink,
                                onChanged: (bool opened){
                                  setState(() {
                                    openDark = opened;
                                  });
                                  postBrightChanged(opened);
                                },),
                        )
                      ],
                      ),
                      Divider(
                        height: 2.0,

                        color: Colors.grey,
                      )

                    ],
                  )),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void postBrightChanged(bool opened){
    ChangeThemeEvent event;
    if(opened) {
      event = new ChangeThemeEvent(brightness: Brightness.dark);
    }else{
      event = new ChangeThemeEvent(brightness: Brightness.light);
    }
    RxBus.instance.post(event);
  }

  List<Item> generateItems(int numberOfItems) {

    return List.generate(numberOfItems, (int index) {
      return Item(
        headerValue: 'Panel $index',
        expandedValue: 'This is item number $index',
        color: GlobalProperties.colors[index]
      );
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
                title: Text('主题换肤'),
                leading: const Icon(Icons.theaters),
              ),
                onTap: (){
                  setState(() {
                    isColorExpanded = !isExpanded;
                  });
                },
              );
            },
            body: Wrap(
              children:
              _data.asMap().keys.map((index) {
                return InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: DecoratedBox(
                          decoration: BoxDecoration(color: _data[index].color)),),),
                  onTap: (){
                    var themeData = Theme.of(context).copyWith(
                      brightness: Brightness.light,
                      primaryColor: _data[index].color,
                    );
                    ChangeThemeEvent event = new ChangeThemeEvent(color: _data[index].color,position: index);
                    RxBus.instance.post(event);
                  },
                );
              }).toList(),
            ),
            isExpanded: isColorExpanded,
          ),
        ],
      /*children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: Wrap(
            children: <Widget>[

            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),*/
    );
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
    this.color = Colors.white
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
  Color color;
}


class ChangeThemeEvent{
  MaterialColor color;
  int position;
  Brightness brightness;
  ChangeThemeEvent({this.color,this.brightness = Brightness.light,this.position=0});
}