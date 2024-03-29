// import 'package:Realify/backend/bloc/add_property_bloc/add_property_bloc.dart';
// import 'package:Realify/backend/models/Proposal.dart';
// import 'package:Realify/backend/models/RealifyProperty.dart';
// import 'package:Realify/backend/models/places.dart';
// import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
// import 'package:Realify/presentation/member/AddProperty/AddHotelListing.dart';
// import 'package:Realify/presentation/member/AddProperty/AddRentalListing.dart';
// import 'package:Realify/presentation/member/AddProperty/reusables/main.dart';
// import 'package:Realify/presentation/my_imports.dart';
// import 'package:Realify/presentation/public/HomePage/main.dart';
// import 'package:Realify/presentation/widget/progress_dialog/main.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AddProperty extends StatefulWidget {
//   final RealifyPropertyRepository realifyPropertyRepository;
//   const AddProperty({Key key, this.realifyPropertyRepository}) : super(key: key);
//   @override
//   _AddPropertyState createState() => _AddPropertyState();
// }

// class _AddPropertyState extends State<AddProperty> with TickerProviderStateMixin {
//   List<dynamic> bedroomsOffered = [];
//   String proposal = "lodge";
//   String county = "";
//   String category = "";
//   String subCategory = "";
//   String price = "";
//   String bedrooms = "";
//   String bathrooms = "";
//   String locality = "";
//   String propertyName = "";
//   String description = "";
//   String rentalFrequency = "";
//   String area = "";
//   String areaUnit = "";
//   String phone = "";
//   List<String> imageUrls = [];
//   List<String> prices = [];
//   Place placeDetails = new Place();

//   RealifyProperty property;
//   TabController tabController;

//   void initState() {
//     super.initState();
//     tabController = new TabController(vsync: this, length: proposalList.length);
//     tabController.addListener(_handleTabSelection);
//     proposal = "lodge";
//   }

//   void _handleTabSelection() {
//     setState(() {});
//   }

//   var images = [];
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AddPropertyBloc(),
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
//                         icon: Icon(AntDesign.arrowleft),
//                         onPressed: () {
//                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
//                         },
//                         iconSize: Sizeconfig.huge,
//                         color: ColorConfig.dark,
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment(0, 0.1),
//                       child: Text(
//                         "Create New Property",
//                         style: TextStyle(
//                           fontFamily: FontConfig.bold,
//                           fontSize: Sizeconfig.medium,
//                           color: ColorConfig.dark,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(height: 1, width: double.maxFinite, color: ColorConfig.grey.withOpacity(0.3)),
//               SizedBox(
//                 height: 20,
//               ),
//               BlocConsumer<AddPropertyBloc, AddPropertyState>(
//                 listener: (context, state) {
//                   if (state is AddPropertySelectedProposal) {
//                     setState(() {
//                       proposal = state.proposal;
//                     });
//                   }
//                   if (state is AddPropertySelectedCounty) {
//                     setState(() {
//                       county = state.county;
//                     });
//                   }
//                   if (state is AddPropertySelectedPropertyType) {
//                     setState(() {
//                       category = state.categoryTitle;
//                     });
//                   }
//                   if (state is AddPropertySelectedPropertySubType) {
//                     setState(() {
//                       subCategory = state.subcategoryTitle;
//                     });
//                   }
//                   if (state is SelectedBathroomState) {
//                     setState(() {
//                       bathrooms = state.bathroom;
//                     });
//                   }
//                   if (state is SelectedBedroomState) {
//                     setState(() {
//                       bedrooms = state.bedroom;
//                     });
//                   }

