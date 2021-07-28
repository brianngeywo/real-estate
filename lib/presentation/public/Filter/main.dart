// import 'package:Realify/backend/bloc/search_property_bloc/search_property_bloc_bloc.dart';
// import 'package:Realify/presentation/my_imports.dart';
// import 'package:Realify/presentation/public/Filter/TabBar1.dart';
// import 'package:Realify/presentation/public/Filter/TabBar2.dart';
// import 'package:Realify/presentation/public/Filter/reusables/main.dart';
// import 'package:Realify/presentation/public/HomePage/main.dart';
// import 'package:Realify/presentation/public/ListRealify/main.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:form_field_validator/form_field_validator.dart';

// class Filter extends StatefulWidget {
//   @override
//   _FilterState createState() => _FilterState();
// }

// class _FilterState extends State<Filter> with TickerProviderStateMixin {
//   TabController tabController;
//   void initState() {
//     super.initState();
//     tabController = new TabController(vsync: this, length: 2);
//     tabController.addListener(_handleTabSelection);
//     proposal = "lodge";
//   }

//   void _handleTabSelection() {
//     setState(() {});
//   }

//   String proposal = "lodge";
//   String county = "";
//   String category = "";
//   String subCategory = "";
//   String minPrice = "";
//   String maxPrice = "";
//   String bedrooms = "";
//   String rentalFrequency = "";

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SearchPropertyBloc(),
//       child: Scaffold(
//         backgroundColor: ColorConfig.light,
//         body: SafeArea(
//           child: Column(
//             children: [
//               Container(
//                 color: Colors.white,
//                 child: Row(
//                   children: [
//                     Align(
//                       alignment: Alignment(0, 0.1),
//                       child: IconButton(
//                         icon: Icon(AntDesign.close),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         iconSize: Sizeconfig.huge,
//                         color: ColorConfig.dark,
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment(0, 0.1),
//                       child: Text(
//                         "Filter",
//                         style: TextStyle(
//                           fontFamily: FontConfig.bold,
//                           fontSize: Sizeconfig.medium,
//                           color: ColorConfig.dark,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(right: 15.0),
//                 //   child: InkWell(
//                 //     onTap: () {},
//                 //     child: Text(
//                 //       "Reset",
//                 //       style: TextStyle(
//                 //         fontFamily: FontConfig.regular,
//                 //         fontSize: Sizeconfig.small,
//                 //         color: ColorConfig.darkGreen,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//               ),
//               Container(height: 1, width: double.maxFinite, color: ColorConfig.grey.withOpacity(0.3)),
//               BlocConsumer<SearchPropertyBloc, SearchPropertyState>(
//                 listener: (context, state) {
//                   if (state is SearchPropertySelectedProposal) {
//                     setState(() {
//                       proposal = state.proposal;
//                     });
//                   }
//                   if (state is SearchPropertySelectedCounty) {
//                     setState(() {
//                       county = state.county;
//                     });
//                   }
//                   if (state is SearchPropertySelectedPropertyType) {
//                     setState(() {
//                       category = state.categoryTitle;
//                     });
//                   }
//                   if (state is SearchPropertySelectedPropertySubType) {
//                     setState(() {
//                       subCategory = state.subcategoryTitle;
//                     });
//                   }
//                   if (state is SelectedBedroomState) {
//                     setState(() {
//                       bedrooms = state.bedroom;
//                     });
//                   }
//                   if (state is EnteredMinPriceState) {
//                     setState(() {
//                       minPrice = state.minPrice;
//                     });
//                   }
//                   if (state is EnteredMaxPriceState) {
//                     setState(() {
//                       maxPrice = state.maxPrice;
//                     });
//                   }

