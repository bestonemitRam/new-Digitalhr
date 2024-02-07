import 'Login.dart';

class Loginresponse {

  Loginresponse({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory Loginresponse.fromJson(dynamic json) {
    return Loginresponse(
        status: json['status'],
        message: json['message'],
        statusCode: json['statusCode'],
        data: Login.fromJson(json['data']));
  }


  bool status;
  String message;
  int statusCode;
  Login data;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['statusCode'] = statusCode;
    map['data'] = data.toJson();
    return map;
  }
}
