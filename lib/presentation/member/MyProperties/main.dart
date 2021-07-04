import 'dart:convert';

import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/member/MyProperties/list.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/PropertyDetails/List.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProperties extends StatefulWidget {
  MyProperties({
    Key key,
  }) : super(key: key);
  @override
  _MyPropertiesState createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> with TickerProviderStateMixin {
  TabController tabController;
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 2);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.light,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      iconSize: Sizeconfig.huge,
                      color: ColorConfig.dark,
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0.1),
                    child: Text(
                      "My Properties",
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
            Container(height: 1, width: double.maxFinite, color: ColorConfig.grey.withOpacity(0.3)),
            // Container(
            //   height: 80,
            //   width: MediaQuery.of(context).size.width,
            //   child: TabBar(
            //     controller: tabController,
            //     tabs: [
            //       Tab(
            //         child: Container(
            //           height: 40,
            //           width: MediaQuery.of(context).size.width,
            //           decoration: BoxDecoration(
            //               color: tabController.index == 0 ? ColorConfig.lightGreenBg : ColorConfig.light,
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(3),
            //               ),
            //               border: Border.all(width: 1, color: ColorConfig.smokeLight)),
            //           child: Center(
            //             child: Text(
            //               "Drafts",
            //               style: TextStyle(
            //                   fontFamily: FontConfig.bold, fontSize: Sizeconfig.small, color: ColorConfig.grey),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Tab(
            //         child: Container(
            //           decoration: BoxDecoration(
            //               color: tabController.index == 1 ? ColorConfig.lightGreenBg : ColorConfig.light,
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(3),
            //               ),
            //               border: Border.all(width: 1, color: ColorConfig.smokeLight)),
            //           height: 40,
            //           width: MediaQuery.of(context).size.width,
            //           child: Center(
            //             child: Text(
            //               "Uploaded",
            //               style: TextStyle(
            //                   fontFamily: FontConfig.bold, fontSize: Sizeconfig.small, color: ColorConfig.grey),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .collection("rentals")
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.none) {
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
                                color: ColorConfig.lightGreen,
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
                            child: MyRecommendedList(
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
                  }),

              // FutureBuilder(
              //   future: DefaultAssetBundle.of(context).loadString('assets/json/properties.json'),
              //   builder: (context, snapshot) {
              //     var properties_data = json.decode(snapshot.data.toString());
              //     return ListView.builder(
              //       itemBuilder: (BuildContext context, int index) {
              //         return Column(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              //               child: MyPropertiesList(
              //                 properties_data: properties_data,
              //                 index: index,
              //               ),
              //             ),
              //           ],
              //         );
              //       },
              //       itemCount: properties_data == null ? 0 : properties_data.length,
              //     );
              //   },
              // ),
            ),
            // Container(
            //   height: 68,
            //   width: double.maxFinite,
            //   padding: EdgeInsets.all(10),
            //   color: Colors.white,
            //   child: MaterialButton(
            //     elevation: 0.0,
            //     color: ColorConfig.darkGreen,
            //     onPressed: () {},
            //     child: Text(
            //       "UPLOAD ALL",
            //       style: TextStyle(
            //         color: ColorConfig.light,
            //         fontSize: Sizeconfig.small,
            //         fontFamily: FontConfig.bold,
            //       ),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
