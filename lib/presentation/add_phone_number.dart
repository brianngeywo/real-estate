import 'package:Realify/backend/models/realify_user.dart';
import 'package:Realify/backend/services/authentication_api_provider.dart';
import 'package:Realify/constants/con.dart';
import 'package:Realify/presentation/public/HomePage/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'create_rental_form_field.dart';


class AddPhoneNumberPage extends StatefulWidget {
  const AddPhoneNumberPage({
    Key key,
    this.userId = '',
  }) : super(key: key);
  final String userId;

  @override
  _AddPhoneNumberPageState createState() => _AddPhoneNumberPageState();
}

class _AddPhoneNumberPageState extends State<AddPhoneNumberPage> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  AuthenticationApiProvider authenticationApiProvider = AuthenticationApiProvider();
  RealifyUser user;
  FocusNode focusNode = FocusNode();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String userId = "";
  Future<void> addUser() async {
    user = await authenticationApiProvider.getUser();
    userId = await user.id;
    // Call the user's CollectionReference to add a new user
    return users.doc(userId).update({
      'phone number': textController1.text,
      'location': textController2.text,
      'public name': textController3.text,
    }).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
  }

  String hintText = "";
  bool showHint = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text(
          "HomeLand",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Update your profile"),
                  createRentalFormFieldsWidget(context, 40, 'enter professional name/company name', TextInputType.name,
                      textController3, focusNode2),
                  createRentalFormFieldsWidget(
                      context, 40, 'enter phone number', TextInputType.number, textController1, focusNode),
                  createRentalFormFieldsWidget(
                      context, 40, 'place/region of work', TextInputType.streetAddress, textController2, focusNode1),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Align(
                      alignment: const Alignment(0, -1),
                      child: SizedBox(
                        child: MaterialButton(
                          onPressed: () {
                            if (textController2.text.isNotEmpty &&
                                (textController1.text.isNotEmpty && textController3.text.isNotEmpty)) {
                              addUser();
                            } else {
                              setState(() {
                                showHint = true;
                                hintText = "All fields must be filled";
                              });
                            }
                          },
                          child: const Text("Add phone number"),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    showHint ? hintText : "",
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
