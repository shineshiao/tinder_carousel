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
}