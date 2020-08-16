import 'package:flutter/material.dart';
import

String plateRecogniser(Image image) {
  var response = await http
      .post("https://api.platerecognizer.com/v1/plate-reader/", body: {
    "upload": imageBase64
  }, headers: {
    "Authorization": "Token 5fd073409dd7239a9d071e7b4f292744c1abe267"
  });

  var json = convert.jsonDecode(response.body);

  PlateNumberModel plateModel = new PlateNumberModel();
  var results = PlateNumberModel.fromMap(json["results"]["plate"]);
}