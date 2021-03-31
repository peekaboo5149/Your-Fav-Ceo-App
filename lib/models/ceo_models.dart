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

  CEO copyWith({
    String id,
    String name,
    String company,
    String designation,
    int upvotes,
    int downvotes,
    String imageurl,
  }) {
    return CEO(
      id: id ?? this.id,
      name: name ?? this.name,
      company: company ?? this.company,
      designation: designation ?? this.designation,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      imageurl: imageurl ?? this.imageurl,
    );
  }

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

  @override
  String toString() {
    return 'CEO(id: $id, name: $name, company: $company, designation: $designation, upvotes: $upvotes, downvotes: $downvotes, imageurl: $imageurl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CEO &&
        other.id == id &&
        other.name == name &&
        other.company == company &&
        other.designation == designation &&
        other.upvotes == upvotes &&
        other.downvotes == downvotes &&
        other.imageurl == imageurl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        company.hashCode ^
        designation.hashCode ^
        upvotes.hashCode ^
        downvotes.hashCode ^
        imageurl.hashCode;
  }
}