//                   if (state is SelectedBedroomsOfferedState) {
//                     setState(() {
//                       bedroomsOffered = [];
//                     });
//                     state.bedrooms.forEach((element) {
//                       setState(() {
//                         bedroomsOffered.add(element);
//                       });
//                     });
//                     print(bedroomsOffered);
//                   }
//                   if (state is EnteredPriceState) {
//                     setState(() {
//                       price = state.price;
//                     });
//                   }
//                   if (state is AddedLocalityState) {
//                     setState(() {
//                       locality = state.location;
//                     });
//                   }
//                   if (state is AddedPropertyTitleState) {
//                     setState(() {
//                       propertyName = state.title;
//                     });
//                   }
//                   if (state is AddedPropertyDescriptionState) {
//                     setState(() {
//                       description = state.description;
//                     });
//                   }
//                   if (state is SelectedBedroomsPricesState) {
//                     setState(() {
//                       prices = [];
//                       prices.addAll(state.prices);
//                     });
//                   }
//                   if (state is AddRentalFrequencyState) {
//                     if (proposal == "rent" && (rentalFrequency.isEmpty || rentalFrequency == "sale")) {
//                       setState(() {
//                         rentalFrequency = "monthly";
//                       });
//                     } else {
//                       setState(() {
//                         rentalFrequency = state.frequency;
//                       });
//                     }
//                   }
//                   if (state is AddPropertyAreaState) {
//                     setState(() {
//                       area = state.area;
//                       areaUnit = state.areaUnit;
//                     });
//                   }
//                   if (state is AddedPhoneState) {
//                     setState(() {
//                       phone = state.phone;
//                     });
//                   }
//                   if (state is AddPlaceDetailsState) {
//                     setState(() {
//                       placeDetails = state.place;
//                     });
//                   }
            
//                 },
//                 builder: (context, state) {
//                   return TabBar(
//                     controller: tabController,
//                     onTap: (value) {
//                       if (value == 0) {
//                         setState(() {
//                           proposal = "lodge";
//                         });
//                       } else if (value == 1) {
//                         setState(() {
//                           proposal = "rent";
//                         });
//                       }
//                       // print(proposal);
//                       BlocProvider.of<AddPropertyBloc>(context)
//                           .add((SelectedProposalEvent(index: value, proposal: proposal)));
//                     },
//                     tabs: [
//                       Tab(
//                         child: Container(
//                           height: 40,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               color: tabController.index == 0 ? ColorConfig.lightGreen : ColorConfig.light,
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(3),
//                               ),
//                               border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//                           child: Center(
//                             child: Text(
//                               "Lodging",
//                               style: TextStyle(
//                                   fontFamily: FontConfig.bold,
//                                   fontSize: Sizeconfig.small,
//                                   color: tabController.index == 0 ? ColorConfig.light : ColorConfig.grey),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Tab(
//                         child: Container(
//                           height: 40,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               color: tabController.index == 1 ? ColorConfig.lightGreen : ColorConfig.light,
//                               borderRadius: BorderRadius.all(Radius.circular(3)),
//                               border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//                           child: Center(
//                             child: Text(
//                               "Rental",
//                               style: TextStyle(
//                                   fontFamily: FontConfig.bold,
//                                   fontSize: Sizeconfig.small,
//                                   color: tabController.index == 1 ? ColorConfig.light : ColorConfig.grey),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//               Flexible(
//                 fit: FlexFit.tight,
//                 child: TabBarView(
//                   controller: tabController,
//                   children: [
//                     BuyTabBar(),
//                     RentTabBar(),
//                   ],
//                 ),
//               ),
//               BlocBuilder<AddPropertyBloc, AddPropertyState>(
//                 builder: (context, state) {
//                   if (state is UploadedPropertyState) {
//                     Navigator.of(context).pop();
//                     Navigator.of(context).pop();
//                   }
//                   return Container(
//                     height: 73,
//                     width: double.maxFinite,
//                     padding: EdgeInsets.all(7),
//                     color: Colors.white,
//                     child: Container(
//                       padding: EdgeInsets.all(6),
//                       width: double.maxFinite,
//                       color: Colors.white,
//                       child: MaterialButton(
//                         elevation: 0.0,
//                         color: ColorConfig.darkGreen,
//                         onPressed: () {
//                           BlocProvider.of<AddPropertyBloc>(context).add(StartPropertyUploadEvent());
//                           showMyDialogBox(
//                             context,
//                             "creating your listing",
//                           );
//                         },
//                         child: Text(
//                           'Upload Now',
//                           style: TextStyle(
//                             fontFamily: FontConfig.bold,
//                             fontSize: Sizeconfig.small,
//                             color: ColorConfig.light
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
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
//     BlocProvider.of<AddPropertyBloc>(context)
//         .add((SelectedCategoryEvent(index: _tabController.index, categoryTitle: category)));
//   }

