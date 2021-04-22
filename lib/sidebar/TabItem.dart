import 'dart:convert';
import 'dart:io';

import 'package:AYT_Attendence/API/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:http/http.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';


class TabItem extends StatefulWidget {

  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  List <File> fileImageArray = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImages() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarTitle: "FlutterCorner.com",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }

    setState(() {
      images = resultList;
    });
    /*resultList.forEach((imageAsset) async {
      //final filePath = await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
      final filePath = await getTemporaryDirectory();

      File tempFile = File(filePath.path+"/"+imageAsset.name.toString());
      fileImageArray.add(tempFile);
      print("images2---->"+filePath.path+"/"+imageAsset.name.toString());
      *//*if (tempFile.existsSync()) {
        fileImageArray.add(tempFile);
        print("images2---->"+tempFile.path);
      }*//*
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Multi Image Picker'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Pick images"),
              onPressed: pickImages,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(images.length, (index) {
                  Asset asset = images[index];
                  print("Assets---->"+asset.name);
                  return AssetThumb(
                    asset: asset,
                    width: 300,
                    height: 300,
                  );
                }),
              ),
            ),
            RaisedButton(
              child: Text("Upload images"),
              onPressed: (){
                //uploadmultipleimage();
                profileUpload();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future profileUpload() async {
    var uri = Uri.parse(All_API().baseurl+All_API().api_general_task_upload);
    print("profile image URL--->" + uri.toString());
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    var request = http.MultipartRequest('POST', (uri));
    request.fields.addAll({
      'employee_id': 'NODP9Y6N6X7F0I8Q2P5W8Q',
      'description': 'sac',
      'task_id': '1'
    });
    images.forEach((imageAsset) async {
      final filePath = await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
      File tempFile = File(filePath);
      fileImageArray.add(tempFile);
      print("images2---->"+tempFile.path);
      MultipartFile file = await http.MultipartFile.fromPath('image[]',tempFile.path);
      print("Filename----->"+file.filename);
      request.files.add(file);
    });
    request.headers.addAll(headers);
    try{
      http.StreamedResponse streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("Expenses---> : " + response.body);
      Map json = jsonDecode(response.body);
      String mssg = json['msg'];
      if (response.statusCode == 200) {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Profile Updated Successfully!!')));
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Not Updated !!')));
      }
    }catch(e){
      print("Error------->"+e.toString());
    }
  }

}
