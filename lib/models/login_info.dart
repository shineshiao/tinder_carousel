import 'package:equatable/equatable.dart';

class LoginInfo extends Equatable{
  final String userName;
  final String password;
  final String salvador;
  final String salt;
  final String md5;
  final String sha1;
  final String sha256;

  @override
  List<Object> get props => [
    userName,
    password,
    salvador,
    salt,
    md5,
    sha1,
    sha256
  ];

  LoginInfo({
    this.userName,
    this.password,
    this.salvador,
    this.salt,
    this.md5,
    this.sha1,
    this.sha256
  });

  static LoginInfo fromJson(dynamic json){
    return LoginInfo(
      userName: json["username"],
      password: json["password"],
      salvador: json["salvador"],
      salt: json["salt"],
      md5: json["md5"],
      sha1: json["sha1"],
      sha256: json["sha256"]
    );
  }
}