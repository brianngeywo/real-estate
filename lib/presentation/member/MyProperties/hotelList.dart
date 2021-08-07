import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/member/UpdateProperty/EditHotel.dart';
import 'package:Realify/presentation/my_imports.dart';

class MyHotelsList extends StatefulWidget {
  MyHotelsList({Key key, this.property}) : super(key: key);
  final RealifyProperty property;

  @override
  State<MyHotelsList> createState() => _MyHotelsListState();
}

class _MyHotelsListState extends State<MyHotelsList> {
  @override
  void initState() {
    super.initState();
    List<dynamic> bedroomsOffered = widget.property.bedroomsOffered;
    List<dynamic> bedroomsOfferedPrice = widget.property.bedroomsOfferedPrice;
    final String selectedBedrooms = bedroomsOffered.join(' & ').toString();
    final String selectedBedroomsPrice = bedroomsOfferedPrice.join(' & ').toString();
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
                          width: 98,
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
                    width: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5, top: 5),
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
                                SizedBox(height: 7),
                                Text(
                                  widget.property.paymentPeriod,
                                  style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    color: ColorConfig.dark,
                                    fontSize: Sizeconfig.tiny,
                                  ),
                                ),
                                SizedBox(height: 7),
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
                            InkWell(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => EditHotel(property: widget.property))),
                              child: Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)), color: ColorConfig.smoke),
                                child: Icon(
                                  MaterialCommunityIcons.pencil,
                                  color: ColorConfig.greyDark,
                                  size: Sizeconfig.large,
                                ),
                              ),
                            ),
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
                        SizedBox(
                          height: 10,
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
                            //     "100 sqm",
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
