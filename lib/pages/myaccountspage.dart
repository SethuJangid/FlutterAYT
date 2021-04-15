import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/chat2/database.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileThreePageState createState() => _ProfileThreePageState();
}

class _ProfileThreePageState extends State<ProfileScreen> {
  String name;
  String uniqId;
  String user_unique_id;
  String email;
  String phone;
  String dob;
  String joining_date;
  String department_id;
  String designation_id;
  String image;
  String image2;
  File uploadimage;

  String designation;
  String department;

  var statusCode;
  Timer timer;
  ProgressDialog pr;

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    DocumentReference doc_ref = Firestore.instance
        .collection("users")
        .document(email)
        .collection("Dates")
        .document();

    DocumentSnapshot docSnap = await doc_ref.get();
    var doc_id2 = docSnap.reference.documentID;
    print("User Document ID" + doc_id2);
    setState(() {
      name = sharedPreferences.getString("name");
      uniqId = sharedPreferences.getString("unique_id");
      user_unique_id = sharedPreferences.getString("user_unique_id");
      email = sharedPreferences.getString("email");
      phone = sharedPreferences.getString("phone");
      dob = sharedPreferences.getString("dob");
      joining_date = sharedPreferences.getString("joining_date");
      department_id = sharedPreferences.getString("department_id");
      designation_id = sharedPreferences.getString("designation_id");
      image = sharedPreferences.getString("image");
      designation = sharedPreferences.getString("designation");
      department = sharedPreferences.getString("department");
      showData(department_id, designation_id);
    });
  }

  showData(String department_id, String designation_id) async {
    department_user_id(department_id);
    designation_user_id(designation_id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    //============================================= loading dialoge
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    //Optional
    pr.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    String path = All_API().baseurl_img + All_API().profile_img_path;
    // var duration = new Duration(seconds: 1);
    //Timer(duration, showData);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConfig.appColorMain,
          title: Container(
            margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
            child: Text(
              'Profile ',
              style: TextStyle(color: AppConfig.appBarTextColor),
            ),
          ),
          /*leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
            color: Colors.orange,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),*/
        ),
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.network(
                  image != null ? path + image : AppConfig.userIconDefault,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(top: 16.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 96.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      name != null ? name : AppConfig.appUserNameDefault,
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(designation != null
                                          ? designation
                                          : AppConfig.appUserDesignationDefault),
                                      subtitle: Text(department != null
                                          ? department
                                          : AppConfig.appUserDepartmentDefault),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Center(
                                child: RaisedButton(
                                  child: Text('Change Image'),
                                  color: AppConfig.buttonColor,
                                  textColor: AppConfig.textColor,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side:
                                          BorderSide(color: Colors.blue[1000])),
                                  padding:
                                      EdgeInsets.fromLTRB(100, 20, 100, 20),
                                  splashColor: Colors.blue[1000],
                                  onPressed: () async {
                                    //onpressed gets called when the button is tapped.
                                    var imagepicker =
                                        await ImagePicker.pickImage(
                                            source: ImageSource.gallery);
                                    if (imagepicker != null) {
                                      setState(() {
                                        print("profileUpload_imagepicker--> " +
                                            imagepicker.path);
                                        uploadimage = imagepicker;
                                        //startUploading(uploadimage);
                                        profileUpload(uploadimage, context);
                                      });
                                    } else {
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(content: Text('Please Select Profile Image !!')));

                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    image != null ? path + image : AppConfig.userIconDefault,
                                  ),
                                  fit: BoxFit.cover)),
                          margin: EdgeInsets.only(left: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text("Employee information"),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Email"),
                            subtitle: Text(email != null ? email : AppConfig.appUserEmailDefault),
                            leading: Icon(Icons.email),
                          ),
                          ListTile(
                            title: Text("Phone"),
                            subtitle: Text(phone != null ? phone : AppConfig.appUserPhoneDefault),
                            leading: Icon(Icons.phone),
                          ),
                          ListTile(
                            title: Text("Employee Id"),
                            subtitle: Text(
                                user_unique_id != null ? user_unique_id : AppConfig.appUserEmployeeIDDefault),
                            leading: Icon(Icons.person),
                          ),
                          ListTile(
                            title: Text("Date of Birth"),
                            subtitle: Text(dob != null ? dob : AppConfig.appUserDOBDefault),
                            leading: Icon(Icons.date_range),
                          ),
                          ListTile(
                            title: Text("Joined Date"),
                            subtitle:
                                Text(joining_date != null ? joining_date : AppConfig.appUserJDDefault),
                            leading: Icon(Icons.calendar_view_day),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void department_user_id(String departmentID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var endpointUrl =
        All_API().baseurl + All_API().api_department + departmentID;
    print("department URL--->" + endpointUrl);
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    var response = await http.get(endpointUrl, headers: headers);
    statusCode = response.statusCode;
    if (statusCode == 200) {
      setState(() {
        Map jasonData = jsonDecode(response.body);
        department = jasonData['data']['name'];
        sharedPreferences.setString("department", department);
        print('Department : ' + department);
        print('Department Data : ' + jasonData.toString());
      });
    }
  }

  void designation_user_id(String designationID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var endpointUrl =
        All_API().baseurl + All_API().api_designation + designationID;
    print("designation URL--->" + endpointUrl);
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    var response = await http.get(endpointUrl, headers: headers);
    if (statusCode == 200) {
      setState(() {
        Map jasonData = jsonDecode(response.body);
        designation = jasonData['data']['name'];
        sharedPreferences.setString("designation", designation);
        print('Designation : ' + designation);
        print('Designation Data : ' + jasonData.toString());
      });
    }
  }





  Future profileUpload(File uploadimage, BuildContext context) async {
    setState(() {
      pr.show();
    });
    //String uni_id="NODS5X5N5V2H2Z";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String url = All_API().baseurl + All_API().api_profile + uniqId;
    print("profile image URL--->" + url);
    String filename = uploadimage.path.split("/image_picker").last;
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    // request.files.add(await http.MultipartFile.fromPath('file', uploadimage.path));
    final file = await http.MultipartFile.fromPath('file', uploadimage.path);
    print("file---> : " + file.toString());
    request.files.add(file);
    request.headers.addAll(headers);

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("Expenses---> : " + response.body);
      String mssg = responseData['msg'];
      if (response.statusCode == 200) {
        setState(() {
          String path = responseData['path'];
          String imageSplit = path.split('/').last;
          image = imageSplit.trim();
          setState(() {
            String pathmain =
                All_API().baseurl_img + All_API().profile_img_path;
            sharedPreferences.setString("image", image);
            Map<String, String> userDataMap = {
              "userName": name,
              "userEmail": email,
              "userImage": pathmain + image,
            };
            DatabaseMethods2().updateUserInfo(userDataMap, email);
          });
          print("Uploaded Image--> " + imageSplit);
          print("Uploaded Image--> " + path);
          pr.hide();
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('Profile Updated Successfully!!')));
        });
      } else {
        pr.hide();
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Not Updated !!')));
      }

    } catch (e) {
      return (e);
    }
  }
}
