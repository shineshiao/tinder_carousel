import 'package:equatable/equatable.dart';

class Location extends Equatable{
  final String street;
  final String city;
  final String state;
  final int postcode;

  Location({
    this.street,
    this.city,
    this.state,
    this.postcode
  });
  @override
  List<Object> get props => [street,city,state,postcode];

  static Location fromJson(dynamic json){
    return Location(
      street: json["street"],
      city: json["city"],
      state: json["state"],
      postcode: json["postcode"]);
  }

  dynamic toJson() {
    Map<String,dynamic> m = new Map();
    m["street"] = street;
    m["city"] = city;
    m["state"] = state;
    m["postcode"] = postcode;

    return m;
  }
}