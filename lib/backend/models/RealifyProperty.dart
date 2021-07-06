import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:Realify/backend/models/Proposal.dart';

class RealifyProperty {
  // String selectedpropertyCategoryType;
  // List propertyFeatures = [];
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
  List<String> images;
  RealifyProperty({
    // this.propertyFeatures = const [],
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
    this.images = const [],
  });
  // double area;
  // String permitNumber;
  // String contactDetails;
  // int contactPhoneNumber;

  @override
  String toString() {
    return 'RealifyProperty(id: $id, proposal: $proposal, county: $county, name: $name, subCategoryType: $subCategoryType, categoryType: $categoryType, price: $price, bedrooms: $bedrooms, bathrooms: $bathrooms, image: $image, details: $details, description: $description, locality: $locality, location: $location, paymentPeriod: $paymentPeriod, area: $area, areaUnit: $areaUnit, phone: $phone, email: $email, images: $images)';
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
        listEquals(other.images, images);
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
        images.hashCode;
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
      'images': images,
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
      images: List<String>.from(map['images']),
    );
  }

  factory RealifyProperty.fromSnapshot(DocumentSnapshot snapshot) {
    return RealifyProperty(
      //  propertyFeatures: List.from(snapshot['propertyFeatures']),
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
      email: snapshot['email'],
      images: List<String>.from(snapshot['images']),
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
    List<String> images,
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
      images: images ?? this.images,
    );
  }
}

final proposalList = [
  // Proposal(name: "Buy"),
  Proposal(name: "rent"),
];
final propertyCategoryTypeList = ["Residential", "Commercial"];
final residentialCategoryTypeList = [
  "Apartment",
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
  "6",
  "7",
  "8+",
];
final bathroomList = [
  "0",
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
