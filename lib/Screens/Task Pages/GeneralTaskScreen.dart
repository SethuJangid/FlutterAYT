import 'dart:convert';

import 'package:AYT_Attendence/Screens/Task%20Pages/models/GeneralTaskModel.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_widget/timeline_widget.dart';
import 'package:http/http.dart' as http;

class GeneralTaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GeneralTaskState();
  }
}

class GeneralTaskState extends State<GeneralTaskScreen> {

  var priorityId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generalTask();
  }
  /*getData(String id)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      //var priority = sharedPreferences.getString("priority_id");
      priorityId = id;
      print("#######-------> "+priorityId.toString());
      //print("@@@@@@@@***********-------> "+priority);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConfig.appColorMain,
          title: Padding(
              padding: const EdgeInsets.only(left: 6.0, top: 5.0),
              child: Text(
                "General Task",
                style: TextStyle(color: AppConfig.appBarTextColor),
              )),
        ), //AppBar ,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: TimelineView(
            align: TimelineAlign.rightAlign,
            lineWidth: 4,
            lineColor: Colors.deepOrange,
            imageBorderColor: Colors.white,
            image: [
              Container(
                  padding: EdgeInsets.all(15),
            color: AppConfig.lowColor),
              Container(
                  padding: EdgeInsets.all(15),
                  color: AppConfig.mediumColor),
              Container(
                  padding: EdgeInsets.all(15),
                  color: AppConfig.highColor),
              Container(
                  padding: EdgeInsets.all(15),
                  color: AppConfig.urgentColor),
            ],
            height: 200,
            width: MediaQuery.of(context).size.width,
            imageHeight: 50,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: _widgetWeather()
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child:  _widgetWeather()
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: _widgetWeather()
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child:  _widgetWeather()
              ),
            ],
          ),
        ),
    );
  }

  Widget _widgetWeather() {
    return priorityId!=null?FutureBuilder<GeneralTaskModel>(
      future: generalTask(),
      builder: (context, snapshot) {
        print("data--->"+snapshot.data.msg);
        return Container(
            height: 100,
            child: ListView.builder(
                itemCount: snapshot.data.data.length,//snapshot.data.data.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var task = snapshot.data.data[index];
                  //priorityId = task.priorityId;
                  print("---------> "+snapshot.data.data.length.toString());
                  return task.priorityId=="1"?Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1.0,
                          blurRadius: 30.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          task.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          task.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ):
                  task.priorityId=="2"?Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1.0,
                          blurRadius: 30.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          task.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          task.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ):
                  task.priorityId=="3"?Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1.0,
                          blurRadius: 30.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          task.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          task.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ):
                  task.priorityId=="4"?Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1.0,
                          blurRadius: 30.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          task.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          task.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ):Container();
                }
            ),
          );
      }
    ):Container();
  }

  Future generalTask() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var headers = {
      'X-API-KEY': 'NODN2D0I7W4V8I2K',
      'Cookie': 'ci_session=i7l3ruft0led5lldcvul3ho5m0l8ccsj'
    };
    var request = http.Request(
        'GET', Uri.parse('https://technolite.in/hrpayroll/api/general_task'));

    request.headers.addAll(headers);
    request.followRedirects = false;

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    /*if (response.statusCode == 200) {
      print("General Task--->" + response.body);
      Map json = jsonDecode(response.body);
        //sharedPreferences.setString('priority_id',json['data'][i]['priority_id']);
        print("@@@@@@-------> "+json['data'][json.length]['priority_id'].toString());
        var id = json['data'][json.length]['priority_id'].toString();
        //getData(id);

      return GeneralTaskModel.fromJson(json);

    } else {
      print(response.reasonPhrase);
    }*/
    Map json = jsonDecode(response.body);
    print("@@@@@@-------> "+json['data'][0]['priority_id'].toString());
    priorityId = json['data'][0]['priority_id'].toString();

    return GeneralTaskModel.fromJson(json);
  }
}
