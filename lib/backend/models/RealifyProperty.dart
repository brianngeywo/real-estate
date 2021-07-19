import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:Realify/backend/models/Proposal.dart';
import 'package:Realify/presentation/member/AddProperty/Counties.dart';

class RealifyProperty {
  String id;
  String proposal;
  String county;
  String name;
  String subCategoryType;
  String categoryType;
  String price;
  String bedrooms;
  String bathrooms;
  String image;
  String details;
  String description;
  String locality;
  String location;
  String paymentPeriod;
  String area;
  String areaUnit;
  String phone;
  String email;
  String userId;
  List<String> images;
  List<dynamic> bedroomsOffered;
  List<dynamic> bedroomsOfferedPrice;
  RealifyProperty({
    this.id = '',
    this.proposal = '',
    this.county = '',
    this.name = '',
    this.subCategoryType = '',
    this.categoryType = '',
    this.price = '',
    this.bedrooms = '',
    this.bathrooms = '',
    this.image = '',
    this.details = '',
    this.description = '',
    this.locality = '',
    this.location = '',
    this.paymentPeriod = '',
    this.area = '',
    this.areaUnit = '',
    this.phone = '',
    this.email = '',
    this.userId = '',
    this.images = const [],
    this.bedroomsOffered = const [],
    this.bedroomsOfferedPrice = const [],
  });