//                   if (state is AddRentalFrequencyState) {
//                     setState(() {
//                       rentalFrequency = state.frequency;
//                     });
//                   }
//                 },
//                 builder: (context, state) {
//                   return Container(
//                     height: 80,
//                     width: MediaQuery.of(context).size.width,
//                     child: TabBar(
//                       controller: tabController,
//                       onTap: (value) {
//                         if (value == 0) {
//                           setState(() {
//                             proposal = "lodge";
//                           });
//                         } else if (value == 1) {
//                           setState(() {
//                             proposal = "rent";
//                           });
//                         }
//                         BlocProvider.of<SearchPropertyBloc>(context)
//                             .add((SelectedProposalEvent(index: value, proposal: proposal)));
//                       },
//                       tabs: [
//                         Tab(
//                           child: Container(
//                             height: 40,
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                                 color: tabController.index == 0 ? ColorConfig.lightGreen : ColorConfig.light,
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(3),
//                                 ),
//                                 border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//                             child: Center(
//                               child: Text(
//                                 "Lodging",
//                                 style: TextStyle(
//                                     fontFamily: FontConfig.bold,
//                                     fontSize: Sizeconfig.small,
//                                     color: tabController.index == 0 ? ColorConfig.light : ColorConfig.grey),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Tab(
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: tabController.index == 1 ? ColorConfig.lightGreen : ColorConfig.light,
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(3),
//                                 ),
//                                 border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//                             height: 40,
//                             width: MediaQuery.of(context).size.width,
//                             child: Center(
//                               child: Text(
//                                 "Rent",
//                                 style: TextStyle(
//                                     fontFamily: FontConfig.bold,
//                                     fontSize: Sizeconfig.small,
//                                     color: tabController.index == 1 ? ColorConfig.light : ColorConfig.grey),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               Expanded(
//                 child: TabBarView(
//                   controller: tabController,
//                   children: [
//                     TabBar1(),
//                     TabBar2(),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 68,
//                 width: double.maxFinite,
//                 padding: EdgeInsets.all(10),
//                 color: Colors.white,
//                 child: MaterialButton(
//                   elevation: 0.0,
//                   color: ColorConfig.darkGreen,
//                   onPressed: () {
//                     if (minPrice.isEmpty && maxPrice.isEmpty) {
//                       showSnackbar("Please enter a minimum and maximum price.", context);
//                     } else {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ListRealify(
//                             proposal: proposal.isEmpty ? "lodge" : proposal.toLowerCase(),
//                             county: county.isEmpty ? "Nairobi County" : county,
//                             bedrooms: bedrooms.isEmpty ? "studio".toLowerCase() : bedrooms.toLowerCase(),
//                             minPrice: minPrice,
//                             maxPrice: maxPrice,
//                             paymentPeriod:
//                                 rentalFrequency.isEmpty ? "daily".toLowerCase() : rentalFrequency.toLowerCase(),
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   child: Text(
//                     "Search",
//                     style: TextStyle(
//                       color: ColorConfig.light,
//                       fontSize: Sizeconfig.small,
//                       fontFamily: FontConfig.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// //  TODO: price ranging dialog box
//   Widget showDialogBox(BuildContext context) {
//     TabController controller;
//     void initState() {
//       super.initState();
//       controller = new TabController(vsync: this, length: 1);
//       controller.addListener(_handleTabSelection);
//     }

//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             actionsPadding: EdgeInsets.zero,
//             contentPadding: EdgeInsets.all(0),
//             content: Container(
//               height: SizeConfig.isMobilePortrait
//                   ? MediaQuery.of(context).size.height / 1.8
//                   : MediaQuery.of(context).size.height / 1,
//               width: MediaQuery.of(context).size.width / 0.1,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(left: 10, right: 10),
//                       color: Colors.white,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               MaterialCommunityIcons.close,
//                               size: 24,
//                               color: ColorConfig.greyDark,
//                             ),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 5, right: 5),
//                       child: Expanded(
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     height: 40,
//                                     child: Center(
//                                       child: Text("MIN:"),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     height: 40,
//                                     child: Center(
//                                       child: Text("MAX:"),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     height: 40,
//                                     padding: EdgeInsets.only(left: 10, right: 10),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       border: Border.all(
//                                         width: 1,
//                                         color: ColorConfig.smokeDark,
//                                       ),
//                                     ),
//                                     child: Center(
//                                       child: TextFormField(
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           fontFamily: FontConfig.regular,
//                                           fontSize: Sizeconfig.small,
//                                           color: ColorConfig.grey,
//                                         ),
//                                         decoration: InputDecoration(
//                                           hintText: "0",
//                                           hintStyle: TextStyle(
//                                             fontFamily: FontConfig.regular,
//                                             fontSize: Sizeconfig.small,
//                                             color: ColorConfig.grey,
//                                           ),
//                                           border: InputBorder.none,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 15),
//                                 Expanded(
//                                   child: Container(
//                                     height: 40,
//                                     padding: EdgeInsets.only(left: 10, right: 10),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       border: Border.all(
//                                         width: 1,
//                                         color: ColorConfig.smokeDark,
//                                       ),
//                                     ),
//                                     child: Center(
//                                       child: TextFormField(
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           fontFamily: FontConfig.regular,
//                                           fontSize: Sizeconfig.small,
//                                           color: ColorConfig.grey,
//                                         ),
//                                         decoration: InputDecoration(
//                                           hintText: "0",
//                                           hintStyle: TextStyle(
//                                             fontFamily: FontConfig.regular,
//                                             fontSize: Sizeconfig.small,
//                                             color: ColorConfig.grey,
//                                           ),
//                                           border: InputBorder.none,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     height: 200,
//                                     padding: EdgeInsets.only(left: 15, right: 15, top: 10),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       border: Border.all(
//                                         width: 1,
//                                         color: ColorConfig.smokeDark,
//                                       ),
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Tab(
//                                           child: Expanded(
//                                             child: Container(
//                                               height: 30,
//                                               width: double.maxFinite,
//                                               decoration: BoxDecoration(
//                                                   color: ColorConfig.lightGreenBg,
//                                                   borderRadius: BorderRadius.circular(5)),
//                                               child: Center(
//                                                 child: Text(
//                                                   "4,000",
//                                                   style: TextStyle(
//                                                     fontFamily: FontConfig.bold,
//                                                     fontSize: Sizeconfig.medium,
//                                                     color: ColorConfig.lightGreen,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Tab(
//                                           child: Expanded(
//                                             child: Container(
//                                               height: 30,
//                                               width: double.maxFinite,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     width: 1,
//                                                     color: ColorConfig.smokeLight,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5)),
//                                               child: Center(
//                                                 child: Text(
//                                                   "4,500",
//                                                   style: TextStyle(
//                                                     fontFamily: FontConfig.regular,
//                                                     fontSize: Sizeconfig.medium,
//                                                     color: ColorConfig.dark,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Tab(
//                                           child: Expanded(
//                                             child: Container(
//                                               height: 30,
//                                               width: double.maxFinite,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     width: 1,
//                                                     color: ColorConfig.smokeLight,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5)),
//                                               child: Center(
//                                                 child: Text(
//                                                   "5,000",
//                                                   style: TextStyle(
//                                                     fontFamily: FontConfig.regular,
//                                                     fontSize: Sizeconfig.medium,
//                                                     color: ColorConfig.dark,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Tab(
//                                           child: Expanded(
//                                             child: Container(
//                                               height: 30,
//                                               width: double.maxFinite,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     width: 1,
//                                                     color: ColorConfig.smokeLight,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5)),
//                                               child: Center(
//                                                 child: Text(
//                                                   "5,500",
//                                                   style: TextStyle(
//                                                     fontFamily: FontConfig.regular,
//                                                     fontSize: Sizeconfig.medium,
//                                                     color: ColorConfig.dark,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 15),
//                                 Expanded(
//                                   child: Container(
//                                     height: 200,
//                                     padding: EdgeInsets.only(left: 15, right: 15, top: 10),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       border: Border.all(
//                                         width: 1,
//                                         color: ColorConfig.smokeDark,
//                                       ),
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Tab(
//                                           child: Expanded(
//                                             child: Container(
//                                               height: 30,
//                                               width: double.maxFinite,
//                                               decoration: BoxDecoration(
//                                                   color: ColorConfig.lightGreenBg,
//                                                   borderRadius: BorderRadius.circular(5)),
//                                               child: Center(
//                                                 child: Text(
//                                                   "6,000",
//                                                   style: TextStyle(
//                                                     fontFamily: FontConfig.bold,
//                                                     fontSize: Sizeconfig.medium,
//                                                     color: ColorConfig.lightGreen,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Tab(
//                                           child: Expanded(
//                                             child: Container(
//                                               height: 30,
//                                               width: double.maxFinite,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     width: 1,
//                                                     color: ColorConfig.smokeLight,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5)),
//                                               child: Center(
//                                                 child: Text(
//                                                   "6,500",
//                                                   style: TextStyle(
//                                                     fontFamily: FontConfig.regular,
//                                                     fontSize: Sizeconfig.medium,
//                                                     color: ColorConfig.dark,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Tab(
//                                           child: Expanded(
//                                             child: Container(
//                                               height: 30,
//                                               width: double.maxFinite,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     width: 1,
//                                                     color: ColorConfig.smokeLight,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5)),
//                                               child: Center(
//                                                 child: Text(
//                                                   "7,000",
//                                                   style: TextStyle(
//                                                     fontFamily: FontConfig.regular,
//                                                     fontSize: Sizeconfig.medium,
//                                                     color: ColorConfig.dark,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Tab(
//                                           child: Expanded(
//                                             child: Container(
//                                               height: 30,
//                                               width: double.maxFinite,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     width: 1,
//                                                     color: ColorConfig.smokeLight,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5)),
//                                               child: Center(
//                                                 child: Text(
//                                                   "7,500",
//                                                   style: TextStyle(
//                                                     fontFamily: FontConfig.regular,
//                                                     fontSize: Sizeconfig.medium,
//                                                     color: ColorConfig.dark,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(children: [
//                               Expanded(
//                                 child: Container(
//                                   padding: EdgeInsets.all(6),
//                                   width: double.maxFinite,
//                                   child: RaisedButton(
//                                     color: ColorConfig.light,
//                                     shape: Border.all(
//                                       width: 1,
//                                       color: ColorConfig.darkGreen,
//                                     ),
//                                     elevation: 0.0,
//                                     onPressed: () {},
//                                     child: Text(
//                                       'RESET',
//                                       style: TextStyle(
//                                         fontFamily: FontConfig.bold,
//                                         fontSize: Sizeconfig.small,
//                                         color: ColorConfig.darkGreen,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   padding: EdgeInsets.all(6),
//                                   width: double.maxFinite,
//                                   color: Colors.white,
//                                   child: RaisedButton(
//                                     elevation: 0.0,
//                                     color: ColorConfig.darkGreen,
//                                     onPressed: () {
//                                       Navigator.pop(context, true);
//                                     },
//                                     child: Text(
//                                       'DONE',
//                                       style: TextStyle(
//                                         fontFamily: FontConfig.bold,
//                                         fontSize: Sizeconfig.small,
//                                         color: ColorConfig.light,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ])
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }

// // TODO: property tabbar
// class Propertytype extends StatefulWidget {
//   @override
//   _PropertytypeState createState() => _PropertytypeState();
// }

// class _PropertytypeState extends State<Propertytype> with TickerProviderStateMixin {
//   TabController _tabController;
//   void initState() {
//     super.initState();
//     _tabController = new TabController(vsync: this, length: 1);
//     _tabController.addListener(_handleTabSelection);
//     _tabController.index = 0;
//     category = "residential";
//   }

//   String category = "";

//   void _handleTabSelection() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SearchPropertyBloc, SearchPropertyState>(
//       listener: (context, state) {
//         if (state is SearchPropertySelectedPropertyType) {}
//       },
//       builder: (context, state) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(
//               height: 100,
//               width: MediaQuery.of(context).size.width,
//               child: TabBar(
//                 controller: _tabController,
//                 onTap: (index) {
//                   if (index == 0) {
//                     category = "residential";
//                   }
//                   // else if (index == 1) {
//                   //   category = "commercial";
//                   // }

//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedCategoryEvent(index: _tabController.index, categoryTitle: category)));
//                 },
//                 tabs: [
//                   Tab(
//                     child: Container(
//                       height: 40,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                           color: _tabController.index == 0 ? ColorConfig.lightGreen : ColorConfig.light,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(3),
//                           ),
//                           border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//                       child: Center(
//                         child: Text(
//                           "Residential",
//                           style: TextStyle(
//                               fontFamily: FontConfig.bold,
//                               fontSize: Sizeconfig.small,
//                               color: _tabController.index == 0 ? ColorConfig.light : ColorConfig.grey),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Tab(
//                   //   child: Container(
//                   //     decoration: BoxDecoration(
//                   //         color: _tabController.index == 1 ? ColorConfig.lightGreen : ColorConfig.light,
//                   //         borderRadius: BorderRadius.all(
//                   //           Radius.circular(3),
//                   //         ),
//                   //         border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//                   //     height: 40,
//                   //     width: MediaQuery.of(context).size.width,
//                   //     child: Center(
//                   //       child: Text(
//                   //         "Commercial",
//                   //         style: TextStyle(
//                   //             fontFamily: FontConfig.bold,
//                   //             fontSize: Sizeconfig.small,
//                   //             color: _tabController.index == 1 ? ColorConfig.light : ColorConfig.grey),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 150,
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   Residential(),
//                   // Commercial(),
//                 ],
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }

// // TODO: bedrooms tabbar

// class Bedroomtype extends StatefulWidget {
//   @override
//   _BedroomtypeState createState() => _BedroomtypeState();
// }

// class _BedroomtypeState extends State<Bedroomtype> with TickerProviderStateMixin {
//   TabController _tabController;
//   void initState() {
//     super.initState();
//     _tabController = new TabController(vsync: this, length: 10);
//     _tabController.addListener(_handleTabSelection);
//   }

//   void _handleTabSelection() {
//     setState(() {});
//   }

//   String title = "";
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SearchPropertyBloc, SearchPropertyState>(
//       listener: (context, state) {
//         if (state is SelectedBedroomState) {}
//       },
//       builder: (context, state) {
//         return Container(
//           height: 80,
//           width: MediaQuery.of(context).size.width,
//           child: TabBar(
//             isScrollable: true,
//             controller: _tabController,
//             onTap: (index) {
//               switch (index) {
//                 case 0:
//                   setState(() {
//                     title = "studio";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedBedroomEvent(index: index, bedroom: title)));
//                   break;
//                 case 1:
//                   setState(() {
//                     title = "bedsitter";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedBedroomEvent(index: index, bedroom: title)));
//                   break;
//                 case 2:
//                   setState(() {
//                     title = "1";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedBedroomEvent(index: index, bedroom: title)));
//                   break;
//                 case 3:
//                   setState(() {
//                     title = "2";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedBedroomEvent(index: index, bedroom: title)));
//                   break;
//                 case 4:
//                   setState(() {
//                     title = "3";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedBedroomEvent(index: index, bedroom: title)));
//                   break;
//                 case 5:
//                   setState(() {
//                     title = "4";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedBedroomEvent(index: index, bedroom: title)));
//                   break;
//                 case 6:
//                   setState(() {
//                     title = "5";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedBedroomEvent(index: index, bedroom: title)));

//                   break;
//                 case 7:
//                   setState(() {
//                     title = "6";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedBedroomEvent(index: index, bedroom: title)));
//                   break;
//                 case 8:
//                   setState(() {
//                     title = "7";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedBedroomEvent(index: index, bedroom: title)));
//                   break;
//                 case 9:
//                   setState(() {
//                     title = "8+";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedBedroomEvent(index: index, bedroom: title)));
//                   break;
//                 default:
//                   setState(() {
//                     title = "studio";
//                   });
//               }
//             },
//             tabs: [
//               bedroomTabBarItems("studio", _tabController, 0),
//               bedroomTabBarItems("bedsitter", _tabController, 1),
//               bedroomTabBarItems("1", _tabController, 2),
//               bedroomTabBarItems("2", _tabController, 3),
//               bedroomTabBarItems("3", _tabController, 4),
//               bedroomTabBarItems("4", _tabController, 5),
//               bedroomTabBarItems("5", _tabController, 6),
//               bedroomTabBarItems("6", _tabController, 7),
//               bedroomTabBarItems("7", _tabController, 8),
//               bedroomTabBarItems("8+", _tabController, 9),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// // TODO: bathrooms tabbar

// class Bathroomtype extends StatefulWidget {
//   @override
//   _BathroomtypeState createState() => _BathroomtypeState();
// }

// class _BathroomtypeState extends State<Bathroomtype> with TickerProviderStateMixin {
//   TabController _tabController;
//   void initState() {
//     super.initState();
//     _tabController = new TabController(vsync: this, length: 6);
//     _tabController.addListener(_handleTabSelection);
//   }

//   void _handleTabSelection() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       width: MediaQuery.of(context).size.width,
//       child: TabBar(
//         isScrollable: true,
//         controller: _tabController,
//         tabs: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: _tabController.index == 0 ? ColorConfig.lightGreen : ColorConfig.light,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(3),
//                   ),
//                   border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//               height: 40,
//               width: 60,
//               child: Tab(
//                 child: Text(
//                   "1",
//                   style: TextStyle(
//                       fontFamily: FontConfig.bold,
//                       fontSize: Sizeconfig.small,
//                       color: _tabController.index == 0 ? ColorConfig.light : ColorConfig.grey),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: _tabController.index == 1 ? ColorConfig.lightGreen : ColorConfig.light,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(3),
//                   ),
//                   border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//               height: 40,
//               width: 60,
//               child: Tab(
//                 child: Text(
//                   "2",
//                   style: TextStyle(
//                       fontFamily: FontConfig.bold,
//                       fontSize: Sizeconfig.small,
//                       color: _tabController.index == 1 ? ColorConfig.light : ColorConfig.grey),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: _tabController.index == 2 ? ColorConfig.lightGreen : ColorConfig.light,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(3),
//                   ),
//                   border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//               height: 40,
//               width: 60,
//               child: Tab(
//                 child: Text(
//                   "3",
//                   style: TextStyle(
//                       fontFamily: FontConfig.bold,
//                       fontSize: Sizeconfig.small,
//                       color: _tabController.index == 2 ? ColorConfig.light : ColorConfig.grey),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: _tabController.index == 3 ? ColorConfig.lightGreen : ColorConfig.light,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(3),
//                   ),
//                   border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//               height: 40,
//               width: 60,
//               child: Tab(
//                 child: Text(
//                   "4",
//                   style: TextStyle(
//                       fontFamily: FontConfig.bold,
//                       fontSize: Sizeconfig.small,
//                       color: _tabController.index == 3 ? ColorConfig.light : ColorConfig.grey),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: _tabController.index == 4 ? ColorConfig.lightGreen : ColorConfig.light,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(3),
//                   ),
//                   border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//               height: 40,
//               width: 60,
//               child: Tab(
//                 child: Text(
//                   "5",
//                   style: TextStyle(
//                       fontFamily: FontConfig.bold,
//                       fontSize: Sizeconfig.small,
//                       color: _tabController.index == 4 ? ColorConfig.light : ColorConfig.grey),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: _tabController.index == 5 ? ColorConfig.lightGreen : ColorConfig.light,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(3),
//                   ),
//                   border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//               height: 40,
//               width: 60,
//               child: Tab(
//                 child: Text(
//                   "6+",
//                   style: TextStyle(
//                       fontFamily: FontConfig.bold,
//                       fontSize: Sizeconfig.small,
//                       color: _tabController.index == 5 ? ColorConfig.light : ColorConfig.grey),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // TODO: Rental tabbar

// class Rentaltype extends StatefulWidget {
//   @override
//   _RentaltypeState createState() => _RentaltypeState();
// }

// class _RentaltypeState extends State<Rentaltype> with TickerProviderStateMixin {
//   TabController _tabController;
//   void initState() {
//     super.initState();
//     _tabController = new TabController(vsync: this, length: 4);
//     _tabController.addListener(_handleTabSelection);
//   }

//   void _handleTabSelection() {
//     setState(() {});
//   }

//   String rentalFrequency = "";
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SearchPropertyBloc, SearchPropertyState>(
//       listener: (context, state) {
//         if (state is AddRentalFrequencyState) {}
//       },
//       builder: (context, state) {
//         return Container(
//           height: 80,
//           width: MediaQuery.of(context).size.width,
//           child: TabBar(
//             isScrollable: true,
//             controller: _tabController,
//             onTap: (value) {
//               switch (value) {
//                 case 0:
//                   setState(() {
//                     rentalFrequency = "yearly";
//                   });
//                   break;
//                 case 1:
//                   setState(() {
//                     rentalFrequency = "monthly";
//                   });
//                   break;
//                 case 2:
//                   setState(() {
//                     rentalFrequency = "weekly";
//                   });
//                   break;
//                 case 3:
//                   setState(() {
//                     rentalFrequency = "daily";
//                   });
//                   break;
//                 default:
//                   setState(() {
//                     rentalFrequency = "yearly";
//                   });
//               }
//               BlocProvider.of<SearchPropertyBloc>(context)
//                   .add(AddRentalFrequencyEvent(frequency: rentalFrequency, index: _tabController.index));
//             },
//             tabs: [
//               Tab(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: _tabController.index == 0 ? ColorConfig.lightGreen : ColorConfig.light,
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(3),
//                       ),
//                       border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//                   height: 40,
//                   width: 60,
//                   child: Center(
//                     child: Text(
//                       "Yearly",
//                       style: TextStyle(
//                           fontFamily: FontConfig.bold,
//                           fontSize: Sizeconfig.small,
//                           color: _tabController.index == 0 ? ColorConfig.light : ColorConfig.grey),
//                     ),
//                   ),
//                 ),
//               ),
//               Tab(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: _tabController.index == 1 ? ColorConfig.lightGreen : ColorConfig.light,
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(3),
//                       ),
//                       border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//                   height: 40,
//                   width: 60,
//                   child: Center(
//                     child: Text(
//                       "Monthly",
//                       style: TextStyle(
//                           fontFamily: FontConfig.bold,
//                           fontSize: Sizeconfig.small,
//                           color: _tabController.index == 1 ? ColorConfig.light : ColorConfig.grey),
//                     ),
//                   ),
//                 ),
//               ),
//               Tab(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: _tabController.index == 2 ? ColorConfig.lightGreen : ColorConfig.light,
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(3),
//                       ),
//                       border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//                   height: 40,
//                   width: 60,
//                   child: Center(
//                     child: Text(
//                       "Weekly",
//                       style: TextStyle(
//                           fontFamily: FontConfig.bold,
//                           fontSize: Sizeconfig.small,
//                           color: _tabController.index == 2 ? ColorConfig.light : ColorConfig.grey),
//                     ),
//                   ),
//                 ),
//               ),
//               Tab(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: _tabController.index == 3 ? ColorConfig.lightGreen : ColorConfig.light,
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(3),
//                       ),
//                       border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//                   height: 40,
//                   width: 60,
//                   child: Center(
//                     child: Text(
//                       "Daily",
//                       style: TextStyle(
//                           fontFamily: FontConfig.bold,
//                           fontSize: Sizeconfig.small,
//                           color: _tabController.index == 3 ? ColorConfig.light : ColorConfig.grey),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// // TODO: Residential Tabbar
// class Residential extends StatefulWidget {
//   @override
//   _ResidentialState createState() => _ResidentialState();
// }

// class _ResidentialState extends State<Residential> with TickerProviderStateMixin {
//   TabController _tabController;
//   void initState() {
//     super.initState();
//     _tabController = new TabController(vsync: this, length: 7);
//     _tabController.addListener(_handleTabSelection);
//   }

//   void _handleTabSelection() {
//     setState(() {});
//   }

//   String subcategoryTitle = "";
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SearchPropertyBloc, SearchPropertyState>(
//       listener: (context, state) {
//         if (state is SearchPropertySelectedPropertySubType) {}
//       },
//       builder: (context, state) {
//         return Container(
//           height: 80,
//           width: MediaQuery.of(context).size.width,
//           child: TabBar(
//             isScrollable: true,
//             controller: _tabController,
//             onTap: (index) {
//               switch (index) {
//                 case 0:
//                   setState(() {
//                     subcategoryTitle = "Apartment";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 1:
//                   setState(() {
//                     subcategoryTitle = "Villa";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 2:
//                   setState(() {
//                     subcategoryTitle = "Townhouse";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 3:
//                   setState(() {
//                     subcategoryTitle = "Penthouse";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 4:
//                   setState(() {
//                     subcategoryTitle = "villa compound";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 5:
//                   setState(() {
//                     subcategoryTitle = "Hotel Apartment";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 6:
//                   setState(() {
//                     subcategoryTitle = "Residential Building";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 default:
//                   setState(() {
//                     subcategoryTitle = "apartment";
//                   });
//               }
//             },
//             tabs: [
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-apartment.png"), "Apartment", _tabController, 0),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-commercial-villa.png"), "Villa", _tabController, 1),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-townhouse.png"), "Townhouse", _tabController, 2),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-penthouse.png"), "Penthouse", _tabController, 3),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-villa-compound.png"), "villa\ncompound", _tabController, 4),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-hotel.png"), " Hotel\nApartment", _tabController, 5),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-residential-building.png"), "Residential\nBuilding", _tabController, 6),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// //  TODO Commercial TabBar

