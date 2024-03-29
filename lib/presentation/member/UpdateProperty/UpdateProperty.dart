// import 'package:Realify/presentation/member/UpdateProperty/EditHotel.dart';
// import 'package:Realify/presentation/widget/progress_dialog/main.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:Realify/backend/bloc/update_property_bloc/update_property_bloc.dart';
// import 'package:Realify/backend/models/RealifyProperty.dart';
// import 'package:Realify/presentation/member/AddProperty/reusables/main.dart';
// import 'package:Realify/presentation/member/UpdateProperty/EditRental.dart';
// import 'package:Realify/presentation/my_imports.dart';
// import 'package:Realify/presentation/public/HomePage/main.dart';

// class UpdateProperty extends StatefulWidget {
//   final RealifyProperty property;
//   const UpdateProperty({
//     Key key,
//     @required this.property,
//   }) : super(key: key);
//   @override
//   _UpdatePropertyState createState() => _UpdatePropertyState();
// }

// class _UpdatePropertyState extends State<UpdateProperty> with TickerProviderStateMixin {
//   String proposal = "";
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
//   List<String> prices = [];
//   List<String> imageUrls = [];
//   List<dynamic> bedroomsOffered = [];

//   TabController tabController;
//   void initState() {
//     super.initState();
//     tabController = new TabController(vsync: this, length: proposalList.length);
//     tabController.addListener(_handleTabSelection);
//     proposal = widget.property.proposal;
//     if (widget.property.proposal == "buy") {
//       tabController.index = 0;
//     } else if (widget.property.proposal == "rent") {
//       tabController.index = 1;
//     }
//   }

//   void _handleTabSelection() {
//     setState(() {});
//   }

//   var images = [];
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => UpdatePropertyBloc(),
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
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//                         },
//                         iconSize: Sizeconfig.huge,
//                         color: ColorConfig.dark,
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment(0, 0.1),
//                       child: Text(
//                         widget.property.name,
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
//               BlocConsumer<UpdatePropertyBloc, UpdatePropertyState>(
//                 listener: (context, state) {
         
