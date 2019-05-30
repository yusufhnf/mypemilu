import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:async';
import 'package:mypemilu/navigation.dart';

class LauncherView extends StatefulWidget {
  @override
  _LauncherViewState createState() => _LauncherViewState();
}

class _LauncherViewState extends State<LauncherView> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }

  startLaunching() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
        return MyHomePage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(),
            Text('MyPemilu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 40)),
            Text(
              'API from pemilu2019.kpu.go.id\nBuild using Flutter by yusufhnf',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            )
          ],
        ),
      )
    );
  }
}