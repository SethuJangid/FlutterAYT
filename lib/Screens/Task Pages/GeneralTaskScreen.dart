import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class GeneralTaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GeneralTaskState();
  }
}

class GeneralTaskState extends State<GeneralTaskScreen> {

  List taskList = ['Low','Medium','High','Urgent'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConfig.appColorMain,
        title: Padding(
          padding: const EdgeInsets.only(left: 6.0, top: 5.0),
          child: Text("General Task",style: TextStyle(color: AppConfig.appBarTextColor),)
        ),
      ), //AppBar ,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
        child: Timeline.tileBuilder(
          builder: TimelineTileBuilder.fromStyle(
            contentsAlign: ContentsAlign.reverse,
            contentsBuilder: (context, index) => Text(taskList[index]),
            itemCount: 4,
          ),
        ),
      ),
    );
  }
}