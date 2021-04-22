import 'dart:convert';
import 'dart:io';

import 'package:AYT_Attendence/API/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';


class TabItem extends StatefulWidget {

  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

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
      final filePath = await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
      //final filePath = await getTemporaryDirectory();

      File tempFile = File(filePath);
      print("images2---->"+tempFile.path);
      List file = [tempFile.path];
      fileImageArray.add(tempFile);
      print("fileImageArray lenght--->"+fileImageArray.length.toString());

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
              /*onPressed: () async {
                //onpressed gets called when the button is tapped.
                var imagepicker = await ImagePicker.pickImage(
                    source: ImageSource.gallery);
                if (imagepicker != null) {
                  setState(() {
                    print("profileUpload_imagepicker--> " +
                        imagepicker.path);
                    File uploadimage = imagepicker;
                    //startUploading(uploadimage);
                    profileUpload(uploadimage, context);
                  });
                } else {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Please Select Profile Image !!')));

                }
              },*/
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
                //profileUpload();
                profileUpload(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  /*Future profileUpload() async {
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
    List<MultipartFile> newList = new List<MultipartFile>();
    images.forEach((imageAsset) async {
      final filePath = await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
      File tempFile = File(filePath);
      print("images2---->"+tempFile.path);
      var stream = new http.ByteStream(tempFile.openRead());
      var length = await tempFile.length();
      var imageSplit = imageAsset.name.split("-").join();
      print("imageSplit----->"+imageSplit);
      var multipartFile = new http.MultipartFile("image[]", stream, length,
          filename: tempFile.path);
      //var multipartFile = new http.MultipartFile("image[]", stream , length ,filename: tempFile.path);
      newList.add(multipartFile);
      print("multi-->"+multipartFile.filename);
      request.files.addAll(newList);
    });

    request.headers.addAll(headers);
    request.followRedirects = false;
    request.persistentConnection = false;

    try{
      http.StreamedResponse streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("Expenses---> : " + response.body);
      Map json = jsonDecode(response.body);
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
  }*/

  Future profileUpload(BuildContext context) async {

    String url = All_API().baseurl+All_API().api_general_task_upload;
    print("profile image URL--->" + url);
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };
    var formData;
    List<MultipartFile> newList = new List<MultipartFile>();
    Dio dio = new Dio();
    /*images.forEach((imageAsset) async {
      final filePath2 = await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
      final filePath = await getTemporaryDirectory();

      File tempFile = File(filePath2);
      print("path---->"+filePath2);
      print("images---->"+imageAsset.name);
      print("path --- images---->"+filePath.path+"    "+imageAsset.name);
      print("imagesFile---->"+tempFile.path);
      var multipartFile = await MultipartFile.fromFile(tempFile.path,filename: "imageAsset.png");
      print("Type--->"+multipartFile.contentType.type);
      print("Naame-->"+multipartFile.filename);
      print("filePATH-->"+multipartFile.runtimeType.toString());
      newList.add(multipartFile);

      formData = FormData.fromMap({
        'employee_id': 'NODP9Y6N6X7F0I8Q2P5W8Q',
        'description': 'sac',
        'task_id': '2',
        "image[]": [newList]
      });
    });*/
    for(int i=0; i<images.length; i++){
      final filePath2 = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      File tempFile = File(filePath2);
      var multipartFile = await MultipartFile.fromFile(tempFile.path,filename: "imageAsset.png");
      newList.add(multipartFile);
      formData = FormData.fromMap({
        'employee_id': 'NODP9Y6N6X7F0I8Q2P5W8Q',
        'description': 'sac',
        'task_id': '2',
        "image[]": [newList]
      });
    }

    var response = await dio.post(url,options:Options(contentType: "multipart/from-data",headers: headers), data: formData,);
    //final response = await dio.post(url, options: Options(headers: headers), data: formData);
    var pdfText= await json.decode(json.encode(response.data));
        print("Response --------->"+pdfText);
  }

}
