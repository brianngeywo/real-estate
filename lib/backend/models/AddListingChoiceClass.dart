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
          "https://firebasestorage.googleapis.com/v0/b/realify-75289.appspot.com/o/native%20images%2Fhotel.jpeg?alt=media&token=2a167b4c-34fb-46d3-8559-0d6e497196ad",
      nav: addHotelNav),
];
