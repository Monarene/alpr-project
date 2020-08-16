import 'dart:convert' as convert;

import 'package:alpr_x/models/plate_model.dart';
import 'package:http/http.dart' as http;

plateRecogniser(String imageBase64) async {
  var response = await http
      .post("https://api.platerecognizer.com/v1/plate-reader/", body: {
    "upload": imageBase64
  }, headers: {
    "Authorization": "Token 5fd073409dd7239a9d071e7b4f292744c1abe267"
  });

  var json = await convert.jsonDecode(response.body);
  var results = PlateNumberModel.fromMap(json["results"][0]);
  return results.plateNumber;
}
