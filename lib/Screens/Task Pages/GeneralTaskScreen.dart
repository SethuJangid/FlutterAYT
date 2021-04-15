import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralTaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GeneralTaskState();
  }
}

class GeneralTaskState extends State<GeneralTaskScreen> {

  int _bottomBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConfig.appColorMain,
        title: Padding(
          padding: const EdgeInsets.only(left: 6.0, top: 5.0),
          child: Text("Task",style: TextStyle(color: AppConfig.appBarTextColor),)
        ),
      ), //AppBar ,
      //body:VerticalBar(),
    );
  }
}