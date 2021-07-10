import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
import 'package:Realify/presentation/member/ContactUs/CountryCode.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/HomePage/main.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController messageTextEditingController = TextEditingController();
  RealifyPropertyRepository repository = RealifyPropertyRepository();
  String name = "";
  String phone = "";
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.light,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      iconSize: Sizeconfig.huge,
                      color: ColorConfig.dark,
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0.1),
                    child: Text(
                      "Contact Us",
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
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: Text(
                        "Leave us a message and we'll get back to you shortly.",
                        style: TextStyle(
                          fontFamily: FontConfig.regular,
                          fontSize: Sizeconfig.small,
                          color: ColorConfig.greyDark,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 0.0, left: 23.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        controller: nameTextEditingController,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          color: ColorConfig.dark,
                          fontFamily: FontConfig.regular,
                          fontSize: Sizeconfig.small,
                        ),
                        cursorHeight: 20,
                        cursorColor: ColorConfig.darkGreen,
                        decoration: InputDecoration(
                            hintText: "Name",
                            hintStyle: TextStyle(
                              fontFamily: FontConfig.regular,
                              fontSize: Sizeconfig.small,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Icon(
                                Foundation.asterisk,
                                color: ColorConfig.darkGreen,
                                size: Sizeconfig.small,
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.5, right: 20.0, left: 20.0),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                   Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 0.0, left: 23.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                          });
                        },
                        controller: phoneTextEditingController,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          color: ColorConfig.dark,
                          fontFamily: FontConfig.regular,
                          fontSize: Sizeconfig.small,
                        ),
                        cursorHeight: 20,
                        cursorColor: ColorConfig.darkGreen,
                        decoration: InputDecoration(
                            hintText: "Phone number",
                            hintStyle: TextStyle(
                              fontFamily: FontConfig.regular,
                              fontSize: Sizeconfig.small,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Icon(
                                Foundation.asterisk,
                                color: ColorConfig.darkGreen,
                                size: Sizeconfig.small,
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.5, right: 20.0, left: 20.0),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, right: 0.0, left: 23.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            message = value;
                          });
                        },
                        controller: messageTextEditingController,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color: ColorConfig.dark,
                          fontFamily: FontConfig.regular,
                          fontSize: Sizeconfig.small,
                        ),
                        cursorHeight: 20,
                        cursorColor: ColorConfig.darkGreen,
                        decoration: InputDecoration(
                            hintText: "Your Message",
                            hintStyle: TextStyle(
                              fontFamily: FontConfig.regular,
                              fontSize: Sizeconfig.small,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Icon(
                                Foundation.asterisk,
                                color: ColorConfig.darkGreen,
                                size: Sizeconfig.small,
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.5, right: 20.0, left: 20.0),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Foundation.asterisk,
                            color: ColorConfig.darkGreen,
                            size: Sizeconfig.small,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "All Fields are required",
                              style: TextStyle(
                                fontFamily: FontConfig.regular,
                                fontSize: Sizeconfig.small,
                                color: ColorConfig.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Container(
                        width: 100,
                        child: MaterialButton(
                          elevation: 0.0,
                          color: ColorConfig.darkGreen,
                          onPressed: () {
                            repository.sendContactMessage(name, phone, message, context);
                            setState(() {
                              nameTextEditingController.text = "";
                              phoneTextEditingController.text = "";
                              messageTextEditingController.text = "";
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Ionicons.ios_send,
                                size: Sizeconfig.large,
                                color: ColorConfig.light,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "SEND",
                                  style: TextStyle(
                                    color: ColorConfig.light,
                                    fontSize: Sizeconfig.small,
                                    fontFamily: FontConfig.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Divider(
                        height: 1,
                        thickness: 2,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 15.0, right: 10.0),
                      child: Text(
                        "GIVE US A CALL",
                        style: TextStyle(
                          fontFamily: FontConfig.bold,
                          fontSize: Sizeconfig.medium,
                          color: ColorConfig.dark,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15.0, right: 10.0),
                      child: Text(
                        "Feel free to give us a call on the following number",
                        style: TextStyle(
                          fontFamily: FontConfig.regular,
                          fontSize: Sizeconfig.small,
                          color: ColorConfig.dark,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          "+254798767470",
                          style: TextStyle(
                            fontFamily: FontConfig.bold,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.greyDark,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 100,
                        child: MaterialButton(
                          elevation: 0.0,
                          color: ColorConfig.darkGreen,
                          onPressed: () {
                            urlLauncher.launch("tel:+254798767470");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Ionicons.ios_call,
                                size: Sizeconfig.large,
                                color: ColorConfig.light,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "CALL",
                                  style: TextStyle(
                                    color: ColorConfig.light,
                                    fontSize: Sizeconfig.small,
                                    fontFamily: FontConfig.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     top: 3.5,
                    //   ),
                    //   child: Divider(
                    //     height: 1,
                    //     thickness: 2,
                    //     color: Colors.grey.withOpacity(0.5),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       top: 15, left: 15.0, right: 10.0),
                    //   child: Text(
                    //     "OR JUST WALK IN",
                    //     style: TextStyle(
                    //       fontFamily: FontConfig.bold,
                    //       fontSize: Sizeconfig.medium,
                    //       color: ColorConfig.dark,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       top: 10, left: 15.0, right: 10.0),
                    //   child: Text(
                    //     "Morbi venenatis, mi et placerat dignissim,odio magna ultricies massa, sed rhoncus justo ipsum et ex.",
                    //     style: TextStyle(
                    //       fontFamily: FontConfig.regular,
                    //       fontSize: Sizeconfig.small,
                    //       color: ColorConfig.dark,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 10),
                    //   child: Center(
                    //     child: Text(
                    //       "         Office 345, Building -98\n       Dubai Design District (G5)\nPP Box 58768957 Dubai, United Arab\n                   Emirates",
                    //       style: TextStyle(
                    //         fontFamily: FontConfig.bold,
                    //         fontSize: Sizeconfig.tiny,
                    //         color: ColorConfig.greyDark,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Center(
                    //   child: Container(
                    //     width: 100,
                    //     child: RaisedButton(
                    //       elevation: 0.0,
                    //       color: ColorConfig.darkGreen,
                    //       onPressed: () {},
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Icon(
                    //             Fontisto.map_marker_alt,
                    //             size: Sizeconfig.large,
                    //             color: ColorConfig.light,
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.only(top: 5),
                    //             child: Text(
                    //               "MAP",
                    //               style: TextStyle(
                    //                 color: ColorConfig.light,
                    //                 fontSize: Sizeconfig.small,
                    //                 fontFamily: FontConfig.bold,
                    //               ),
                    //               textAlign: TextAlign.center,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     top: 3.5,
                    //     bottom: 10,
                    //   ),
                    //   child: Divider(
                    //     height: 1,
                    //     thickness: 2,
                    //     color: Colors.grey.withOpacity(0.5),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