//                   if (state is UploadedImagesState) {
//                     setState(() {
//                       imageUrls.addAll(state.propertyImageList.propertyImages.map((image) => image.url));
//                     });
//                     BlocProvider.of<UpdatePropertyBloc>(context).add(
//                       UploadPropertyEvent(
//                         proposal: proposal.isEmpty ? widget.property.proposal : proposal.toLowerCase(),
//                         category: category.isEmpty ? widget.property.categoryType : category.toLowerCase(),
//                         subCategory: subCategory.isEmpty ? widget.property.subCategoryType : subCategory.toLowerCase(),
//                         price: price.isEmpty ? widget.property.price : price.toLowerCase(),
//                         bedrooms: bedrooms.isEmpty ? widget.property.bedrooms : bedrooms.toLowerCase(),
//                         bathrooms: bathrooms.isEmpty ? widget.property.bathrooms : bathrooms.toLowerCase(),
//                         propertyName: propertyName.isEmpty ? widget.property.details : propertyName.toLowerCase(),
//                         description: description.isEmpty ? widget.property.description : description.toLowerCase(),
//                         rentalFrequency:
//                             rentalFrequency.isEmpty ? widget.property.paymentPeriod : rentalFrequency.toLowerCase(),
//                         area: area.isEmpty ? widget.property.area : area.toLowerCase(),
//                         areaUnit: widget.property.areaUnit,
//                         phone: phone.isEmpty ? widget.property.phone : phone.toLowerCase(),
//                         image: imageUrls.length <= 0 || imageUrls.length == null
//                             ? widget.property.images[0]
//                             : imageUrls[0],
//                         images: imageUrls.length <= 0 || imageUrls.length == null ? widget.property.images : imageUrls,
//                         county: widget.property.county,
//                         locality: widget.property.locality,
//                         propertyId: widget.property.id,
//                         bedroomsOfferedPrice: prices,
//                         bedroomsOffered: bedroomsOffered,
//                       ),
//                     );
//                     print(imageUrls);
//                   }
//                   if (state is StartPropertyUpdateState) {
//                     BlocProvider.of<UpdatePropertyBloc>(context).add(
//                       UploadPropertyEvent(
//                         proposal: proposal.isEmpty ? widget.property.proposal : proposal.toLowerCase(),
//                         category: category.isEmpty ? widget.property.categoryType : category.toLowerCase(),
//                         subCategory: subCategory.isEmpty ? widget.property.subCategoryType : subCategory.toLowerCase(),
//                         price: price.isEmpty ? widget.property.price : price.toLowerCase(),
//                         bedrooms: bedrooms.isEmpty ? widget.property.bedrooms : bedrooms.toLowerCase(),
//                         bathrooms: bathrooms.isEmpty ? widget.property.bathrooms : bathrooms.toLowerCase(),
//                         propertyName: propertyName.isEmpty ? widget.property.details : propertyName.toLowerCase(),
//                         description: description.isEmpty ? widget.property.description : description.toLowerCase(),
//                         rentalFrequency:
//                             rentalFrequency.isEmpty ? widget.property.paymentPeriod : rentalFrequency.toLowerCase(),
//                         area: area.isEmpty ? widget.property.area : area.toLowerCase(),
//                         areaUnit: widget.property.areaUnit,
//                         phone: phone.isEmpty ? widget.property.phone : phone.toLowerCase(),
//                         image: imageUrls.length <= 0 || imageUrls.length == null
//                             ? widget.property.images[0]
//                             : imageUrls[0],
//                         images: imageUrls.length <= 0 || imageUrls.length == null ? widget.property.images : imageUrls,
//                         county: widget.property.county,
//                         locality: widget.property.locality,
//                         propertyId: widget.property.id,
//                         bedroomsOffered: bedroomsOffered,
//                         bedroomsOfferedPrice: prices,
//                       ),
//                     );
//                   }
//                   if (state is UploadedPropertyState) {
//                     String message = "property listing successfully updated";
//                     showSnackbar(message, context);
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

//                       BlocProvider.of<UpdatePropertyBloc>(context)
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
//                               "Rent",
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
//                     BuyTabBar(
//                       property: widget.property,
//                     ),
//                     RentTabBar(
//                       property: widget.property,
//                     ),
//                   ],
//                 ),
//               ),
//               BlocBuilder<UpdatePropertyBloc, UpdatePropertyState>(
//                 builder: (context, state) {
//                   if (state is UploadedPropertyState) {
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
//                           BlocProvider.of<UpdatePropertyBloc>(context).add(StartPropertyUploadEvent());
//                           showMyDialogBox(context, "updating your listing");
//                           // print(state.toString());
//                         },
//                         child: Text(
//                           'Update',
//                           style: TextStyle(
//                             fontFamily: FontConfig.bold,
//                             fontSize: Sizeconfig.small,
//                             color: ColorConfig.light,
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
//     _tabController = new TabController(vsync: this, length: 2);
//     _tabController.addListener(_handleTabSelection);
//   }

