import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';


class NeswDetail extends StatefulWidget{
  String image;
  String path;
  String title;
  String description;
  String author;
  NeswDetail({this.image,this.path,this.title,this.description,this.author});
  @override
  newsDetailState createState() => newsDetailState();
}

class newsDetailState extends State<NeswDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Container(
          child: Text(
            'News Details', style: TextStyle(color: AppConfig.appBarTextColor),),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppConfig.appColorMain,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.network(widget.path+widget.image,fit:BoxFit.fill,height: 2000,width: 2000,),
            ),
          ),
          Expanded(
              flex: 4,
              child: ListView(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Column(
                      children: [
                        Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(widget.description,style: TextStyle(fontSize: 15),),
                        ),
                        Padding(padding: EdgeInsets.all(6.0),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.author,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                maxLines: 2,
                              ),
                            ],
                          ),),
                        //Text(widget.author,textAlign: TextAlign.end,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ],
                    ),

                ],

              )
          )
        ],
      ),
    );
  }
}