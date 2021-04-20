import 'dart:convert';
import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:AYT_Attendence/model/NewsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'All_News.dart';


class newsFeeds extends StatefulWidget{
  @override
  newsFeedsState createState() => newsFeedsState();
}

class newsFeedsState extends State<newsFeeds> {
  String statuscode;
  String statusno="200";
  Future<Newsmodel>newsdetail() async {
    var endpointUrl = All_API().baseurl + All_API().api_news;
    Map<String, String>  queryParameter={
      'status':'1',
    };
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + '?' + queryString;
    print(requestUrl);
    try {
      var response = await http.get(requestUrl,headers: {
        All_API().key: All_API().keyvalue,
      });
      print("News : "+response.body);
      print("StatusCODE : "+response.statusCode.toString());
       statuscode=response.statusCode.toString();
      print("StatusCODE_News : "+statuscode);
      if(response.statusCode==200){
        var jsonString = response.body;
        print("News : "+jsonString);
        var jsonMap = json.decode(jsonString);
        return Newsmodel.fromJson(jsonMap);
      }
    }
    catch(Exception){
      return Exception;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    /*return Column(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('News Feeds',
                    style: TextStyle(
                      fontSize: 20, color: Colors.blue[1000],),
                  ),
                ),
              ),
              Container(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text('View All'),
                        color: Colors.orange,
                        textColor: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue[1000])
                        ),
                        // padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                        splashColor: Colors.blue[1000],
                        onPressed: () async {
                          //onpressed gets called when the button is tapped.
                          print("StatusCODE_onCheck : "+statuscode);
                          // ignore: unrelated_type_equality_checks
                          if(statuscode == statusno){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>All_News()));
                          }else{
                            Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text(
                                'No Data Found'),backgroundColor: Colors.red,));
                            *//*final snackBar = SnackBar(content: Text('No Data Found',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);*//*
                          }
                        },
                      ),
                    ),
                  ),

            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: FutureBuilder<Newsmodel>(
            future: newsdetail(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                var path=All_API().baseurl_img+snapshot.data.path;
                return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      var article = snapshot.data.data[index];
                      return Row(
                        children: [
                          Card(
                            elevation: 8,
                            child: Container(
                              width: screenSize.width * 0.7,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white10,
                                      offset: Offset(0, 20),
                                      blurRadius: 30.0),
                                  BoxShadow(
                                      color: Colors.white30,
                                      offset: Offset(0, 20),
                                      blurRadius: 30.0)
                                ],
                              ),
                              child:Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      leading: Image.network(path+article.image,),
                                      title: Text(article.title,style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),maxLines: 2,),
                                      subtitle: Text(article.description,style: TextStyle(fontSize: 12,color: Colors.black),maxLines: 2,),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                );
              }else if(snapshot.hasData==false){
                return Row(
                  children: [
                    Card(
                      elevation: 8,
                      child: Container(
                        width: screenSize.width * 0.7,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white10,
                                offset: Offset(0, 20),
                                blurRadius: 30.0),
                            BoxShadow(
                                color: Colors.white30,
                                offset: Offset(0, 20),
                                blurRadius: 30.0)
                          ],
                        ),
                        child:Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Image.asset("assets/ayt.png",height: 100,width: 50,),
                                title: Text("Tital",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),maxLines: 2,),
                                subtitle: Text("Description",style: TextStyle(fontSize: 12,color: Colors.black),maxLines: 2,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );

              }
              else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );*/
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('News Feeds',
                  style: TextStyle(
                    fontSize: 20, color: Colors.blue[1000],),
                ),
              ),
            ),
            Container(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('View All'),
                      color: AppConfig.buttonColor,
                      textColor: AppConfig.textColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blue[1000])
                      ),
                      // padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                      splashColor: Colors.blue[1000],
                      onPressed: () async {
                        //onpressed gets called when the button is tapped.
                        print("StatusCODE_onCheck : "+statuscode);
                        // ignore: unrelated_type_equality_checks
                        if(statuscode == statusno){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>All_News()));
                        }else{
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text(
                              'No Data Found'),backgroundColor: Colors.red,));
                          /*final snackBar = SnackBar(content: Text('No Data Found',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
                        }
                      },
                    ),
                  ),
                ),

          ],
        ),
        FutureBuilder<Newsmodel>(
          future: newsdetail(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var path=All_API().baseurl_img+snapshot.data.path;
              return Container(
                height: 130,
                child: ListView.builder(
                    itemCount: snapshot.data.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      var article = snapshot.data.data[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          color: AppConfig.fixedCardColor,
                          elevation: 10,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.network(
                                      path+article.image,
                                      height: 100,
                                      width: 150,
                                      fit: BoxFit.fill,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(article.title,
                                      style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                      )
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        article.description,
                                        style: TextStyle(fontSize: 12,color: Colors.black),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                ),
              );
            }else if(snapshot.hasData==false){
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  color: AppConfig.fixedCardColor,
                  elevation: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network(
                              AppConfig.newsImageDefault,
                              height: 100,
                              width: 150,
                              fit: BoxFit.fill,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Title",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),maxLines: 2,),
                            Text("Description",style: TextStyle(fontSize: 12,color: Colors.black),maxLines: 2,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );

            }
            else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}