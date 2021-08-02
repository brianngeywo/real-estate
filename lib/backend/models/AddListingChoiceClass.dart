import 'package:Realify/backend/router/router.dart';
import 'package:flutter/foundation.dart';

class AddListingChoiceClass {
  final String title;
  final String url;
  final String nav;
  AddListingChoiceClass({
    @required this.title,
    @required this.url,
    @required this.nav,
  });

  @override
  String toString() => 'AddListingChoiceClass(title: $title)';
}

List<AddListingChoiceClass> addlistingChoicesList = [
  AddListingChoiceClass(
      title: "Add Rental",
      url:
          "https://firebasestorage.googleapis.com/v0/b/realify-75289.appspot.com/o/native%20images%2Frental.jpeg?alt=media&token=2549fa31-8580-40f0-b56a-d7c73405dee9",
      nav: addRentalNav),
  AddListingChoiceClass(
      title: "Add Hotel",
      url:
          "https://firebasestorage.googleapis.com/v0/b/realify-75289.appspot.com/o/native%20images%2Fbed.jpeg?alt=media&token=3c39c2d2-b247-4291-a690-995fd90718b5",
      nav: addHotelNav),
];

List<AddListingChoiceClass> searchlistingChoicesList = [
  AddListingChoiceClass(
      title: "Search Rental",
      url:
          "https://firebasestorage.googleapis.com/v0/b/realify-75289.appspot.com/o/native%20images%2Frent.jpeg?alt=media&token=4b46d7f4-ba7e-4171-bef6-1483d2fb2c59",
      nav: searchRentalNav),
  AddListingChoiceClass(
      title: "Search Hotel",
      url:
          "https://firebasestorage.googleapis.com/v0/b/realify-75289.appspot.com/o/native%20images%2Fhotel2.jpeg?alt=media&token=530259f9-f24a-4a8f-a749-b2bf8bd67909",
      nav: searchHotelNav),
];
