import 'package:equatable/equatable.dart';

class Name extends Equatable{
  final String title;
  final String first;
  final String last;

  @override
  List<Object> get props => [
    title,
    first,
    last,
  ];

  Name({
    this.title,
    this.first,
    this.last
  });

  static Name fromJson(dynamic json){
    return Name(
      title: json["title"],
      first: json["first"],
      last: json["last"],
    );
  }

  dynamic toJson() {
    Map<String,dynamic> m = new Map();
    m["title"] = title;
    m["first"] = first;
    m["last"] = last;
  }
}