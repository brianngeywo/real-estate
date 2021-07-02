import 'package:Realify/backend/bloc/search_property_bloc/search_property_bloc_bloc.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/Filter/Counties.dart';
import 'package:Realify/presentation/public/Filter/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBar2 extends StatefulWidget {
  @override
  _TabBar2State createState() => _TabBar2State();
}

class _TabBar2State extends State<TabBar2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [

        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Icon(
                Entypo.home,
                size: Sizeconfig.huge,
                color: ColorConfig.darkGreen,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Property Types",
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
        SizedBox(height: 10),
        Propertytype(),
        SizedBox(
          height: 20,
        ),
        // Padding(
        //   padding: EdgeInsets.only(left: 15, right: 15),
        //   child: Row(
        //     children: [
        //       Icon(
        //         MaterialCommunityIcons.av_timer,
        //         size: Sizeconfig.huge,
        //         color: ColorConfig.darkGreen,
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8.0),
        //         child: Text(
        //           "Rental Frequency",
        //           style: TextStyle(
        //             fontFamily: FontConfig.bold,
        //             fontSize: Sizeconfig.medium,
        //             color: ColorConfig.dark,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Rentaltype(),
        // SizedBox(
        //   height: 20,
        // ),

          Container(
          height: 70,
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: 15,
                    left: 10,
                  ),
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorConfig.smokeLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        MaterialIcons.location_on,
                        size: 20,
                        color: ColorConfig.grey,
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: CountiesCodes(),
                        // child: TextField(
                        //   style: TextStyle(
                        //     fontFamily: FontConfig.regular,
                        //     fontSize: Sizeconfig.small,
                        //     color: ColorConfig.greyLight,
                        //   ),
                        //   decoration: InputDecoration(
                        //     hintText: "Select location",
                        //     hintStyle: TextStyle(
                        //       fontFamily: FontConfig.regular,
                        //       fontSize: Sizeconfig.small,
                        //       color: ColorConfig.greyLight,
                        //     ),
                        //     border: InputBorder.none,
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Icon(
                Ionicons.ios_pricetag,
                size: Sizeconfig.huge,
                color: ColorConfig.darkGreen,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Price Range",
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
        SizedBox(
          height: 10,
        ),
        BlocBuilder<SearchPropertyBloc, SearchPropertyState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 40,
                      // width: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          width: 1,
                          color: ColorConfig.smokeDark,
                        ),
                      ),
                      child: TextFormField(
                        onChanged: (value){
                           BlocProvider.of<SearchPropertyBloc>(context).add(EnteredMinPriceEvent(minPrice: value));
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontFamily: FontConfig.regular,
                          color: ColorConfig.dark,
                          fontSize: Sizeconfig.medium,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Amount",
                          hintStyle: TextStyle(
                            fontFamily: FontConfig.regular,
                            color: ColorConfig.dark,
                            fontSize: Sizeconfig.medium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'to',
                    style: TextStyle(
                      fontFamily: FontConfig.regular,
                      fontSize: Sizeconfig.medium,
                      color: ColorConfig.grey,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 40,
                      // width: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          width: 1,
                          color: ColorConfig.smokeDark,
                        ),
                      ),
                      child: TextFormField(
                        onChanged: (value){
                           BlocProvider.of<SearchPropertyBloc>(context).add(EnteredMaxPriceEvent(maxPrice: value));
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontFamily: FontConfig.regular,
                          color: ColorConfig.dark,
                          fontSize: Sizeconfig.medium,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Amount",
                          hintStyle: TextStyle(
                            fontFamily: FontConfig.regular,
                            color: ColorConfig.dark,
                            fontSize: Sizeconfig.medium,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Icon(
                MaterialCommunityIcons.av_timer,
                size: Sizeconfig.huge,
                color: ColorConfig.darkGreen,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Payment period",
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
        Rentaltype(),
        SizedBox(
          height: 10,
        ),
        // Padding(
        //   padding: EdgeInsets.only(left: 15, right: 15),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: InkWell(
        //           onTap: () {
        //             showDialogBox(context);
        //           },
        //           child: Container(
        //             height: 40,
        //             padding: EdgeInsets.only(left: 10, right: 10),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(5),
        //               border: Border.all(
        //                 width: 1,
        //                 color: ColorConfig.smokeDark,
        //               ),
        //             ),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   '0',
        //                   style: TextStyle(
        //                     fontFamily: FontConfig.regular,
        //                     fontSize: Sizeconfig.small,
        //                     color: ColorConfig.grey,
        //                   ),
        //                 ),
        //                 Icon(
        //                   Ionicons.md_arrow_dropdown,
        //                   size: Sizeconfig.large,
        //                   color: ColorConfig.grey,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //       SizedBox(
        //         width: 5,
        //       ),
        //       Text(
        //         'to',
        //         style: TextStyle(
        //           fontFamily: FontConfig.regular,
        //           fontSize: Sizeconfig.medium,
        //           color: ColorConfig.grey,
        //         ),
        //       ),
        //       SizedBox(
        //         width: 5,
        //       ),
        //       Expanded(
        //         child: InkWell(
        //           onTap: () {
        //             showDialogBox(context);
        //           },
        //           child: Container(
        //             height: 40,
        //             padding: EdgeInsets.only(left: 10, right: 10),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(5),
        //               border: Border.all(
        //                 width: 1,
        //                 color: ColorConfig.smokeDark,
        //               ),
        //             ),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Any',
        //                   style: TextStyle(
        //                     fontFamily: FontConfig.regular,
        //                     fontSize: Sizeconfig.small,
        //                     color: ColorConfig.grey,
        //                   ),
        //                 ),
        //                 Icon(
        //                   Ionicons.md_arrow_dropdown,
        //                   size: Sizeconfig.large,
        //                   color: ColorConfig.grey,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
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
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Bedrooms",
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
        Bedroomtype(),
        SizedBox(
          height: 20,
        ),
        // Padding(
        //   padding: EdgeInsets.only(left: 15, right: 15),
        //   child: Row(
        //     children: [
        //       Icon(
        //         FontAwesome5.bath,
        //         size: Sizeconfig.huge,
        //         color: ColorConfig.darkGreen,
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8.0),
        //         child: Text(
        //           "Baths",
        //           style: TextStyle(
        //             fontFamily: FontConfig.bold,
        //             fontSize: Sizeconfig.medium,
        //             color: ColorConfig.dark,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Bathroomtype(),
        // SizedBox(
        //   height: 20,
        // ),
        // Padding(
        //   padding: EdgeInsets.only(left: 15, right: 15),
        //   child: Row(
        //     children: [
        //       Icon(
        //         AntDesign.appstore_o,
        //         size: Sizeconfig.huge,
        //         color: ColorConfig.darkGreen,
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8.0),
        //         child: Text(
        //           "Area Range",
        //           style: TextStyle(
        //             fontFamily: FontConfig.bold,
        //             fontSize: Sizeconfig.medium,
        //             color: ColorConfig.dark,
        //           ),
        //         ),
        //       ),
        //       SizedBox(
        //         width: 5,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 10.0),
        //         child: Text(
        //           "(Square Meters)",
        //           style: TextStyle(
        //             fontFamily: FontConfig.regular,
        //             fontSize: Sizeconfig.small,
        //             color: ColorConfig.grey,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Padding(
        //   padding: EdgeInsets.only(left: 15, right: 15),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: InkWell(
        //           onTap: () {
        //             showDialogBox(context);
        //           },
        //           child: Container(
        //             height: 40,
        //             padding: EdgeInsets.only(left: 10, right: 10),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(5),
        //               border: Border.all(
        //                 width: 1,
        //                 color: ColorConfig.smokeDark,
        //               ),
        //             ),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   '0',
        //                   style: TextStyle(
        //                     fontFamily: FontConfig.regular,
        //                     fontSize: Sizeconfig.small,
        //                     color: ColorConfig.grey,
        //                   ),
        //                 ),
        //                 Icon(
        //                   Ionicons.md_arrow_dropdown,
        //                   size: Sizeconfig.large,
        //                   color: ColorConfig.grey,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //       SizedBox(
        //         width: 5,
        //       ),
        //       Text(
        //         'to',
        //         style: TextStyle(
        //           fontFamily: FontConfig.regular,
        //           fontSize: Sizeconfig.medium,
        //           color: ColorConfig.grey,
        //         ),
        //       ),
        //       SizedBox(
        //         width: 5,
        //       ),
        //       Expanded(
        //         child: InkWell(
        //           onTap: () {
        //             showDialogBox(context);
        //           },
        //           child: Container(
        //             height: 40,
        //             padding: EdgeInsets.only(left: 10, right: 10),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(5),
        //               border: Border.all(
        //                 width: 1,
        //                 color: ColorConfig.smokeDark,
        //               ),
        //             ),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Any',
        //                   style: TextStyle(
        //                     fontFamily: FontConfig.regular,
        //                     fontSize: Sizeconfig.small,
        //                     color: ColorConfig.grey,
        //                   ),
        //                 ),
        //                 Icon(
        //                   Ionicons.md_arrow_dropdown,
        //                   size: Sizeconfig.large,
        //                   color: ColorConfig.grey,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // Padding(
        //   padding: EdgeInsets.only(left: 15, right: 15),
        //   child: Row(
        //     children: [
        //       Icon(
        //         FontAwesome.quote_right,
        //         size: Sizeconfig.huge,
        //         color: ColorConfig.darkGreen,
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8.0),
        //         child: Text(
        //           "KeyWords",
        //           style: TextStyle(
        //             fontFamily: FontConfig.bold,
        //             fontSize: Sizeconfig.medium,
        //             color: ColorConfig.dark,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(
        //     right: 15,
        //     left: 10,
        //     bottom: 20,
        //   ),
        //   child: Container(
        //     padding: EdgeInsets.only(
        //       right: 15,
        //       left: 10,
        //     ),
        //     height: 40,
        //     decoration: BoxDecoration(
        //       color: ColorConfig.smokeLight,
        //       borderRadius: BorderRadius.circular(5),
        //     ),
        //     child: Row(
        //       children: [
        //         Flexible(
        //           child: Padding(
        //             padding: const EdgeInsets.only(bottom: 5.0),
        //             child: TextField(
        //               style: TextStyle(
        //                 fontFamily: FontConfig.regular,
        //                 fontSize: Sizeconfig.small,
        //                 color: ColorConfig.greyLight,
        //               ),
        //               decoration: InputDecoration(
        //                 hintText: "Enter relevant words",
        //                 hintStyle: TextStyle(
        //                   fontFamily: FontConfig.regular,
        //                   fontSize: 12,
        //                   color: ColorConfig.dark,
        //                 ),
        //                 border: InputBorder.none,
        //               ),
        //             ),
        //           ),
        //         ),
        //         Icon(
        //           AntDesign.plus,
        //           size: Sizeconfig.large,
        //           color: ColorConfig.grey,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}
