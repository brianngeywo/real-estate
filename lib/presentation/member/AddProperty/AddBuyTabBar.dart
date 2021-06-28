import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Realify/backend/bloc/add_property_bloc/add_property_bloc.dart';
import 'package:Realify/presentation/member/AddProperty/Counties.dart';
import 'package:Realify/presentation/member/AddProperty/main.dart';
import 'package:Realify/presentation/member/AddProperty/reusables/main.dart';
import 'package:Realify/presentation/my_imports.dart';

class BuyTabBar extends StatefulWidget {
  // List propertyFields;
  BuyTabBar({
    Key key,
    // @required this.propertyFields = const [],
  }) : super(key: key);
  @override
  _BuyTabBarState createState() => _BuyTabBarState();
}

List featuresList = [];
// List propertyFields = [];
TextEditingController featuresListController = TextEditingController();
TextEditingValue textEditingValue;
String textEditingValueText = "first";
String areaUnit = "";

class _BuyTabBarState extends State<BuyTabBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
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
          SizedBox(
            height: 10,
          ),
          Propertytype(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Icon(
                  FontAwesome5.city,
                  size: Sizeconfig.huge,
                  color: ColorConfig.darkGreen,
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Select county",
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
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Icon(
                  FontAwesome5.city,
                  size: Sizeconfig.huge,
                  color: ColorConfig.darkGreen,
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Enter area name and town",
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
          BlocBuilder<AddPropertyBloc, AddPropertyState>(
            builder: (context, state) {
              return Container(
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
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: TextField(
                                  onChanged: (value) {
                                    BlocProvider.of<AddPropertyBloc>(context).add(AddLocalityEvent(location: value));
                                  },
                                  style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    fontSize: Sizeconfig.small,
                                    color: ColorConfig.greyLight,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "e.g. area, town",
                                    hintStyle: TextStyle(
                                      fontFamily: FontConfig.regular,
                                      fontSize: Sizeconfig.small,
                                      color: ColorConfig.greyLight,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Icon(
                  FontAwesome5.clipboard_list,
                  size: Sizeconfig.huge,
                  color: ColorConfig.darkGreen,
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Property Details",
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
          BlocBuilder<AddPropertyBloc, AddPropertyState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  onChanged: (value) {
                    BlocProvider.of<AddPropertyBloc>(context).add(AddPropertyTitleEvent(title: value));
                  },
                  style: TextStyle(
                    fontFamily: FontConfig.regular,
                    fontSize: Sizeconfig.small,
                    color: ColorConfig.dark,
                  ),
                  decoration: InputDecoration(
                    hintText: "Property Title",
                    hintStyle: TextStyle(
                      fontFamily: FontConfig.regular,
                      fontSize: Sizeconfig.small,
                      color: ColorConfig.dark,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(height: 1, width: double.maxFinite, color: ColorConfig.grey.withOpacity(0.3)),
          ),
          SizedBox(
            height: 10,
          ),
          BlocBuilder<AddPropertyBloc, AddPropertyState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  minLines: 1,
                  maxLines: 500,
                  onChanged: (value) {
                    BlocProvider.of<AddPropertyBloc>(context).add(AddPropertyDescriptionEvent(description: value));
                  },
                  style: TextStyle(
                    fontFamily: FontConfig.regular,
                    fontSize: Sizeconfig.small,
                    color: ColorConfig.dark,
                  ),
                  decoration: InputDecoration(
                    hintText: "Property Description",
                    hintStyle: TextStyle(
                      fontFamily: FontConfig.regular,
                      fontSize: Sizeconfig.small,
                      color: ColorConfig.dark,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(height: 1, width: double.maxFinite, color: ColorConfig.grey.withOpacity(0.3)),
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
                    "Price",
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
          BlocBuilder<AddPropertyBloc, AddPropertyState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  padding: EdgeInsets.only(
                    right: 15,
                    left: 10,
                  ),
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorConfig.smokeLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: TextField(
                      onChanged: (value) {
                        BlocProvider.of<AddPropertyBloc>(context).add(EnteredPriceEvent(price: value));
                      },
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontFamily: FontConfig.regular,
                        fontSize: Sizeconfig.small,
                        color: ColorConfig.dark,
                      ),
                      decoration: InputDecoration(
                        hintText: "Price*",
                        hintStyle: TextStyle(
                          fontFamily: FontConfig.regular,
                          fontSize: Sizeconfig.small,
                          color: ColorConfig.dark,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
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
                  AntDesign.appstore_o,
                  size: Sizeconfig.huge,
                  color: ColorConfig.darkGreen,
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Area",
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
          BlocBuilder<AddPropertyBloc, AddPropertyState>(
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.only(
                  right: 15,
                  left: 10,
                ),
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.only(
                          right: 15,
                          left: 10,
                        ),
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1,
                              color: ColorConfig.smokeLight,
                            )),
                        child: TextField(
                          onChanged: (value) {
                            BlocProvider.of<AddPropertyBloc>(context).add(
                                AddPropertyAreaEvent(area: value, areaUnit: areaUnit.isEmpty ? 'Sq.M.' : areaUnit));
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontFamily: FontConfig.regular,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                          decoration: InputDecoration(
                            hintText: "Area*",
                            hintStyle: TextStyle(
                              fontFamily: FontConfig.regular,
                              fontSize: Sizeconfig.small,
                              color: ColorConfig.dark,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: ColorConfig.smokeLight,
                            border: Border.all(
                              width: 1,
                              color: ColorConfig.smokeLight,
                            ),
                            borderRadius: BorderRadius.circular(3)),
                        child: Areadrop1(),
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
                    "Bathrooms",
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
          Bathroomtype(),
          SizedBox(
            height: 20,
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 15, right: 15),
          //   child: Row(
          //     children: [
          //       Icon(
          //         FontAwesome5.hashtag,
          //         size: Sizeconfig.huge,
          //         color: ColorConfig.darkGreen,
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 8.0),
          //         child: Text(
          //           "Permit Number",
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
          //   padding: EdgeInsets.only(left: 15, right: 15),
          //   child: TextFormField(
          //     style: TextStyle(
          //       fontFamily: FontConfig.regular,
          //       fontSize: Sizeconfig.small,
          //       color: ColorConfig.dark,
          //     ),
          //     decoration: InputDecoration(
          //       hintText: "e.g 1234",
          //       hintStyle: TextStyle(
          //         fontFamily: FontConfig.regular,
          //         fontSize: Sizeconfig.small,
          //         color: ColorConfig.dark,
          //       ),
          //       border: InputBorder.none,
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 15, right: 15),
          //   child: Container(height: 1, width: double.maxFinite, color: ColorConfig.grey.withOpacity(0.3)),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Icon(
                  Ionicons.ios_call,
                  size: Sizeconfig.huge,
                  color: ColorConfig.darkGreen,
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Contact Details",
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
          // SizedBox(
          //   height: 10,
          // ),
          // Padding(
          //   padding: EdgeInsets.only(left: 15, right: 15),
          //   child: TextFormField(
          //     style: TextStyle(
          //       fontFamily: FontConfig.regular,
          //       fontSize: Sizeconfig.small,
          //       color: ColorConfig.dark,
          //     ),
          //     decoration: InputDecoration(
          //       hintText: "someone@qwer.com",
          //       hintStyle: TextStyle(
          //         fontFamily: FontConfig.regular,
          //         fontSize: Sizeconfig.small,
          //         color: ColorConfig.dark,
          //       ),
          //       border: InputBorder.none,
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 15, right: 15),
          //   child: Container(height: 1, width: double.maxFinite, color: ColorConfig.grey.withOpacity(0.3)),
          // ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConfig.smoke,
                      border: Border.all(
                        width: 1,
                        color: ColorConfig.smokeLight,
                      ),
                    ),
                    child: Dropdown1(),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                 BlocBuilder<AddPropertyBloc, AddPropertyState>(
                  builder: (context, state) {
                    return Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: ColorConfig.smokeLight,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                                  onChanged: (value) =>
                                BlocProvider.of<AddPropertyBloc>(context).add(AddPhoneEvent(phone: value)),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "798767470",
                              hintStyle: TextStyle(
                                fontFamily: FontConfig.regular,
                                fontSize: Sizeconfig.small,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 15, right: 15),
          //   child: Row(
          //     children: [
          //       Icon(
          //         FontAwesome5.list_alt,
          //         size: Sizeconfig.huge,
          //         color: ColorConfig.darkGreen,
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 8.0),
          //         child: Text(
          //           "Property Features",
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
          //   padding: const EdgeInsets.only(left: 15, right: 15),
          //   child: Container(
          //     padding: EdgeInsets.only(
          //       right: 15,
          //       left: 10,
          //     ),
          //     height: 40,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(5),
          //       border: Border.all(
          //         width: 1,
          //         color: ColorConfig.smokeLight,
          //       ),
          //     ),
          //     child: TextField(
          //       style: TextStyle(
          //         fontFamily: FontConfig.regular,
          //         fontSize: Sizeconfig.small,
          //         color: ColorConfig.dark,
          //       ),
          //       decoration: InputDecoration(
          //         hintText: "abc...",
          //         hintStyle: TextStyle(
          //           fontFamily: FontConfig.regular,
          //           fontSize: Sizeconfig.small,
          //           color: ColorConfig.dark,
          //         ),
          //         border: InputBorder.none,
          //       ),
          //     ),
          //   ),
          // ),
          // BlocConsumer<AddPropertyBloc, AddPropertyState>(
          //   listener: (context, state) {
          //     if (state is AddedNewFieldState) {
          //       // propertyFeatures.add(state.widget);
          //       setState(() {
          //         featuresListController = state.textEditingController;
          //         textEditingValue = TextEditingValue(text: textEditingValueText + 1.toString());
          //       });
          //     }
          //   },
          //   builder: (context, state) {
          //     if (widget.propertyFields.isNotEmpty) {
          //       // propertyFeatures.add(state.widget);
          //       print(textEditingValue);
          //       return Column(
          //         children: widget.propertyFields.map((feature) {
          //           return Container(
          //             child: feature,
          //           );
          //         }).toList(),
          //       );
          //     } else {
          //       return Column(children: [
          //         propertyFeatureWidget(featuresList, featuresListController),
          //       ]);
          //     }
          //   },
          // ),

          // SizedBox(
          //   height: 20,
          // ),
          // BlocBuilder<AddPropertyBloc, AddPropertyState>(
          //   builder: (context, state) {
          //     return MaterialButton(
          //       onPressed: () {
          //         BlocProvider.of<AddPropertyBloc>(context).add(AddNewFieldEvent(
          //             widget: propertyFeatureWidget(featuresList, featuresListController),
          //             propertyFields: widget.propertyFields,
          //             textEditingController: featuresListController,
          //             textEditingValue: textEditingValue));
          //       },
          //       color: ColorConfig.lightGreen,
          //       textColor: ColorConfig.light,
          //       child: Text("Add field"),
          //     );
          //   },
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Icon(
                  Entypo.image_inverted,
                  size: Sizeconfig.huge,
                  color: ColorConfig.darkGreen,
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Property Image",
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
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
            child: InkWell(
              onTap: () {},
              child: DottedBorder(
                strokeWidth: 2,
                color: ColorConfig.greyLight,
                strokeCap: StrokeCap.butt,
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Image(
                      height: 72,
                      width: 72,
                      image: AssetImage("assets/images/interface.png"),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Areadrop1 extends StatefulWidget {
  @override
  _Areadrop1State createState() => _Areadrop1State();
}

class _Areadrop1State extends State<Areadrop1> {
  int selected = null;
  List<DropdownMenuItem<int>> listDrop = [];

  void loadData() {
    listDrop = [];
    listDrop.add(new DropdownMenuItem(
      child: Text(
        'Sq.M.',
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.7),
        ),
      ),
      value: 1,
    ));
    listDrop.add(new DropdownMenuItem(
      child: Text(
        'Sq.Ft.',
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.7),
        ),
        // overflow: TextOverflow.ellipsis,
      ),
      value: 2,
    ));
    listDrop.add(new DropdownMenuItem(
      child: Text(
        'Sq.Yd',
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.7),
        ),
        // overflow: TextOverflow.ellipsis,
      ),
      value: 3,
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return BlocConsumer<AddPropertyBloc, AddPropertyState>(
      listener: (context, state) {
        if (state is AddPropertyAreaState) {
          setState(() {
            areaUnit = state.areaUnit;
          });
        }
      },
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                // itemHeight: 2,
                iconSize: 25,
                elevation: 0,
                value: selected,
                hint: Text(
                  'Sq.M.',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                  ),
                ),
                items: listDrop,
                onChanged: (value) {
                  selected = value;
                  setState(() {
                    switch (value) {
                      case 1:
                        BlocProvider.of<AddPropertyBloc>(context).add(AddPropertyAreaEvent(areaUnit: 'Sq.M.'));
                        break;
                      case 2:
                        BlocProvider.of<AddPropertyBloc>(context).add(AddPropertyAreaEvent(areaUnit: 'Sq.Ft.'));
                        break;
                      case 3:
                        BlocProvider.of<AddPropertyBloc>(context).add(AddPropertyAreaEvent(areaUnit: 'Sq.Yd'));
                        break;
                      default:
                        BlocProvider.of<AddPropertyBloc>(context).add(AddPropertyAreaEvent(areaUnit: 'Sq.M.'));
                    }
                  });
                },
              ),
            ));
      },
    );
  }
}

class Dropdown1 extends StatefulWidget {
  @override
  _Dropdown1State createState() => _Dropdown1State();
}

class _Dropdown1State extends State<Dropdown1> {
  int selected = null;
  List<DropdownMenuItem<int>> listDrop = [];

  void loadData() {
    listDrop = [];
    listDrop.add(new DropdownMenuItem(
      child: Text(
        '254',
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.7),
        ),
      ),
      value: 1,
    ));
    // listDrop.add(new DropdownMenuItem(
    //   child: Text(
    //     '62',
    //     style: TextStyle(
    //       color: Color.fromRGBO(0, 0, 0, 0.7),
    //     ),
    //     // overflow: TextOverflow.ellipsis,
    //   ),
    //   value: 2,
    // ));
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            // itemHeight: 2,
            iconSize: 25,
            elevation: 0,
            value: selected,
            hint: Text(
              '254',
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.7),
              ),
            ),
            items: listDrop,
            onChanged: (value) {
              selected = value;
              setState(() {});
            },
          ),
        ));
  }
}