// class Commercial extends StatefulWidget {
//   @override
//   _CommercialState createState() => _CommercialState();
// }

// class _CommercialState extends State<Commercial> with TickerProviderStateMixin {
//   TabController _tabController;
//   void initState() {
//     super.initState();
//     _tabController = new TabController(vsync: this, length: 10);
//     _tabController.addListener(_handleTabSelection);
//     _tabController.index = 0;
//     subcategoryTitle = "Office";
//     BlocProvider.of<SearchPropertyBloc>(context)
//         .add((SelectedSubCategoryEvent(index: _tabController.index, subcategoryTitle: subcategoryTitle)));
//   }

//   void _handleTabSelection() {
//     setState(() {});
//   }

//   String subcategoryTitle = "";
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SearchPropertyBloc, SearchPropertyState>(
//       listener: (context, state) {
//         if (state is SearchPropertySelectedPropertySubType) {}
//       },
//       builder: (context, state) {
//         return Container(
//           height: 80,
//           width: MediaQuery.of(context).size.width,
//           child: TabBar(
//             isScrollable: true,
//             controller: _tabController,
//             onTap: (index) {
//               switch (index) {
//                 case 0:
//                   setState(() {
//                     subcategoryTitle = "Office";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 1:
//                   setState(() {
//                     subcategoryTitle = "Shop";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 2:
//                   setState(() {
//                     subcategoryTitle = "Warehouse";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 3:
//                   setState(() {
//                     subcategoryTitle = "Commercial Villa";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 4:
//                   setState(() {
//                     subcategoryTitle = "Bulk Units";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 5:
//                   setState(() {
//                     subcategoryTitle = "Commercial Building";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 6:
//                   setState(() {
//                     subcategoryTitle = "Petrol station";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 7:
//                   setState(() {
//                     subcategoryTitle = "Factory";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 8:
//                   setState(() {
//                     subcategoryTitle = "Showroom";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 9:
//                   setState(() {
//                     subcategoryTitle = "other";
//                   });
//                   BlocProvider.of<SearchPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 default:
//                   setState(() {
//                     subcategoryTitle = "Office";
//                   });
//               }
//             },
//             tabs: [
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-commercial-office.png"), "Office", _tabController, 0),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-commercial-shop.png"), "Shop", _tabController, 1),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-commercial-warehouse.png"), "Warehouse", _tabController, 2),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-commercial-villa.png"), "Commercial\n  Villa", _tabController, 3),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-commercial-units.png"), "Bulk\nUnits", _tabController, 4),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-commercial-building.png"), "Commercial\n  Building", _tabController, 5),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/gasoline-pump.png"), "Petrol\nstation", _tabController, 6),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-commercial-factory-1.png"), "Factory", _tabController, 7),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/showroom.png"), "Showroom", _tabController, 8),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/other.png"), "Other\n Commmercial", _tabController, 9),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
