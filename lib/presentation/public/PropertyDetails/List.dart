import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/PropertyDetails/main.dart';

class RecommendedList extends StatefulWidget {
  RecommendedList({Key key, this.recommended_data, this.index}) : super(key: key);
  final recommended_data;
  int index;

  @override
  _RecommendedListState createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {
  bool islike = true;
  RealifyProperty property;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyDetails(property: property)));
          },
          child: Container(
            height: 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorConfig.grey.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5),
                      )),
                      child: Image(
                        fit: BoxFit.cover,
                        height: 150,
                        width: 98,
                        image: NetworkImage(
                          "" + widget.recommended_data[widget.index]['image'],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 20,
                        width: 65,
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
                              MaterialCommunityIcons.check_underline,
                              color: ColorConfig.light,
                              size: Sizeconfig.tiny,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Property",
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
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        "\Kshs",
                                        style: TextStyle(
                                          fontFamily: FontConfig.regular,
                                          color: ColorConfig.dark,
                                          fontSize: Sizeconfig.tiny,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "" + widget.recommended_data[widget.index]["price"],
                                      style: TextStyle(
                                        fontFamily: FontConfig.bold,
                                        color: ColorConfig.greyDark,
                                        fontSize: Sizeconfig.large,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 3,
                                      ),
                                      child: Text(
                                        "yearly",
                                        style: TextStyle(
                                          fontFamily: FontConfig.regular,
                                          color: ColorConfig.dark,
                                          fontSize: Sizeconfig.tiny,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "" + widget.recommended_data[widget.index]["location"],
                                  style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    color: ColorConfig.grey,
                                    fontSize: Sizeconfig.tiny,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                MaterialIcons.favorite,
                                color: (islike ? ColorConfig.grey.withOpacity(0.2) : ColorConfig.red),
                                size: Sizeconfig.huge,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (islike) {
                                    islike = false;
                                  } else {
                                    islike = true;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Apartments",
                          style: TextStyle(
                            fontFamily: FontConfig.regular,
                            color: ColorConfig.grey,
                            fontSize: Sizeconfig.tiny,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "" + widget.recommended_data[widget.index]["bedroom"],
                              style: TextStyle(
                                fontFamily: FontConfig.bold,
                                fontSize: Sizeconfig.tiny,
                              ),
                            ),
                            Text(
                              "" + widget.recommended_data[widget.index]["bathroom"],
                              style: TextStyle(
                                fontFamily: FontConfig.bold,
                                fontSize: Sizeconfig.tiny,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                "" + widget.recommended_data[widget.index]["area"],
                                style: TextStyle(
                                  fontFamily: FontConfig.bold,
                                  fontSize: Sizeconfig.tiny,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MyRecommendedList extends StatefulWidget {
  MyRecommendedList({Key key, this.property}) : super(key: key);
  final RealifyProperty property;

  @override
  _MyRecommendedListState createState() => _MyRecommendedListState();
}

class _MyRecommendedListState extends State<MyRecommendedList> {
  bool islike = true;
  @override
  void initState() {
    super.initState();
    List<dynamic> bedroomsOffered = widget.property.bedroomsOffered;
    List<dynamic> bedroomsOfferedPrice = widget.property.bedroomsOfferedPrice;
    final String selectedBedrooms = bedroomsOffered.join(' & ').toString();
    final String selectedBedroomsPrice = bedroomsOfferedPrice.join(' & ').toString();
    print(selectedBedrooms);
    theBedrooms = selectedBedrooms;
    theBedroomsPrice = selectedBedroomsPrice;
  }

  String theBedrooms = "";
  String theBedroomsPrice = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PropertyDetails(property: widget.property)));
          },
          child: Container(
            height: 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorConfig.grey.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5),
                      )),
                      child: Hero(
                        tag: "image-${widget.property.image}-${widget.property.images[0]}",
                        child: Image(
                          fit: BoxFit.cover,
                          height: 150,
                          width: 90,
                          image: NetworkImage(
                            "" + widget.property.images[0],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 20,
                        width: 69,
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
                              MaterialCommunityIcons.check_underline,
                              color: ColorConfig.light,
                              size: Sizeconfig.tiny,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              widget.property.images.length.toString() + " images",
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
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width -50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        "\Kshs ",
                                        style: TextStyle(
                                          fontFamily: FontConfig.regular,
                                          color: ColorConfig.dark,
                                          fontSize: Sizeconfig.medium,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      theBedroomsPrice,
                                      style: TextStyle(
                                        fontFamily: FontConfig.bold,
                                        color: ColorConfig.greyDark,
                                        fontSize: Sizeconfig.medium,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  widget.property.paymentPeriod,
                                  style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    color: ColorConfig.dark,
                                    fontSize: Sizeconfig.tiny,
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  widget.property.county,
                                  style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    color: ColorConfig.grey,
                                    fontSize: Sizeconfig.tiny,
                                  ),
                                ),
                              ],
                            ),
                            // IconButton(
                            //   icon: Icon(
                            //     MaterialIcons.favorite,
                            //     color: (islike ? ColorConfig.grey.withOpacity(0.0) : ColorConfig.red),
                            //     size: Sizeconfig.huge,
                            //   ),
                            //   onPressed: () {
                            //     setState(() {
                            //       if (islike) {
                            //         islike = false;
                            //       } else {
                            //         islike = true;
                            //       }
                            //     });
                            //   },
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          widget.property.subCategoryType,
                          style: TextStyle(
                            fontFamily: FontConfig.regular,
                            color: ColorConfig.grey,
                            fontSize: Sizeconfig.tiny,
                          ),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // RatingBar(
                        //   initialRating: 3.2,
                        //   direction: Axis.horizontal,
                        //   allowHalfRating: true,
                        //   itemCount: 5,
                        //   itemSize: Sizeconfig.large,
                        //   ratingWidget: RatingWidget(
                        //     full: Icon(Icons.star, color: Colors.amber),
                        //     half: Icon(Icons.star_half, color: Colors.amber),
                        //     empty: Icon(Icons.star_outline, color: Colors.amber),
                        //   ),
                        //   itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        //   onRatingUpdate: (rating) {
                        //     print(rating);
                        //   },
                        // ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              theBedrooms + " Bedrooms",
                              style: TextStyle(
                                fontFamily: FontConfig.bold,
                                fontSize: Sizeconfig.tiny,
                              ),
                            ),
                             SizedBox(width: 15),
                            Text(
                              widget.property.bathrooms + " Bathrooms",
                              style: TextStyle(
                                fontFamily: FontConfig.bold,
                                fontSize: Sizeconfig.tiny,
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 20.0),
                            //   child: Text(
                            //     widget.property.area + " " + widget.property.areaUnit,
                            //     style: TextStyle(
                            //       fontFamily: FontConfig.bold,
                            //       fontSize: Sizeconfig.tiny,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
