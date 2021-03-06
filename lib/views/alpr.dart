import 'dart:convert';
import 'dart:io';

import 'package:alpr_x/services/plate_recogniser_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ALPR extends StatefulWidget {
  @override
  _ALPRState createState() => _ALPRState();
}

class _ALPRState extends State<ALPR> {
  File _image;
  final String API_TOKEN = 'Token 5fd073409dd7239a9d071e7b4f292744c1abe267';
  var results;
  String _imageBase64;
  final _picker = ImagePicker();

  Future getImage() async {
    var pickedImage = await _picker.getImage(source: ImageSource.gallery);
    _image = File(pickedImage.path);
    var imageBytes = await _image.readAsBytes();
    String imageBase64 = base64Encode(imageBytes);

    setState(() {
      _image = _image;
      _imageBase64 = imageBase64;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Center(
          child: Text(
            "Licence Plate recognizer",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15)),
              width: 300,
              height: 300,
              child: Center(
                  child: _image == null
                      ? Text("No image selected")
                      : Image.file(
                          _image,
                          fit: BoxFit.cover,
                        )),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: RaisedButton(
                child: Text(
                  "Get Plate Number ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                onPressed: () async {
                  if (_imageBase64 != null) {
                    var plateNumber = await plateRecogniser(_imageBase64);
                    results = plateNumber;
                    setState(() {
                      print(plateNumber.toString());
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                results == null ? "" : results,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          getImage();
        },
        label: Text("Take Picture"),
        icon: Icon(Icons.camera),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
