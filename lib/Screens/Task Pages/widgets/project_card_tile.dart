import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class ProjectCardTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, snapshot) {
        return Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(
              horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0)
              ),
            ),
            margin: const EdgeInsets.only(
                top: 5, left: 2, bottom: 5, right: 2),
            child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 5.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 5.0,
                              color: Colors.green))),
                  child: Image.asset(
                    AppConfig.iconApproved,
                    height: 70,
                    width: 60,
                    fit: BoxFit.contain,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Task Name",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 5.0)),
                        Text("10 Task",
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                              Icons.date_range_rounded,
                              color: AppConfig.fontColor),
                        ),
                        Text(
                          "12-03-2021 TO 24-03-2021",
                          style: TextStyle(
                              fontSize: 14,
                              color:
                              Colors.black54,
                              fontWeight:
                              FontWeight
                                  .w600),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Colors.black54,
                    size: 30.0)),
          ),
        );
      }
    );
  }
}
