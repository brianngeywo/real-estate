import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:Realify/backend/models/Proposal.dart';

class RealifyProperty {
  // String selectedpropertyCategoryType;

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
  List<String> images;
  RealifyProperty({
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
    this.images = const [],
  });
  // double area;
  // String permitNumber;
  // String contactDetails;
  // int contactPhoneNumber;

  @override
  String toString() {
    return 'RealifyProperty(proposal: $proposal, county: $county, name: $name, subCategoryType: $subCategoryType, categoryType: $categoryType, price: $price, bedrooms: $bedrooms, bathrooms: $bathrooms, image: $image, details: $details, description: $description, locality: $locality, location: $location, paymentPeriod: $paymentPeriod, area: $area, areaUnit: $areaUnit, phone: $phone, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RealifyProperty &&
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
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return proposal.hashCode ^
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
        images.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
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
      'images': images,
    };
  }

  factory RealifyProperty.fromMap(Map<String, dynamic> map) {
    return RealifyProperty(
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
      images: List<String>.from(map['images']),
    );
  }

  factory RealifyProperty.fromSnapshot(DocumentSnapshot snapshot) {
    return RealifyProperty(
      proposal: snapshot['proposal'],
      county: snapshot['county'],
      name: snapshot['name'],
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
      images: List<String>.from(snapshot['images']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RealifyProperty.fromJson(String source) => RealifyProperty.fromMap(json.decode(source));

  RealifyProperty copyWith({
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
    List<String> images,
  }) {
    return RealifyProperty(
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
      images: images ?? this.images,
    );
  }
}

final proposalList = [Proposal(name: "Buy"), Proposal(name: "Sell")];
final propertyCategoryTypeList = ["Residential", "Commercial"];
final residentialCategoryTypeList = [
  "Villa",
  "Apartment",
  "Townhouse",
  "Penthouse",
  "Villa\n compound",
  "Hotel\nApartment",
  "Residential\n Plot",
  "Residential\n Floor",
  "Residential\n Building",
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