//   String category = "";
//   RealifyProperty property;

//   void _handleTabSelection() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AddPropertyBloc, AddPropertyState>(
//       listener: (context, state) {
//         if (state is AddPropertySelectedPropertyType) {}
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

//                   BlocProvider.of<AddPropertyBloc>(context)
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
//     return BlocConsumer<AddPropertyBloc, AddPropertyState>(
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
//               BlocProvider.of<AddPropertyBloc>(context)
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
//     return BlocConsumer<AddPropertyBloc, AddPropertyState>(
//       listener: (context, state) {},
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
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 1:
//                   setState(() {
//                     subcategoryTitle = "Villa";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 2:
//                   setState(() {
//                     subcategoryTitle = "Townhouse";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 3:
//                   setState(() {
//                     subcategoryTitle = "Penthouse";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 4:
//                   setState(() {
//                     subcategoryTitle = "villa compound";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 5:
//                   setState(() {
//                     subcategoryTitle = "Hotel Apartment";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 6:
//                   setState(() {
//                     subcategoryTitle = "Residential Building";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
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
//                   AssetImage("assets/icons/buy-hotel.png"), "Hotel\nApartment", _tabController, 5),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-residential-building.png"), "Residential\nBuilding", _tabController, 6),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// Widget buildTabitems(context, Proposal proposal, tabController) {
//   return Tab(
//     child: Container(
//       height: 40,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//           color: tabController.index == 0 ? ColorConfig.lightGreen : ColorConfig.light,
//           borderRadius: BorderRadius.all(
//             Radius.circular(3),
//           ),
//           border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//       child: Center(
//         child: Text(
//           proposal.name,
//           style: TextStyle(
//               fontFamily: FontConfig.bold,
//               fontSize: Sizeconfig.small,
//               color: tabController.index == 0 ? ColorConfig.light : ColorConfig.grey),
//         ),
//       ),
//     ),
//   );
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
//     subcategoryTitle = "Office";
//     BlocProvider.of<AddPropertyBloc>(context)
//         .add((SelectedSubCategoryEvent(index: _tabController.index, subcategoryTitle: subcategoryTitle)));
//   }

//   void _handleTabSelection() {
//     setState(() {});
//   }

//   String subcategoryTitle = "";
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddPropertyBloc, AddPropertyState>(
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
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 1:
//                   setState(() {
//                     subcategoryTitle = "Shop";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 2:
//                   setState(() {
//                     subcategoryTitle = "Warehouse";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 3:
//                   setState(() {
//                     subcategoryTitle = "Commercial Villa";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 4:
//                   setState(() {
//                     subcategoryTitle = "Bulk Units";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 5:
//                   setState(() {
//                     subcategoryTitle = "Commercial Building";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 6:
//                   setState(() {
//                     subcategoryTitle = "Petrol station";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 7:
//                   setState(() {
//                     subcategoryTitle = "Factory";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 8:
//                   setState(() {
//                     subcategoryTitle = "Showroom";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
//                       .add((SelectedSubCategoryEvent(index: index, subcategoryTitle: subcategoryTitle)));
//                   break;
//                 case 9:
//                   setState(() {
//                     subcategoryTitle = "other";
//                   });
//                   BlocProvider.of<AddPropertyBloc>(context)
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
//                   AssetImage("assets/icons/gasoline-pump.png"), "Petrol\n station", _tabController, 6),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/buy-commercial-factory-1.png"), "Factory", _tabController, 7),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/showroom.png"), "Showroom", _tabController, 8),
//               residentialAndCommercialtabBarItems(
//                   AssetImage("assets/icons/other.png"), "Other\nCommercial", _tabController, 9),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
