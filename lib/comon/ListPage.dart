import 'package:flutter/material.dart';

typedef HeaderWidgetBuild = Widget Function(BuildContext context, int position);
typedef ItemWidgetBuild = Widget Function(BuildContext context, int position);
class ListPage extends StatefulWidget {
  List headerList;
  List listData;
  ItemWidgetBuild itemWidgetCreator;
  HeaderWidgetBuild headerCreator;

  ListPage(List this.listData,{
    Key key,
    List this.headerList,
    ItemWidgetBuild this.itemWidgetCreator,
    HeaderWidgetBuild this.headerCreator
  }):super(key:key);

  @override
  State<StatefulWidget> createState() {
    return ListPageState();
  }

}

class ListPageState extends State<ListPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemBuilder: (BuildContext context, int position){
            return buildItemWidget(context, position);
          },
        itemCount: _getListCount(),   // 参数决定调用 itemBuilder 中回调函数的次数
      ),
    );
  }


  int _getListCount(){
    int itemCount = widget.listData.length;
    return itemCount + _getHeaderCount();
  }

  int _getHeaderCount(){
    int headerCount = widget.headerList != null ? widget.headerList.length:0;
    return headerCount;
  }

  Widget _headerItemWidget(BuildContext context, int position){
    if(widget.headerCreator != null){
      return widget.headerCreator(context,position);
    }else{
      return GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text('banner item $position'),
        ),
        onTap: ()=> print('header click $position --------------------'),
      );
    }
  }

  Widget buildItemWidget(BuildContext context, int position){
    if(position < _getHeaderCount()){
      return _headerItemWidget(context, position);
    }else{
      int pos = position - _getHeaderCount();
      return _ItemWidget(context, pos);
    }
  }

  Widget _ItemWidget(BuildContext context, int position){
    if(widget.itemWidgetCreator != null){
      return widget.itemWidgetCreator(context,position);
    }else{
      return GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text('item $position'),
        ),
        onTap: ()=> print('item click $position --------------------'),
      );
    }
  }

}