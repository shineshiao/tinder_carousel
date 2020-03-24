
import 'package:equatable/equatable.dart';
import 'package:tinder_carousel/models/models.dart';

class User extends Equatable{
  final String gender;
  final Map<String,dynamic> name; //title,first, last
  final Map<String,dynamic> location; //street,city,state,postcode
  final String email;
  final LoginInfo login;  //
  final DateTime dob;
  final DateTime registered;
  final String phone;
  final String cell;
  final Map<String,dynamic> id; //name, value
  final Map<String,dynamic> picture; //large,medium,thumnail
  final String nat;

  const User({
      this.gender,
      this.name,
      this.location,
      this.email,
      this.login,
      this.dob,
      this.registered,
      this.phone,
      this.cell,
      this.id,
      this.picture,
      this.nat
    });

  @override
  List<Object> get props => [
    gender,
    name,
    location,
    email,
    login,
    dob,
    registered,
    phone,
    cell,
    id,
    picture,
    nat];

  static User fromJson(dynamic json) {
    final result = json["result"][0];
    return User(
      gender: result["gender"],
      name: result["name"],
      location: result["location"],
      email: result["email"],
      login: result["login"],
      dob: result["dob"],
      registered: result["registered"],
      phone: result["phone"],
      cell: result["cell"],
      id: result["id"],
      picture: result["picture"],
      nat: result["nat"]
    );
  }  

}
