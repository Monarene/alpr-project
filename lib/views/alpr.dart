import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ALPR extends StatefulWidget {
  @override
  _ALPRState createState() => _ALPRState();
}

class _ALPRState extends State<ALPR> {
  File _image;
  final String API_TOKEN = 'Token 5fd073409dd7239a9d071e7b4f292744c1abe267';
  String results;
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
    return imageBase64;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Licence Plate recognizer"),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.blue),
              child: Center(
                child: Text(
                  'Automatic License Plate Number Recogniser',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                ),
              ),
              width: 310,
            ),
          ),
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
                    : Image.file(_image)),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.blue),
            child: Center(
              child: Text(
                "platenumber Appears here...",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Montserrat'),
              ),
            ),
            height: 80,
            width: 350,
          ),
        ],
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
