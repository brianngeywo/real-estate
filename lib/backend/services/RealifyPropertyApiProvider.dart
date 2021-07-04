import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:uuid/uuid.dart';

class RealifyPropertyApiProvider {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  String uuid = Uuid().v1();
  uploadProperty(proposal, county, category, subCategory, price, bedrooms, locality, propertyName, description,
      rentalFrequency, area, areaUnit, phone, bathrooms, image, imageUrls,) async {
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .collection("rentals")
        .doc(uuid)
        .set({
      "area": area,
      "areaUnit": areaUnit,
      "bathrooms": bathrooms,
      "bedrooms": bedrooms,
      "categoryType": category,
      "county": county,
      "description": description,
      "details": "$bedrooms bedroom $subCategory in $locality, $county",
      "image": image,
      "images": imageUrls,
      "locality": locality,
      "location": locality + ", " + county,
      "name": propertyName,
      "paymentPeriod": rentalFrequency,
      "phone": "254" + phone,
      "email": user.email,
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

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String id = Uuid().v4();
    Reference reference = FirebaseStorage.instance.ref().child("$id/$fileName");
    UploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    String imagesurl = await (await uploadTask).ref.getDownloadURL();
    return imagesurl;
  }
}
