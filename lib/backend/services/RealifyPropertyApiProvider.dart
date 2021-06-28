import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class RealifyPropertyApiProvider {
  var images = [
    "https://images.unsplash.com/photo-1597799029342-ab2546a93ec6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1500&q=80",
    "https://images.unsplash.com/photo-1603123854675-665d2c6c42ba?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1498&q=80",
    "https://images.unsplash.com/photo-1565625443865-2c41cdb647d2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80",
  ];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String uuid = Uuid().v1();
  uploadProperty(
    proposal,
    county,
    category,
    subCategory,
    price,
    bedrooms,
    locality,
    propertyName,
    description,
    rentalFrequency,
    area,
    areaUnit,
    phone,
    bathrooms,
  ) async {
    await firebaseFirestore.collection("rentals").doc(uuid).set({
      "area": area,
      "areaUnit": areaUnit,
      "bathrooms": bathrooms,
      "bedrooms": bedrooms,
      "categoryType": category,
      "county": county,
      "description": description,
      "details": "$bedrooms bedroom $subCategory in $locality, $county",
      "image": images[0],
      "images": images,
      "locality": locality,
      "location": locality + ", " + county,
      "name": propertyName,
      "paymentPeriod": rentalFrequency,
      "phone": "254" + phone,
      "price": price,
      "proposal": proposal,
      "subCategoryType": subCategory,
      "id": uuid,
      // "propertyFeatures": property.propertyFeatures
    }).then((value) => uuid = new Uuid().v1());
  }

  reportPropertyListing(String typeOfProblem, String name, String phone, String description, BuildContext context,
      RealifyProperty property) async {
    await firebaseFirestore.collection("property reports").doc(uuid).set({
      "name": name,
      "phone": phone,
      "description": description,
      "type": typeOfProblem,
      "property id": property.id,
    }).then((value) => uuid = new Uuid().v1());
    final snackBar = SnackBar(content: Text("Thank you! The issue has been sent!"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  sendContactMessageAndDetails(String name, String phone, String message, BuildContext context) async {
    await firebaseFirestore.collection("customer messages").doc(uuid).set({
      'name': name,
      // 'email': email
      'phone': phone,
      "message": message,
    }).then((value) => uuid = new Uuid().v1());
    final snackBar = SnackBar(content: Text("Message sent!"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
