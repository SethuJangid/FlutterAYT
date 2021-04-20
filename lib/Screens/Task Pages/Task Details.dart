import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:path/path.dart' as p;


class TaskDetailPage extends StatefulWidget{
  String startDate;
  String endDate;
  String name;
  String priority;
  String description;
  String document;
  String path;
  Color taskColor;
  TaskDetailPage({
    this.startDate,
    this.endDate,
    this.name,
    this.priority,
    this.description,
    this.document,
    this.path,
    this.taskColor
  });
  @override
  _GeneralTaskDetailPageState createState() => _GeneralTaskDetailPageState();
}

class _GeneralTaskDetailPageState extends State<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConfig.appColorMain,
        title: Padding(
            padding: const EdgeInsets.only(left: 6.0, top: 5.0),
            child: Text(
              "Task Detail",
              style: TextStyle(color: AppConfig.appBarTextColor),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: Card(
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              width: 10,
                              color: widget.taskColor)
                      )
                  ),
                  child: ListTile(
                    title: Text(
                      widget.name.toUpperCase(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    trailing: Text(widget.priority),
                  ),
                ),
                Divider(
                  height: 1,
                  color: widget.taskColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Text("Assigned and Expire Date",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: AppConfig.appColorMain,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.date_range,size: 30),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                                fontSize: 17,
                                color:
                                Colors.black54),
                            children: [
                              TextSpan(
                                text: widget.startDate,
                              ),
                              WidgetSpan(
                                child: Icon(
                                    Icons
                                        .arrow_right_sharp,
                                    color: Colors
                                        .black54),
                              ),
                              TextSpan(
                                text: widget.endDate,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Text(
                      "Task Created Date",
                      style: TextStyle(
                          fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: AppConfig.appColorMain,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.date_range,size: 30),
                    ),
                    Text(
                      widget.startDate,
                      style: TextStyle(
                          fontSize: 17,
                          color:
                          Colors.black54),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    "Detail of Project",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: AppConfig.appColorMain,
                ),
                Center(
                  child: Text(
                    widget.description,
                  ),
                ),
                SizedBox(
                  height: 300,
                ),
                Center(
                  child: Text(
                    "Attachments",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: AppConfig.appColorMain,
                ),
                Container(
                  height: 200,
                  child: taskImage(),),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConfig.buttonColor,
        foregroundColor: AppConfig.appColorMain,
        child: Icon(Icons.add,size: 20,),
      ),
    );
  }
  Widget taskImage(){
    List<String> list = getListItems();
    var mylist=GridView.builder(
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
      itemBuilder: (BuildContext context, int index) {
        print("Documents---->"+list[index].trim());
        var docu = widget.path+list[index].trim();
        final extension = p.extension(docu);
        print("Extention----->"+extension);
        return new Card(
          child: GridTile(
            child: extension ==".jpg"?IconButton(
              icon: Icon(
                Icons.image,
                size: 100,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        ShowPDF(
                          document: docu,
                        )));
              },
            ):extension ==".pdf"?IconButton(
              icon: Icon(
                Icons.picture_as_pdf,
                size: 100,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        ShowPDF(
                          document: docu,
                        )));
              },
            ):
            extension ==".png"?IconButton(
              icon: Icon(
                Icons.image,
                size: 100,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        ShowPDF(
                          document: docu,
                        )));
              },
            ):
            extension ==".jpeg"?IconButton(
              icon: Icon(
                Icons.image,
                size: 100,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        ShowPDF(
                          document: docu,
                        )));
              },
            ):
            Container(),
            //just for testing, will fill with image later
          ),
        );
      },
    );
    return mylist;
  }
  List<String> getListItems() {
    return widget.document.split(',');
  }
  var orientation;
}
class ShowPDF extends StatefulWidget {
  String document;
  ShowPDF({this.document});
  @override
  _ShowPDFState createState() => _ShowPDFState();
}

class _ShowPDFState extends State<ShowPDF> {
  bool _isLoading = true;
  PDFDocument doc;
  var extension;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFromUrl();
    extension = p.extension(widget.document);
  }

  void _loadFromUrl() async {
    setState(() {
      _isLoading = true;
    });
    doc = await PDFDocument.fromURL(
        widget.document);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Documents"),
      ),
      body: Center(
        child: _isLoading ? CircularProgressIndicator()
                : PDFViewer(document: doc,),
        ),
    );
  }
}