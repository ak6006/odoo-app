// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';
// import 'dart:convert';

// User userFromJson(String str) => User.fromJson(json.decode(str));

// String userToJson(User data) => json.encode(data.toJson());

// class User {
//     User({
//         required this.id,
//         required this.userId,
//         required this.partnerId,
//         required this.companyId,
//         required this.userLogin,
//         required this.userName,
//         required this.userLang,
//         required this.userTz,
//         required this.isSystem,
//         required this.dbName,
//         required this.serverVersion,
//     });

//     final String id;
//     final int userId;
//     final int partnerId;
//     final int companyId;
//     final String userLogin;
//     final String userName;
//     final String userLang;
//     final String userTz;
//     final bool isSystem;
//     final String dbName;
//     final int serverVersion;

//     factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         userId: json["userId"],
//         partnerId: json["partnerId"],
//         companyId: json["companyId"],
//         userLogin: json["userLogin"],
//         userName: json["userName"],
//         userLang: json["userLang"],
//         userTz: json["userTz"],
//         isSystem: json["isSystem"],
//         dbName: json["dbName"],
//         serverVersion: json["serverVersion"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "userId": userId,
//         "partnerId": partnerId,
//         "companyId": companyId,
//         "userLogin": userLogin,
//         "userName": userName,
//         "userLang": userLang,
//         "userTz": userTz,
//         "isSystem": isSystem,
//         "dbName": dbName,
//         "serverVersion": serverVersion,
//     };
// }

//     final user = userFromJson(jsonString);



User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  int? userId;
  int? partnerId;
  int? companyId;
  String? userLogin;
  String? userName;
  String? userLang;
  String? userTz;
  bool? isSystem;
  String? dbName;
  int? serverVersion;

  User(
      {this.id,
      this.userId,
      this.partnerId,
      this.companyId,
      this.userLogin,
      this.userName,
      this.userLang,
      this.userTz,
      this.isSystem,
      this.dbName,
      this.serverVersion});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    partnerId = json['partnerId'];
    companyId = json['companyId'];
    userLogin = json['userLogin'];
    userName = json['userName'];
    userLang = json['userLang'];
    userTz = json['userTz'];
    isSystem = json['isSystem'];
    dbName = json['dbName'];
    serverVersion = json['serverVersion'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['partnerId'] = partnerId;
    data['companyId'] = companyId;
    data['userLogin'] = userLogin;
    data['userName'] = userName;
    data['userLang'] = userLang;
    data['userTz'] = userTz;
    data['isSystem'] = isSystem;
    data['dbName'] = dbName;
    data['serverVersion'] = serverVersion;
    return data;
  }
}
