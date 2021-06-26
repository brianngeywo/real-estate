import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class RealifyPropertyApiProvider {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String uuid = Uuid().v1();
  // uploadProperty(RealifyProperty property) async {
  //   await firebaseFirestore.collection("properties").doc(uuid).set({
  //     'location': property.location,
  //     'propertyTitle': property.propertyTitle,
  //     'propertyDesc': property.propertyDesc,
  //     'propertyPrice': property.propertyPrice,
  //     'area': property.area,
  //     'permitNumber': property.permitNumber,
  //     'contactDetails': property.contactDetails,
  //     'contactPhoneNumber': property.contactPhoneNumber,
  //   }).then((value) => uuid ="");
  // }
  reportPropertyListing(
      String typeOfProblem, String name, String phone, String description, BuildContext context,
      RealifyProperty property) async {
    await firebaseFirestore.collection("property reports").doc(uuid).set({
      "name": name,
      "phone": phone,
      "description": description,
      "type": typeOfProblem,
      "property id": uuid,
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
