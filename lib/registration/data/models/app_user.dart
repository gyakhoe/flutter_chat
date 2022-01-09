// ignore_for_file: prefer_const_constructors_in_immutables, sort_constructors_first, lines_longer_than_80_chars

import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;

  AppUser({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoUrl,
  });

  AppUser copyWith({
    String? uid,
    String? displayName,
    String? email,
    String? photoUrl,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid']?.toString() ?? '',
      displayName: map['displayName']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      photoUrl: map['photoUrl']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(uid: $uid, displayName: $displayName, email: $email, photoUrl: $photoUrl)';
  }

  @override
  List<Object> get props => [uid, displayName, email, photoUrl];
}
