import 'dart:io';
import 'dart:typed_data';
import 'package:Realify/backend/models/realify_user.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/widget/progress_dialog/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool fullNameValid = true;
  bool emailValid = true;
  File _image;
  String profilePictureUrl = "";
  bool isUploading = false;
  updateProfile() {
    setState(() {
      fullNameController.text.length < 3 || fullNameController.text.isEmpty
          ? fullNameValid = false
          : fullNameValid = true;
      !emailController.text.contains("@") || emailController.text.isEmpty ? emailValid = false : emailValid = true;

      if (fullNameValid && emailValid) {
        FirebaseFirestore.instance.collection('users').doc(auth.currentUser.uid).update({
          "name": fullNameController.text,
          "email": emailController.text.trim(),
        }).then((value) {
          SnackBar snackbar = SnackBar(content: Text('update successful, page will update on next visit'));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Align(
                    alignment: Alignment(0, 0.1),
                    child: IconButton(
                      icon: Icon(AntDesign.arrowleft),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      iconSize: Sizeconfig.huge,
                      color: ColorConfig.dark,
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0.1),
                    child: Text(
                      "Personal Information",
                      style: TextStyle(
                        fontFamily: FontConfig.bold,
                        fontSize: Sizeconfig.medium,
                        color: ColorConfig.dark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: ColorConfig.grey.withOpacity(0.3)),
            Expanded(
              flex: 14,
              child: FutureBuilder<DocumentSnapshot>(
                  future:
                      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      RealifyUser user = RealifyUser.fromSnapshot(snapshot.data);
                      return Container(
                        color: ColorConfig.light,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15.0,
                                ),
                                _image != null
                                    ? Center(
                                        child: Container(
                                          height: 120,
                                          width: 120,
                                          child: Image.file(_image),
                                        ),
                                      )
                                    : Center(
                                        child: Container(
                                          height: 120,
                                          width: 120,
                                          child: user.photoUrl.isNotEmpty && user.photoUrl != null
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(1000),
                                                  child: CachedNetworkImage(imageUrl: user.photoUrl, fit: BoxFit.cover),
                                                )
                                              : CircleAvatar(
                                                  backgroundColor: ColorConfig.lightGreen,
                                                  child: Center(
                                                    child: Text(
                                                      "No Picture",
                                                      style: TextStyle(
                                                        color: ColorConfig.dark,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    _image != null
                                        ? MaterialButton(
                                            onPressed: () {
                                              SnackBar snackbar =
                                                  SnackBar(content: Text('Please wait, we are uploading'));
                                              ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                              uploadImages(context);
                                            },
                                            textColor: ColorConfig.light,
                                            color: ColorConfig.lightGreen,
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                "Upload Photo".toUpperCase(),
                                                style: TextStyle(
                                                  color: ColorConfig.light,
                                                  fontFamily: FontConfig.regular,
                                                ),
                                              ),
                                            ),
                                          )
                                        : MaterialButton(
                                            onPressed: getImage,
                                            textColor: ColorConfig.light,
                                            color: ColorConfig.lightGreen,
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                "Choose Photo".toUpperCase(),
                                                style: TextStyle(
                                                  color: ColorConfig.light,
                                                  fontFamily: FontConfig.regular,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    fontSize: Sizeconfig.small,
                                    color: ColorConfig.darkGreen,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 7.0),
                                  child: TextFormField(
                                    controller: fullNameController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText: user.name,
                                      hintStyle: TextStyle(
                                        fontFamily: FontConfig.regular,
                                        fontSize: Sizeconfig.small,
                                        color: ColorConfig.dark,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                // SizedBox(height: 2),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Phone number",
                                  style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    fontSize: Sizeconfig.small,
                                    color: ColorConfig.darkGreen,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 7.0),
                                  child: TextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: user.phone,
                                      hintStyle: TextStyle(
                                        fontFamily: FontConfig.regular,
                                        fontSize: Sizeconfig.small,
                                        color: ColorConfig.dark,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    fontSize: Sizeconfig.small,
                                    color: ColorConfig.darkGreen,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 7.0),
                                  child: TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText: user.email,
                                      hintStyle: TextStyle(
                                        fontFamily: FontConfig.regular,
                                        fontSize: Sizeconfig.small,
                                        color: ColorConfig.dark,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Type",
                                  style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    fontSize: Sizeconfig.small,
                                    color: ColorConfig.darkGreen,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 7.0),
                                  child: Text(
                                    user.role,
                                    style: TextStyle(
                                      fontFamily: FontConfig.regular,
                                      fontSize: Sizeconfig.small,
                                      color: ColorConfig.dark,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Container(
                              child: CircularProgressIndicator(
                                color: ColorConfig.lightGreen,
                              ),
                            )));
                  }),
            ),
            Divider(color: ColorConfig.grey.withOpacity(0.3)),
            Container(
              height: 68,
              width: double.maxFinite,
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: MaterialButton(
                elevation: 0.0,
                color: ColorConfig.darkGreen,
                onPressed: () {
                  updateProfile();
                },
                child: Text(
                  "UPDATE",
                  style: TextStyle(
                    color: ColorConfig.light,
                    fontSize: Sizeconfig.small,
                    fontFamily: FontConfig.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void uploadImages(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "updating profile...",
          );
        });
    postImage(_image).then((_) {
      FirebaseFirestore.instance.collection("users").doc(auth.currentUser.uid).update({
        "photoUrl": profilePictureUrl,
      }).then((_) {
        SnackBar snackbar = SnackBar(content: Text('Uploaded Successfully'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);

        setState(() {
          profilePictureUrl = "";
          _image = null;
        });
        Navigator.of(context).pop();
      });
    }).catchError((err) {
      SnackBar snackbar = SnackBar(content: Text(err));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    });
  }

  Future postImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Uint8List bytes = await imageFile.readAsBytesSync();
    ByteData byteData = ByteData.view(bytes.buffer);
    List<int> imageData = byteData.buffer.asUint8List();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${auth.currentUser.uid}/$fileName"); // To be aligned with the latest firebase API(4.0)
    UploadTask uploadTask = ref.putData(imageData);

    String downloadUrl = await (await uploadTask).ref.getDownloadURL();
    profilePictureUrl = downloadUrl;
    return profilePictureUrl;
  }
}
