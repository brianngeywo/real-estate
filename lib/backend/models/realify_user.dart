import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RealifyUser {
  final String name;
  final String phone;
  final String role;
  final String id;
  final String email;
  final String photoUrl;
  RealifyUser({
    this.name = '',
    this.phone = '',
    this.role = '',
    this.id = '',
    this.email = '',
    this.photoUrl = '',
  });

  RealifyUser copyWith({
    String name,
    String phone,
    String role,
    String id,
    String email,
    String photoUrl,
  }) {
    return RealifyUser(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      id: id ?? this.id,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'role': role,
      'id': id,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory RealifyUser.fromMap(Map<String, dynamic> map) {
    return RealifyUser(
      name: map['name'],
      phone: map['phone'],
      role: map['role'],
      id: map['id'],
      email: map['email'],
      photoUrl: map['photoUrl'],
    );
  }

  factory RealifyUser.fromSnapshot(DocumentSnapshot snapshot) {
    return RealifyUser(
      name: snapshot['name'],
      phone: snapshot['phone'],
      role: snapshot['role'],
      id: snapshot['id'],
      photoUrl: snapshot['photoUrl'],
      email: snapshot['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RealifyUser.fromJson(String source) => RealifyUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RealifyUser(name: $name, phone: $phone, role: $role, id: $id, email: $email, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RealifyUser &&
      other.name == name &&
      other.phone == phone &&
      other.role == role &&
      other.id == id &&
      other.email == email &&
      other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      phone.hashCode ^
      role.hashCode ^
      id.hashCode ^
      email.hashCode ^
      photoUrl.hashCode;
  }
}
