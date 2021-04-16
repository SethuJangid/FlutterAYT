import 'package:AYT_Attendence/Screens/Task%20Pages/GeneralTaskScreen.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/ProjectTaskScreen.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/widgets/dashed_rect.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/widgets/heading.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/widgets/project_card_tile.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class TaskDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: true,
        backgroundColor: AppConfig.appColorMain,
        centerTitle: false,
        title: Padding(
            padding: const EdgeInsets.only(left: 6.0, top: 5.0),
            child: Text("Task",style: TextStyle(color: AppConfig.appBarTextColor),)
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(children: [
          SizedBox(
            height: 22,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GeneralTaskScreen()));
                },
                child: Card(
                  color: Colors.orangeAccent,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          AppConfig.generalTaskIcon,
                          height: 150,
                          width: 150,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "General Task",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProjectTaskScreen()));
                },
                child: Card(
                  color: Colors.orangeAccent,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          AppConfig.projectTaskIcon,
                          height: 150,
                          width: 150,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Your Project",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Heading(
            text: Text(
              "Recent Task",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            button: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(8),
                color: Colors.grey,
                child: Center(
                  child: Icon(
                    Icons.navigate_next,
                    size: 28,
                    color: Colors.orange,
                  ),
                ),
                strokeWidth: 1,
                dashPattern: [3, 4]),
          ),
          SizedBox(
            height: 12.0,
          ),
          Container(
            child: ProjectCardTile()
          )
        ]),
      ),
    );
  }
}
