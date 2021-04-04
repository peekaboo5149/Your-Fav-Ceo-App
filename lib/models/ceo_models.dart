import 'dart:convert';

import 'package:flutter/foundation.dart';

class CEO {
  final String id;
  final String name;
  final String company;
  final String designation;
  final int upvotes;
  final int downvotes;
  final String imageurl;

  CEO({
    @required this.id,
    @required this.name,
    @required this.company,
    @required this.designation,
    @required this.upvotes,
    @required this.downvotes,
    @required this.imageurl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'company': company,
      'designation': designation,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'imageurl': imageurl,
    };
  }

  factory CEO.fromMap(Map<String, dynamic> map) {
    return CEO(
      id: map['id'],
      name: map['name'],
      company: map['company'],
      designation: map['designation'],
      upvotes: map['upvotes'],
      downvotes: map['downvotes'],
      imageurl: map['imageurl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CEO.fromJson(String source) => CEO.fromMap(json.decode(source));
}
