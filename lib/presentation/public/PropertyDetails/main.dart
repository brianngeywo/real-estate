import 'package:Realify/presentation/member/Report/main.dart';
import 'package:Realify/presentation/public/PropertyDetails/image_gallery.dart';
import 'package:readmore/readmore.dart';

import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class PropertyDetails extends StatefulWidget {
  final RealifyProperty property;
  const PropertyDetails({
    Key key,
    @required this.property,
  }) : super(key: key);
  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  bool issaved = true;
  void togglesaved() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 240,
                    width: double.maxFinite,
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomelandImageGallery(
                                    property: widget.property,
                                  ))),
                          child: Container(
                            height: 240,
                            width: double.maxFinite,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: widget.property.images.map((e) {
                                  return Hero(
                                    tag: "image-${widget.property.image}-$e",
                                    child: Image(
                                      image: NetworkImage(
                                        e,
                                      ),
                                      height: 240,
                                      width: 330,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }).toList()),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment(0, 0.1),
                                      child: IconButton(
                                        icon: Icon(AntDesign.arrowleft),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        iconSize: Sizeconfig.huge,
                                        color: ColorConfig.light,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0, 0.1),
                                      child: Text(
                                        "PROPERTY DETAILS",
                                        style: TextStyle(
                                          fontFamily: FontConfig.bold,
                                          fontSize: Sizeconfig.medium,
                                          color: ColorConfig.light,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Align(
                                //       alignment: Alignment(0, 0.1),
                                //       child: IconButton(
                                //         onPressed: () {},
                                //         icon: Icon(Feather.share_2, color: ColorConfig.light, size: Sizeconfig.huge),
                                //       ),
                                //     ),
                                //     Align(
                                //       alignment: Alignment(0, 0.1),
                                //       child: IconButton(
                                //           icon: Icon(
                                //             MaterialIcons.favorite,
                                //             color: (issaved ? ColorConfig.light : ColorConfig.red),
                                //           ),
                                //           onPressed: () {
                                //             setState(() {
                                //               if (issaved) {
                                //                 issaved = false;
                                //               } else {
                                //                 issaved = true;
                                //               }
                                //             });
                                //           }),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 25,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              ),
                              color: ColorConfig.grey,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  FontAwesome.camera,
                                  color: ColorConfig.light,
                                  size: Sizeconfig.tiny,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  widget.property.images.length.toString(),
                                  style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    fontSize: Sizeconfig.tiny,
                                    color: ColorConfig.light,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Text(
                            "\Kshs",
                            style: TextStyle(
                              fontFamily: FontConfig.regular,
                              color: ColorConfig.dark,
                              fontSize: Sizeconfig.compact,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          widget.property.price,
                          style: TextStyle(
                              fontFamily: FontConfig.bold, color: ColorConfig.greyDark, fontSize: Sizeconfig.higantic),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Text(
                            widget.property.paymentPeriod,
                            style: TextStyle(
                              fontFamily: FontConfig.regular,
                              color: ColorConfig.dark,
                              fontSize: Sizeconfig.medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesome.bed,
                              size: Sizeconfig.huge,
                              color: ColorConfig.darkGreen,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                widget.property.bedrooms + " Beds",
                                style: TextStyle(
                                  fontFamily: FontConfig.regular,
                                  fontSize: Sizeconfig.small,
                                  color: ColorConfig.dark,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesome5.bath,
                              size: Sizeconfig.huge,
                              color: ColorConfig.darkGreen,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                widget.property.bathrooms + " Bath",
                                style: TextStyle(
                                  fontFamily: FontConfig.regular,
                                  fontSize: Sizeconfig.small,
                                  color: ColorConfig.dark,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              AntDesign.appstore_o,
                              size: Sizeconfig.huge,
                              color: ColorConfig.darkGreen,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                widget.property.area + " " + widget.property.areaUnit,
                                style: TextStyle(
                                  fontFamily: FontConfig.regular,
                                  fontSize: Sizeconfig.small,
                                  color: ColorConfig.dark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: ColorConfig.grey.withOpacity(0.3),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyLocation()));
                  //     },
                  //     child: Row(
                  //       children: [
                  //         Image(
                  //           image: AssetImage(
                  //             'assets/images/gps.png',
                  //           ),
                  //           height: 60,
                  //           width: 60,
                  //         ),
                  //         SizedBox(
                  //           width: 10,
                  //         ),
                  //         Text(
                  //           "13th Street. 47 W 13th St, New York",
                  //           style: TextStyle(
                  //             fontFamily: FontConfig.bold,
                  //             fontSize: Sizeconfig.medium,
                  //             color: ColorConfig.dark,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Divider(
                  //   color: ColorConfig.grey.withOpacity(0.3),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 15),
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontFamily: FontConfig.regular,
                        fontSize: Sizeconfig.compact,
                        color: ColorConfig.dark,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20, right: 15),
                    child: Text(
                      widget.property.details,
                      style: TextStyle(
                        fontFamily: FontConfig.regular,
                        fontSize: Sizeconfig.tiny,
                        color: ColorConfig.dark,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Type",
                          style: TextStyle(
                            fontFamily: FontConfig.regular,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                        Text(
                          widget.property.subCategoryType,
                          style: TextStyle(
                            fontFamily: FontConfig.bold,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    child: Divider(
                      color: ColorConfig.grey.withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                            fontFamily: FontConfig.regular,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                        Text(
                          "\Kshs" + widget.property.price,
                          style: TextStyle(
                            fontFamily: FontConfig.bold,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    child: Divider(
                      color: ColorConfig.grey.withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Beds",
                          style: TextStyle(
                            fontFamily: FontConfig.regular,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                        Text(
                          widget.property.bedrooms,
                          style: TextStyle(
                            fontFamily: FontConfig.bold,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    child: Divider(
                      color: ColorConfig.grey.withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bath",
                          style: TextStyle(
                            fontFamily: FontConfig.regular,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                        Text(
                          widget.property.bathrooms,
                          style: TextStyle(
                            fontFamily: FontConfig.bold,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    child: Divider(
                      color: ColorConfig.grey.withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Area",
                          style: TextStyle(
                            fontFamily: FontConfig.regular,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                        Text(
                          widget.property.area + " " + widget.property.areaUnit,
                          style: TextStyle(
                            fontFamily: FontConfig.bold,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    child: Divider(
                      color: ColorConfig.grey.withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Purpose",
                          style: TextStyle(
                            fontFamily: FontConfig.regular,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                        Text(
                          widget.property.proposal == "rent" ? "For Rent" : "For Sale",
                          style: TextStyle(
                            fontFamily: FontConfig.bold,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    child: Divider(
                      color: ColorConfig.grey.withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Location",
                          style: TextStyle(
                            fontFamily: FontConfig.regular,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                        Text(
                          widget.property.location,
                          style: TextStyle(
                            fontFamily: FontConfig.bold,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    child: Divider(
                      color: ColorConfig.grey.withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Contact phone number",
                          style: TextStyle(
                            fontFamily: FontConfig.regular,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                        Text(
                          widget.property.phone,
                          style: TextStyle(
                            fontFamily: FontConfig.bold,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    child: Divider(
                      color: ColorConfig.grey.withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20, right: 15),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontFamily: FontConfig.regular,
                        fontSize: Sizeconfig.compact,
                        color: ColorConfig.dark,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20, right: 15),
                    child: ReadMoreText(
                      """${widget.property.description}""",
                      style: TextStyle(
                        fontFamily: FontConfig.regular,
                        fontSize: Sizeconfig.small,
                        color: ColorConfig.greyDark,
                      ),
                      trimLines: 6,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: "Read More",
                      trimExpandedText: "Hide",
                      colorClickableText: Colors.grey,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8.0),
                  //   child: Divider(
                  //     color: ColorConfig.grey.withOpacity(0.3),
                  //   ),
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  //   child: InkWell(
                  //     onTap: () {
                  //       Navigator.push(context, MaterialPageRoute(builder: (context) => Location()));
                  //     },
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Image(
                  //               image: AssetImage(
                  //                 'assets/images/location.png',
                  //               ),
                  //               height: 60,
                  //               width: 60,
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   "Location & Nearby",
                  //                   style: TextStyle(
                  //                     fontFamily: FontConfig.bold,
                  //                     fontSize: Sizeconfig.medium,
                  //                     color: ColorConfig.dark,
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: 5,
                  //                 ),
                  //                 Text(
                  //                   "View Property location and nearby amenities",
                  //                   style: TextStyle(
                  //                     fontFamily: FontConfig.regular,
                  //                     fontSize: Sizeconfig.tiny,
                  //                     color: ColorConfig.dark,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //         Icon(
                  //           AntDesign.arrowright,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8.0),
                  //   child: Divider(
                  //     color: ColorConfig.grey.withOpacity(0.3),
                  //   ),
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  //   child: InkWell(
                  //     onTap: () {
                  //       Navigator.push(context, MaterialPageRoute(builder: (context) => Indices()));
                  //     },
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Image(
                  //               image: AssetImage(
                  //                 'assets/images/compass.png',
                  //               ),
                  //               height: 60,
                  //               width: 60,
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   "Trends & indices",
                  //                   style: TextStyle(
                  //                     fontFamily: FontConfig.bold,
                  //                     fontSize: Sizeconfig.medium,
                  //                     color: ColorConfig.dark,
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: 5,
                  //                 ),
                  //                 Text(
                  //                   "View home value price indices and popularity trends",
                  //                   style: TextStyle(
                  //                     fontFamily: FontConfig.regular,
                  //                     fontSize: Sizeconfig.tiny,
                  //                     color: ColorConfig.dark,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //         Icon(
                  //           AntDesign.arrowright,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8.0),
                  //   child: Divider(
                  //     color: ColorConfig.grey.withOpacity(0.3),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 5, left: 20, right: 15),
                  //   child: Text(
                  //     "Listing provided by",
                  //     style: TextStyle(
                  //       fontFamily: FontConfig.regular,
                  //       fontSize: Sizeconfig.compact,
                  //       color: ColorConfig.dark,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   child: Image(
                  //     image:
                  //         NetworkImage("https://image.freepik.com/free-vector/real-estate-logo-template_1156-724.jpg"),
                  //     height: 150,
                  //     width: MediaQuery.of(context).size.width * 90,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Divider(
                      color: ColorConfig.grey.withOpacity(0.3),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      left: 15,
                      right: 15,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Report(property: widget.property)));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Foundation.flag,
                            size: Sizeconfig.huge,
                            color: ColorConfig.darkGreen,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Report a problem with this property",
                            style: TextStyle(
                              fontFamily: FontConfig.bold,
                              fontSize: Sizeconfig.small,
                              color: ColorConfig.darkGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  // Divider(
                  //   color: ColorConfig.grey.withOpacity(0.3),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 5, left: 20, right: 15),
                  //   child: Text(
                  //     "Recommended Properties",
                  //     style: TextStyle(
                  //       fontFamily: FontConfig.regular,
                  //       fontSize: Sizeconfig.compact,
                  //       color: ColorConfig.dark,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   height: 580,
                  //   child: FutureBuilder(
                  //       future: DefaultAssetBundle.of(context).loadString('assets/json/recommended.json'),
                  //       builder: (context, snapshot) {
                  //         var recommended_data = json.decode(snapshot.data.toString());
                  //         return ListView.builder(
                  //           physics: ScrollPhysics(),
                  //           itemBuilder: (BuildContext context, int index) {
                  //             return Column(
                  //               children: [
                  //                 Padding(
                  //                   padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                  //                   child: RecommendedList(
                  //                     recommended_data: recommended_data,
                  //                     index: index,
                  //                   ),
                  //                 ),
                  //               ],
                  //             );
                  //           },
                  //           itemCount: recommended_data == null ? 0 : recommended_data.length,
                  //         );
                  //       }),
                  // ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Expanded(
                    //   child: FlatButton(
                    //     color: ColorConfig.darkGreen,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(3),
                    //     ),
                    //     onPressed: () {
                    //       Navigator.push(context, MaterialPageRoute(builder: (context) => EmailPage()));
                    //     },
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           MaterialCommunityIcons.email,
                    //           size: Sizeconfig.huge,
                    //           color: ColorConfig.lightGreen,
                    //         ),
                    //         SizedBox(
                    //           width: 5,
                    //         ),
                    //         Text(
                    //           "EMAIL",
                    //           style: TextStyle(
                    //             fontFamily: FontConfig.regular,
                    //             fontSize: Sizeconfig.small,
                    //             color: ColorConfig.light,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: MaterialButton(
                        color: ColorConfig.darkGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        onPressed: () => urlLauncher.launch("tel:+254${widget.property.phone}"),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Ionicons.ios_call,
                              size: Sizeconfig.huge,
                              color: ColorConfig.lightGreen,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "CALL",
                              style: TextStyle(
                                fontFamily: FontConfig.regular,
                                fontSize: Sizeconfig.small,
                                color: ColorConfig.light,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: MaterialButton(
                        color: ColorConfig.darkGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        onPressed: () => urlLauncher.launch(
                            "mailto:${widget.property.email}?subject=ENQUIRY ON ${widget.property.name.toUpperCase()}&body=<body>"),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Ionicons.ios_call,
                              size: Sizeconfig.huge,
                              color: ColorConfig.lightGreen,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "EMAIL",
                              style: TextStyle(
                                fontFamily: FontConfig.regular,
                                fontSize: Sizeconfig.small,
                                color: ColorConfig.light,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
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
