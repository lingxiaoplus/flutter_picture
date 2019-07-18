import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder{
  final Widget widget;
  CustomRoute(this.widget):super(
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder:(BuildContext context,Animation<double> animaton1,
        Animation<double> animaton2,){
      return widget;
    },
    transitionsBuilder:(BuildContext context,
        Animation<double> animaton1,
        Animation<double> animaton2,
        Widget child,){
       //缩放动画效果
       return ScaleTransition(
         scale: Tween(begin: 0.5,end: 1.0).animate(CurvedAnimation(
           parent: animaton1,
           curve: Curves.decelerate
         )),
         child: FadeTransition(
           opacity: Tween(begin: 0.5,end: 1.0).animate(CurvedAnimation(
               parent: animaton1,
               curve: Curves.decelerate)),
           child: child,
         ),
       );
    }
  );
}