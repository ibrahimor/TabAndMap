class DefaultLocations {
  double _latitude;
  double _longitude;
  DefaultLocations(double _latitude, double _longitude) {
    this._latitude = _latitude;
    this._longitude = _longitude;
  }

  DefaultLocations.map(dynamic obj) {
    this._latitude = obj['Latitude'];
    this._longitude = obj['Longitude'];
  }

  double get latitude => _latitude;
  double get longitude => _longitude;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["Latitude"] = _latitude;
    map["Longitude"] = _longitude;
    return map;
  }

  DefaultLocations.fromMap(Map<String, dynamic> map) {
    _latitude = map['Latitude'];
    _longitude = map['Longitude'];
  }

  DefaultLocations.fromJson(Map map) {
    _latitude = map['Latitude'];
    _longitude = map['Longitude'];
  }
}
