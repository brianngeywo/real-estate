import 'package:Realify/backend/models/Property_image.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/backend/models/places.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RealifyPropertyApiProvider {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  String uuid = Uuid().v1();
  PropertyList propertyList;
  PropertyImage propertyImage;
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
    image,
    imageUrls,
    bedroomsOffered,
    bedroomsOfferedPrice,
    place,
  ) async {
    await firebaseFirestore.collection("users").doc(user.uid).collection("rentals").doc(uuid).set({
      "area": area,
      "areaUnit": areaUnit,
      "bathrooms": bathrooms,
      "bedrooms": bedrooms,
      "categoryType": category,
      "county": place.administrativeAreaLevel1,
      "description": description,
      "details": "$bedrooms bedroom in ${place.formattedAddress}",
      "route": place.route,
      "locality": place.locality,
      "location": place.formattedAddress,
      "country": place.country,
      "lat": place.lat,
      "lng": place.lng,
      "image": image,
      "images": imageUrls,
      "name": propertyName,
      "paymentPeriod": rentalFrequency,
      "bedroomsOffered": bedroomsOffered,
      "bedroomsOfferedPrice": bedroomsOfferedPrice,
      "phone": phone,
      "email": user.email,
      "price": price,
      "proposal": proposal,
      "subCategoryType": subCategory,
      "id": uuid,
      "userId": user.uid
      // "propertyFeatures": property.propertyFeatures
    }).then((value) => uuid = new Uuid().v1());
  }

  updateProperty(proposal, county, category, subCategory, price, bedrooms, locality, propertyName, description,
      rentalFrequency, area, areaUnit, phone, bathrooms, image, imageUrls, propertyId,
    bedroomsOffered,
    bedroomsOfferedPrice,
  ) async {
    await firebaseFirestore.collection("users").doc(user.uid).collection("rentals").doc(propertyId).update({
      "area": area,
      "areaUnit": areaUnit,
      "bathrooms": bathrooms,
      "bedrooms": bedrooms,
      "categoryType": category,
      "county": county,
      "description": description,
      "details": "$bedrooms bedroom in $locality, $county",
      "image": image,
      "images": imageUrls,
      "name": propertyName,
      "paymentPeriod": rentalFrequency,
      "phone": phone,
      "email": user.email,
      "price": price,
      "proposal": proposal,
      "subCategoryType": subCategory,
    });
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
      'email': FirebaseAuth.instance.currentUser.email,
      'phone': phone,
      "message": message,
    }).then((value) => uuid = new Uuid().v1());
    final snackBar = SnackBar(content: Text("Message sent!"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<PropertyImage> postImage(Asset imageFile) async {
    String url;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String id = Uuid().v4();
    firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance.ref("$id/$fileName");
    firebase_storage.UploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    uploadTask.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
      // print('Task state: ${snapshot.state}');
      // print('Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
      // BlocProvider.of<AddPropertyBloc>(context).add(UploadingImagesEvent());
    }, onError: (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      // print(uploadTask.snapshot);

      if (e.code == 'permission-denied') {
        // print('User does not have permission to upload to this reference.');
      }
    });

    // We can still optionally use the Future alongside the stream.

    await uploadTask;
    // print('Upload complete.');
    propertyImage = PropertyImage(url: await (await uploadTask).ref.getDownloadURL());
    return propertyImage;
  }

  Future<PropertyList> uploadFiles(List<Asset> _images) async {
    propertyList = PropertyList(propertyImages: await Future.wait(_images.map((_image) => postImage(_image))));

    return propertyList;
  }

  saveSearchedQuery(String proposal, String propertyCategoryType, String propertySubCategoryType, String bedrooms,
      String minPrice, String maxPrice, String county, String paymentPeriod) {
    var auth = FirebaseAuth.instance;
    auth.currentUser != null
        ? saveUserSearch(auth.currentUser, proposal, propertyCategoryType, propertySubCategoryType, bedrooms, minPrice,
            maxPrice, county, paymentPeriod)
        : saveNormalSearch(proposal, propertyCategoryType, propertySubCategoryType, bedrooms, minPrice, maxPrice,
            county, paymentPeriod);
  }

  saveUserSearch(
    User user,
    String proposal,
    String propertyCategoryType,
    String propertySubCategoryType,
    String bedrooms,
    String minPrice,
    String maxPrice,
    String county,
    String paymentPeriod,
  ) async {
    await firebaseFirestore.collection("users").doc(user.uid).collection("searches").doc(new Uuid().v4()).set({
      "proposal": proposal,
      "propertyCategoryType": propertyCategoryType,
      "propertySubCategoryType": propertySubCategoryType,
      "bedrooms": bedrooms,
      "minPrice": minPrice,
      "maxPrice": maxPrice,
      "county": county,
      "paymentPeriod": paymentPeriod,
    });
  }

  saveNormalSearch(
    String proposal,
    String propertyCategoryType,
    String propertySubCategoryType,
    String bedrooms,
    String minPrice,
    String maxPrice,
    String county,
    String paymentPeriod,
  ) async {
    await firebaseFirestore.collection("searches").doc(new Uuid().v4()).set({
      "proposal": proposal,
      "propertyCategoryType": propertyCategoryType,
      "propertySubCategoryType": propertySubCategoryType,
      "bedrooms": bedrooms,
      "minPrice": minPrice,
      "maxPrice": maxPrice,
      "county": county,
      "paymentPeriod": paymentPeriod,
    });
  }
}
