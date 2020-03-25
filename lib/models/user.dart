
import 'package:equatable/equatable.dart';
import 'package:tinder_carousel/models/models.dart';
import 'package:tinder_carousel/models/name.dart';

class User extends Equatable{
  final String gender;
  final Name name; //title,first, last
  final Location location; //street,city,state,postcode
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

  static User fromJson(dynamic result) {
    print(result.toString());
    return User(
      gender: result["gender"],
      name: Name.fromJson(result["name"]),
      location: Location.fromJson(result["location"]),
      email: result["email"],
      login: LoginInfo.fromJson(result["login"]),
      dob: DateTime.parse(result["dob"]),
      registered: DateTime.parse(result["registered"]),
      phone: result["phone"],
      cell: result["cell"],
      id: result["id"],
      picture: result["picture"],
      nat: result["nat"]
    );
  }

  dynamic toJson() {
    Map<String, dynamic> m = new Map();
    m['gender'] = gender;
    m['name'] = name.toJson();
    m['location'] = location.toJson();
    m['email'] = email;
    m['login'] = login.toJson();
    m['dob'] = dob.toString();
    m['registered'] = registered.toString();
    m['phone'] = phone;
    m['cell'] = cell;
    m['id'] = id.toString();
    m['picture'] = picture;
    m['nat'] = nat;

    return m;
  }  

}
