import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/member/UpdateProperty/UpdateProperty.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPropertiesList extends StatelessWidget {
  MyPropertiesList({Key key, this.property}) : super(key: key);
  final RealifyProperty property;
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
                      child: Hero(
                        tag: "image-${property.image}-${property.images[0]}",
                        child: Image(
                          fit: BoxFit.cover,
                          height: 150,
                          width: 98,
                          image: NetworkImage(
                            "" + property.images[0],
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
                                      "" + property.price,
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
                                        property.paymentPeriod,
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
                                  "" + property.county,
                                  style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    color: ColorConfig.grey,
                                    fontSize: Sizeconfig.tiny,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // InkWell(
                                //   onTap: () {},
                                //   child: Container(
                                //     height: 36,
                                //     width: 36,
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.all(
                                //           Radius.circular(5),
                                //         ),
                                //         color: ColorConfig.smoke),
                                //     child: Icon(
                                //       Feather.trash_2,
                                //       color: ColorConfig.red,
                                //       size: Sizeconfig.large,
                                //     ),
                                //   ),
                                // ),
                                SizedBox(width: 5),
                                InkWell(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) => UpdateProperty(property: property,))),
                                  child: Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        color: ColorConfig.smoke),
                                    child: Icon(
                                      MaterialCommunityIcons.pencil,
                                      color: ColorConfig.greyDark,
                                      size: Sizeconfig.large,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          property.subCategoryType,
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
                              property.bedrooms + " Bed",
                              style: TextStyle(
                                fontFamily: FontConfig.bold,
                                fontSize: Sizeconfig.tiny,
                              ),
                            ),
                            Text(
                              property.bathrooms + " Baths",
                              style: TextStyle(
                                fontFamily: FontConfig.bold,
                                fontSize: Sizeconfig.tiny,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                "100 sqm",
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
