import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/member/MyProperties/rentalList.dart';
import 'package:Realify/presentation/themes/TypoGraphy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RentalTabBar extends StatefulWidget {
  const RentalTabBar({ Key key }) : super(key: key);

  @override
  _RentalTabBarState createState() => _RentalTabBarState();
}

class _RentalTabBarState extends State<RentalTabBar> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("rentals")
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(color: ColorConfig.lightGreen),
            ),
          );
        }
        if (snapshot.data == null || snapshot.data.docs.isEmpty) {
          return Center(
            child: SizedBox(
              height: 50,
              // width: 50,
              child: Text("You haven't posted any property",
                  style: TextStyle(
                    fontSize: Sizeconfig.large,
                    color: ColorConfig.dark,
                    fontFamily: FontConfig.regular,
                  )),
            ),
          );
        }
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
                children: snapshot.data.docs.map((element) {
              RealifyProperty property = RealifyProperty.fromSnapshot(element);

              return Padding(
                padding: EdgeInsets.only(top: 20, right: 15, left: 15),
                child: MyRentalsList(
                  property: property,
                ),
              );
            }).toList()),
          );
        }
        return Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(color: ColorConfig.lightGreen),
          ),
        );
      },
    );
  }
}