//   void _handleTabSelection() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(
//               child: Container(
//                 height: 40,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     color: _tabController.index == 0 ? ColorConfig.lightGreen : ColorConfig.light,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(3),
//                     ),
//                     border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//                 child: Center(
//                   child: Text(
//                     "Residential",
//                     style: TextStyle(
//                         fontFamily: FontConfig.bold,
//                         fontSize: Sizeconfig.small,
//                         color: _tabController.index == 0 ? ColorConfig.light : ColorConfig.grey),
//                   ),
//                 ),
//               ),
//             ),
//             Tab(
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: _tabController.index == 1 ? ColorConfig.lightGreen : ColorConfig.light,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(3),
//                     ),
//                     border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//                 height: 40,
//                 width: MediaQuery.of(context).size.width,
//                 child: Center(
//                   child: Text(
//                     "Commercial",
//                     style: TextStyle(
//                         fontFamily: FontConfig.bold,
//                         fontSize: Sizeconfig.small,
//                         color: _tabController.index == 1 ? ColorConfig.light : ColorConfig.grey),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Container(
//           height: 120,
//           child: TabBarView(
//             controller: _tabController,
//             children: [
//               Residential(),
//               Commercial(),
//             ],
//           ),
//         )
//       ],
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
//     _tabController = new TabController(vsync: this, length: 3);
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
//           Tab(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: _tabController.index == 0 ? ColorConfig.lightGreen : ColorConfig.light,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(3),
//                   ),
//                   border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//               height: 40,
//               width: 60,
//               child: Center(
//                 child: Text(
//                   "Yearly",
//                   style: TextStyle(
//                       fontFamily: FontConfig.bold,
//                       fontSize: Sizeconfig.small,
//                       color: _tabController.index == 0 ? ColorConfig.light : ColorConfig.grey),
//                 ),
//               ),
//             ),
//           ),
//           Tab(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: _tabController.index == 1 ? ColorConfig.lightGreen : ColorConfig.light,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(3),
//                   ),
//                   border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//               height: 40,
//               width: 60,
//               child: Center(
//                 child: Text(
//                   "Monthly",
//                   style: TextStyle(
//                       fontFamily: FontConfig.bold,
//                       fontSize: Sizeconfig.small,
//                       color: _tabController.index == 1 ? ColorConfig.light : ColorConfig.grey),
//                 ),
//               ),
//             ),
//           ),
//           Tab(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: _tabController.index == 2 ? ColorConfig.lightGreen : ColorConfig.light,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(3),
//                   ),
//                   border: Border.all(width: 1, color: ColorConfig.smokeLight)),
//               height: 40,
//               width: 60,
//               child: Center(
//                 child: Text(
//                   "Weekly",
//                   style: TextStyle(
//                       fontFamily: FontConfig.bold,
//                       fontSize: Sizeconfig.small,
//                       color: _tabController.index == 2 ? ColorConfig.light : ColorConfig.grey),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
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
//     _tabController = new TabController(vsync: this, length: 9);
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
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-apartment.png"), "Apartment", _tabController, 0),
//           residentialAndCommercialtabBarItems(AssetImage("assets/icons/buy-villa.png"), "Villa", _tabController, 1),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-townhouse.png"), "Townhouse", _tabController, 2),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-penthouse.png"), "Penthouse", _tabController, 3),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-villa-compound.png"), "villa\ncompound", _tabController, 4),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-hotel.png"), "Hotel\nApartment", _tabController, 5),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-residential-land.png"), "Residential\nPlot", _tabController, 6),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-residential-floor.png"), "Residential\nFloor", _tabController, 7),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-residential-building.png"), "Residential\nBuilding", _tabController, 8),
//         ],
//       ),
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
//     _tabController = new TabController(vsync: this, length: 14);
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
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-commercial-office.png"), "Office", _tabController, 0),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-commercial-shop.png"), "Shop", _tabController, 1),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-commercial-warehouse.png"), "Warehouse", _tabController, 2),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-commercial-factory.png"), "Labour\n camp", _tabController, 3),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-commercial-villa.png"), "Commercial\n  Villa", _tabController, 4),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-commercial-units.png"), "Bulk\nUnits", _tabController, 5),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-commercial-plot.png"), "Commercial\n  Plot", _tabController, 6),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-commercial-floor.png"), "Commercial\n  Floor", _tabController, 7),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-commercial-building.png"), "Commercial\n  Building", _tabController, 8),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-commercial-factory-1.png"), "Factory", _tabController, 9),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-commercial-land.png"), "Industrial\n  Land", _tabController, 10),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/buy-residential-land.png"), "Mixed Use\n  Land", _tabController, 11),
//           residentialAndCommercialtabBarItems(AssetImage("assets/icons/showroom.png"), "Showroom", _tabController, 12),
//           residentialAndCommercialtabBarItems(
//               AssetImage("assets/icons/other.png"), "Other\nCommercial", _tabController, 13),
//         ],
//       ),
//     );
//   }
// }
