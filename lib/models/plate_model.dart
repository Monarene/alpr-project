class PlateNumberModel {
  String plateNumber;

  PlateNumberModel({this.plateNumber});

  factory PlateNumberModel.fromMap(Map<String, dynamic> parsedJson) {
    return PlateNumberModel(plateNumber: parsedJson["plate"]);
  }
}
