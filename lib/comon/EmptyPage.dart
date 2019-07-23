import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.hourglass_empty,
              size: 80.0,
            ),
            Text('空空如也!!')
          ],
        ),
      ),
    );
  }
}