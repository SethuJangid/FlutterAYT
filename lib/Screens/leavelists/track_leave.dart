import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/leavelists/leave_application.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:AYT_Attendence/pages/homepage.dart';
import 'package:AYT_Attendence/sidebar/bottom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:AYT_Attendence/Screens/leavelists/model/TrackLeaveModel.dart';

class MyTrackLeave extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyTrackLeave> {
  String unique_id2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      unique_id2 = sharedPreferences.getString("unique_id");
    });
  }

  Future<TrackLeaveModel> loadStudent() async {
    //var endpointUrl ="http://adiyogitechnosoft.com/attendance_dev/api/leave/NODS5X5N5V2H2Z";
    var endpointUrl =
        All_API().baseurl + All_API().api_apply_leave + unique_id2;
    print("NotificationUrl--> " + endpointUrl);
    try {
      var response = await http.get(endpointUrl, headers: {
        All_API().key: All_API().keyvalue,
      });
      print("TrackLeaveResponse--> " + response.body);
      var jasonDataNotification = jsonDecode(response.body);
      var msg = jasonDataNotification['msg'];
      if (response.statusCode == 200) {
        return TrackLeaveModel.fromJson(jasonDataNotification);
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(
            msg),backgroundColor: Colors.green,));
        /*final snackBar = SnackBar(
          content: Text(
            msg,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
      }
    } catch (Exception) {
      return Exception;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppConfig.appColorMain,
          title: Container(
            margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
            child: Text(
              'Track Leave',
              style: TextStyle(color: AppConfig.appBarTextColor),
            ),
          ),
        ),
        body: FutureBuilder<TrackLeaveModel>(
                  future: loadStudent(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text('none');
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                        return Text('');
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.data.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                int status =
                                int.parse(snapshot.data.data[index].status);
                                var notificationlist =
                                snapshot.data.data[index];
                                var strFrom =
                                notificationlist.fromDate.toString();
                                var StrdateFrom = strFrom.split(" ");
                                var dateFrom = StrdateFrom[0].trim();
                                /////
                                var strTo = notificationlist.toDate.toString();
                                var StrdateTo = strTo.split(" ");
                                var dateTo = StrdateTo[0].trim();
                                return status == 0
                                    ? Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                        // topRight: Radius.circular(10.0),
                                        // bottomRight: Radius.circular(10.0),
                                        // topLeft: Radius.circular(10.0),
                                        // bottomLeft: Radius.circular(10.0),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        top: 5,
                                        left: 5,
                                        bottom: 5,
                                        right: 5),
                                    child: ListTile(
                                      contentPadding:
                                      EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 10.0),
                                      leading: Container(
                                        padding:
                                        EdgeInsets.only(right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(
                                                    width: 5.0,
                                                    color: Colors.red))),
                                        child: Image.asset(
                                          "assets/rejected_ap.png",
                                          height: 70,
                                          width: 60,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      title: Padding(
                                        padding:
                                        const EdgeInsets.all(2.0),
                                        child: Text(
                                          notificationlist.name
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.orange,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                      subtitle: Column(
                                        children: <Widget>[
                                          Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54),
                                              children: [
                                                TextSpan(
                                                  text: '$dateFrom',
                                                ),
                                                WidgetSpan(
                                                  child: Icon(
                                                      Icons
                                                          .arrow_right_sharp,
                                                      color:
                                                      Colors.black54),
                                                ),
                                                TextSpan(
                                                  text: '$dateTo',
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      // trailing:
                                      //  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 30.0)),
                                    ),
                                  ),
                                )
                                    : status == 1
                                    ? Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                        // topRight: Radius.circular(10.0),
                                        // bottomRight: Radius.circular(10.0),
                                        // topLeft: Radius.circular(10.0),
                                        // bottomLeft: Radius.circular(10.0),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        top: 5,
                                        left: 5,
                                        bottom: 5,
                                        right: 5),
                                    child: ListTile(
                                      contentPadding:
                                      EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 10.0),
                                      leading: Container(
                                        padding: EdgeInsets.only(
                                            right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(
                                                    width: 5.0,
                                                    color: Colors
                                                        .blue))),
                                        child: Image.asset(
                                          "assets/pending_ap.png",
                                          height: 70,
                                          width: 60,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      title: Padding(
                                        padding:
                                        const EdgeInsets.all(2.0),
                                        child: Text(
                                          notificationlist.name
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.orange,
                                              fontWeight:
                                              FontWeight.w200),
                                        ),
                                      ),
                                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                      subtitle: Column(
                                        children: <Widget>[
                                          Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color:
                                                  Colors.black54),
                                              children: [
                                                TextSpan(
                                                  text: '$dateFrom',
                                                ),
                                                WidgetSpan(
                                                  child: Icon(
                                                      Icons
                                                          .arrow_right_sharp,
                                                      color: Colors
                                                          .black54),
                                                ),
                                                TextSpan(
                                                  text: '$dateTo',
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      // trailing:
                                      //  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 30.0)),
                                    ),
                                  ),
                                )
                                    : Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                        // topRight: Radius.circular(10.0),
                                        // bottomRight: Radius.circular(10.0),
                                        // topLeft: Radius.circular(10.0),
                                        // bottomLeft: Radius.circular(10.0),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        top: 5,
                                        left: 5,
                                        bottom: 5,
                                        right: 5),
                                    child: ListTile(
                                      contentPadding:
                                      EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 10.0),
                                      leading: Container(
                                        padding: EdgeInsets.only(
                                            right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(
                                                    width: 5.0,
                                                    color: Colors
                                                        .green))),
                                        child: Image.asset(
                                          "assets/approved_ap.png",
                                          height: 70,
                                          width: 60,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      title: Padding(
                                        padding:
                                        const EdgeInsets.all(2.0),
                                        child: Text(
                                          notificationlist.name
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.orange,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                      subtitle: Column(
                                        children: <Widget>[
                                          Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color:
                                                  Colors.black54),
                                              children: [
                                                TextSpan(
                                                  text: '$dateFrom',
                                                ),
                                                WidgetSpan(
                                                  child: Icon(
                                                      Icons
                                                          .arrow_right_sharp,
                                                      color: Colors
                                                          .black54),
                                                ),
                                                TextSpan(
                                                  text: '$dateTo',
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      // trailing:
                                      //  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 30.0)),
                                    ),
                                  ),
                                );
                              });
                        } else
                          return Center(
                            child: Card(
                              color: Colors.blue[1000],
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  All_API().two_error_occurred,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.orange,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                    }
                  }),


        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[1000],
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LeaveApplication()));
          },
          tooltip: "Add Early Checkout",
          child: Icon(
            Icons.add,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
}