  @override
  String toString() {
    return 'RealifyProperty(id: $id, proposal: $proposal, county: $county, name: $name, subCategoryType: $subCategoryType, categoryType: $categoryType, price: $price, bedrooms: $bedrooms, bathrooms: $bathrooms, image: $image, details: $details, description: $description, locality: $locality, location: $location, paymentPeriod: $paymentPeriod, area: $area, areaUnit: $areaUnit, phone: $phone, email: $email, userId: $userId, images: $images, bedroomsOffered: $bedroomsOffered, bedroomsOfferedPrice: $bedroomsOfferedPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RealifyProperty &&
      other.id == id &&
      other.proposal == proposal &&
      other.county == county &&
      other.name == name &&
      other.subCategoryType == subCategoryType &&
      other.categoryType == categoryType &&
      other.price == price &&
      other.bedrooms == bedrooms &&
      other.bathrooms == bathrooms &&
      other.image == image &&
      other.details == details &&
      other.description == description &&
      other.locality == locality &&
      other.location == location &&
      other.paymentPeriod == paymentPeriod &&
      other.area == area &&
      other.areaUnit == areaUnit &&
      other.phone == phone &&
      other.email == email &&
      other.userId == userId &&
      listEquals(other.images, images) &&
      listEquals(other.bedroomsOffered, bedroomsOffered) &&
      listEquals(other.bedroomsOfferedPrice, bedroomsOfferedPrice);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      proposal.hashCode ^
      county.hashCode ^
      name.hashCode ^
      subCategoryType.hashCode ^
      categoryType.hashCode ^
      price.hashCode ^
      bedrooms.hashCode ^
      bathrooms.hashCode ^
      image.hashCode ^
      details.hashCode ^
      description.hashCode ^
      locality.hashCode ^
      location.hashCode ^
      paymentPeriod.hashCode ^
      area.hashCode ^
      areaUnit.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      userId.hashCode ^
      images.hashCode ^
      bedroomsOffered.hashCode ^
      bedroomsOfferedPrice.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'proposal': proposal,
      'county': county,
      'name': name,
      'subCategoryType': subCategoryType,
      'categoryType': categoryType,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'image': image,
      'details': details,
      'description': description,
      'locality': locality,
      'location': location,
      'paymentPeriod': paymentPeriod,
      'area': area,
      'areaUnit': areaUnit,
      'phone': phone,
      'email': email,
      'userId': userId,
      'images': images,
      'bedroomsOffered': bedroomsOffered,
      'bedroomsOfferedPrice': bedroomsOfferedPrice,
    };
  }

  factory RealifyProperty.fromMap(Map<String, dynamic> map) {
    return RealifyProperty(
      id: map['id'],
      proposal: map['proposal'],
      county: map['county'],
      name: map['name'],
      subCategoryType: map['subCategoryType'],
      categoryType: map['categoryType'],
      price: map['price'],
      bedrooms: map['bedrooms'],
      bathrooms: map['bathrooms'],
      image: map['image'],
      details: map['details'],
      description: map['description'],
      locality: map['locality'],
      location: map['location'],
      paymentPeriod: map['paymentPeriod'],
      area: map['area'],
      areaUnit: map['areaUnit'],
      phone: map['phone'],
      email: map['email'],
      userId: map['userId'],
      images: List<String>.from(map['images']),
      bedroomsOffered: List<dynamic>.from(map['bedroomsOffered']),
      bedroomsOfferedPrice: List<dynamic>.from(map['bedroomsOfferedPrice']),
    );
  }

  factory RealifyProperty.fromSnapshot(DocumentSnapshot snapshot) {
    return RealifyProperty(
      proposal: snapshot['proposal'],
      county: snapshot['county'],
      name: snapshot['name'],
      id: snapshot['id'],
      subCategoryType: snapshot['subCategoryType'],
      categoryType: snapshot['categoryType'],
      price: snapshot['price'],
      bedrooms: snapshot['bedrooms'],
      bathrooms: snapshot['bathrooms'],
      image: snapshot['image'],
      details: snapshot['details'],
      description: snapshot['description'],
      locality: snapshot['locality'],
      location: snapshot['location'],
      paymentPeriod: snapshot['paymentPeriod'],
      area: snapshot['area'],
      areaUnit: snapshot['areaUnit'],
      phone: snapshot['phone'],
      userId: snapshot['userId'],
      email: snapshot['email'],
      images: List<String>.from(snapshot['images']),
      bedroomsOffered: List<dynamic>.from(snapshot['bedroomsOffered']),
      bedroomsOfferedPrice: List<dynamic>.from(snapshot['bedroomsOfferedPrice']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RealifyProperty.fromJson(String source) => RealifyProperty.fromMap(json.decode(source));

  RealifyProperty copyWith({
    String id,
    String proposal,
    String county,
    String name,
    String subCategoryType,
    String categoryType,
    String price,
    String bedrooms,
    String bathrooms,
    String image,
    String details,
    String description,
    String locality,
    String location,
    String paymentPeriod,
    String area,
    String areaUnit,
    String phone,
    String email,
    String userId,
    List<String> images,
    List<dynamic> bedroomsOffered,
    List<dynamic> bedroomsOfferedPrice,
  }) {
    return RealifyProperty(
      id: id ?? this.id,
      proposal: proposal ?? this.proposal,
      county: county ?? this.county,
      name: name ?? this.name,
      subCategoryType: subCategoryType ?? this.subCategoryType,
      categoryType: categoryType ?? this.categoryType,
      price: price ?? this.price,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      image: image ?? this.image,
      details: details ?? this.details,
      description: description ?? this.description,
      locality: locality ?? this.locality,
      location: location ?? this.location,
      paymentPeriod: paymentPeriod ?? this.paymentPeriod,
      area: area ?? this.area,
      areaUnit: areaUnit ?? this.areaUnit,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      userId: userId ?? this.userId,
      images: images ?? this.images,
      bedroomsOffered: bedroomsOffered ?? this.bedroomsOffered,
      bedroomsOfferedPrice: bedroomsOfferedPrice ?? this.bedroomsOfferedPrice,
    );
  }
}

final proposalList = [
  Proposal(name: "Buy"),
  Proposal(name: "rent"),
];
final propertyCategoryTypeList = ["Residential", "Commercial"];
final residentialCategoryTypeList = [
  "Apartment",
  "Bed and Breakfast",
  "Bedsitter Apartment",
  "Block of Flats",
  "Bungalow",
  "Chalet",
  "Condo",
  "Duplex",
  "Farm House",
  "House",
  "Mansionette",
  "Mansion",
  "Mini Flat",
  "Penthouse",
  "Room & Parlour",
  "Shared Apartment",
  "Studio Apartment",
  "Town House",
  "Villa",
];
final commercialCategoryTypeList = [
  "Office",
  "Shop",
  "Warehouse",
  "Penthouse",
  "Labour\n camp",
  "Commercial\n Plot",
  "Bulk\n Units",
  "Commercial\n Floor",
  "Commercial\n Building",
  "Factory",
  "Mixed use\n land",
  "Petrol station",
  "Showroom",
  "Other commercial",
];
final rentalFrequencyList = [
  "daily",
  "weekly",
  "monthly",
  "yearly",
];
final bedroomList = [
  "studio",
  "bedsitter",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6+",
];
final bathroomList = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9+",
];
List<County> countyListDrop = [
  County(title: "mombasa", countyCode: 1),
  County(title: "Kwale", countyCode: 2),
  County(title: "Kilifi", countyCode: 3),
  County(title: "Tana River", countyCode: 4),
  County(title: "Lamu", countyCode: 5),
  County(title: "Taita Taveta", countyCode: 6),
  County(title: "Garissa", countyCode: 7),
  County(title: "Wajir", countyCode: 8),
  County(title: "Mandera", countyCode: 9),
  County(title: "Marsabit", countyCode: 10),
  County(title: "Isiolo", countyCode: 11),
  County(title: "Meru", countyCode: 12),
  County(title: "Tharaka-Nithi", countyCode: 13),
  County(title: "Embu", countyCode: 14),
  County(title: "Kitui", countyCode: 15),
  County(title: "Machakos", countyCode: 16),
  County(title: "Makueni", countyCode: 17),
  County(title: "Nyandarua", countyCode: 18),
  County(title: "Nyeri", countyCode: 19),
  County(title: "Kirinyaga", countyCode: 20),
  County(title: "Murang'a", countyCode: 21),
  County(title: "Kiambu", countyCode: 22),
  County(title: "Turkana", countyCode: 23),
  County(title: "West Pokot", countyCode: 24),
  County(title: "Samburu", countyCode: 25),
  County(title: "Trans Nzoia", countyCode: 26),
  County(title: "Uasin Gishu", countyCode: 27),
  County(title: "Elgeyo Marakwet", countyCode: 28),
  County(title: "Nandi", countyCode: 29),
  County(title: "Baringo", countyCode: 30),
  County(title: "Laikipia", countyCode: 31),
  County(title: "Nakuru", countyCode: 32),
  County(title: "Narok", countyCode: 33),
  County(title: "Kajiado", countyCode: 34),
  County(title: "Kericho", countyCode: 35),
  County(title: "Bomet", countyCode: 36),
  County(title: "Kakamega", countyCode: 37),
  County(title: "Vihiga", countyCode: 38),
  County(title: "Bungoma", countyCode: 39),
  County(title: "Busia", countyCode: 40),
  County(title: "Siaya", countyCode: 41),
  County(title: "Kisumu", countyCode: 42),
  County(title: "Homa Bay", countyCode: 43),
  County(title: "Migori", countyCode: 44),
  County(title: "Kisii", countyCode: 45),
  County(title: "Nyamira", countyCode: 46),
  County(title: "Nairobi", countyCode: 47),
];
final lodgingsList = [
  "Hotel",
  "Motel",
  "Resort hotel",
  "Inn",
  "Guest house",
  "Bed and breakfast",
  "Farm stay",
  "Hostel",
  "Mountain hut",
  "Capsule hotel",
  "Camping cabins",
];
