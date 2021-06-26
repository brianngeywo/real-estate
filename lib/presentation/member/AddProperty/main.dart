import 'package:Realify/backend/models/Proposal.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
import 'package:Realify/presentation/member/AddProperty/AddBuyTabBar.dart';
import 'package:Realify/presentation/member/AddProperty/AddRentTabBar.dart';
import 'package:Realify/presentation/member/AddProperty/reusables/main.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/HomePage/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProperty extends StatefulWidget {
  final RealifyPropertyRepository realifyPropertyRepository;
  const AddProperty({Key key, this.realifyPropertyRepository}) : super(key: key);
  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> with TickerProviderStateMixin {
  TabController tabController;
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: proposal.length);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

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
                      "Create New Property",
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
            Container(height: 1, width: double.maxFinite, color: ColorConfig.grey.withOpacity(0.3)),
            TabBar(
              controller: tabController,
              tabs:
                  // proposal.map((proposal) {
                  //   return buildTabitems(context, proposal, tabController);
                  // }).toList()
                  [
                Tab(
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: tabController.index == 0 ? ColorConfig.lightGreen : ColorConfig.light,
                        borderRadius: BorderRadius.all(
                          Radius.circular(3),
                        ),
                        border: Border.all(width: 1, color: ColorConfig.smokeLight)),
                    child: Center(
                      child: Text(
                        "Buy",
                        style: TextStyle(
                            fontFamily: FontConfig.bold,
                            fontSize: Sizeconfig.small,
                            color: tabController.index == 0 ? ColorConfig.light : ColorConfig.grey),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: tabController.index == 1 ? ColorConfig.lightGreen : ColorConfig.light,
                        borderRadius: BorderRadius.all(
                          Radius.circular(3),
                        ),
                        border: Border.all(width: 1, color: ColorConfig.smokeLight)),
                    child: Center(
                      child: Text(
                        "Rent",
                        style: TextStyle(
                            fontFamily: FontConfig.bold,
                            fontSize: Sizeconfig.small,
                            color: tabController.index == 1 ? ColorConfig.light : ColorConfig.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              fit: FlexFit.tight,
              child: TabBarView(
                controller: tabController,
                children: [
                  BuyTabBar(),
                  RentTabBar(),
                ],
              ),
            ),
            Container(
              height: 73,
              width: double.maxFinite,
              padding: EdgeInsets.all(7),
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.all(6),
                width: double.maxFinite,
                color: Colors.white,
                child: MaterialButton(
                  elevation: 0.0,
                  color: ColorConfig.darkGreen,
                  onPressed: () {},
                  child: Text(
                    'Upload Now',
                    style: TextStyle(
                      fontFamily: FontConfig.bold,
                      fontSize: Sizeconfig.small,
                      color: ColorConfig.light,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: property tabbar
class Propertytype extends StatefulWidget {
  @override
  _PropertytypeState createState() => _PropertytypeState();
}

class _PropertytypeState extends State<Propertytype> with TickerProviderStateMixin {
  TabController _tabController;
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: _tabController.index == 0 ? ColorConfig.lightGreen : ColorConfig.light,
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                    border: Border.all(width: 1, color: ColorConfig.smokeLight)),
                child: Center(
                  child: Text(
                    "Residential",
                    style: TextStyle(
                        fontFamily: FontConfig.bold,
                        fontSize: Sizeconfig.small,
                        color: _tabController.index == 0 ? ColorConfig.light : ColorConfig.grey),
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                decoration: BoxDecoration(
                    color: _tabController.index == 1 ? ColorConfig.lightGreen : ColorConfig.light,
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                    border: Border.all(width: 1, color: ColorConfig.smokeLight)),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Commercial",
                    style: TextStyle(
                        fontFamily: FontConfig.bold,
                        fontSize: Sizeconfig.small,
                        color: _tabController.index == 1 ? ColorConfig.light : ColorConfig.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 120,
          child: TabBarView(
            controller: _tabController,
            children: [
              Residential(),
              Commercial(),
            ],
          ),
        )
      ],
    );
  }
}

// TODO: Rental tabbar

class Rentaltype extends StatefulWidget {
  @override
  _RentaltypeState createState() => _RentaltypeState();
}

class _RentaltypeState extends State<Rentaltype> with TickerProviderStateMixin {
  TabController _tabController;
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: TabBar(
        isScrollable: true,
        controller: _tabController,
        tabs: [
          Tab(
            child: Container(
              decoration: BoxDecoration(
                  color: _tabController.index == 0 ? ColorConfig.lightGreen : ColorConfig.light,
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                  border: Border.all(width: 1, color: ColorConfig.smokeLight)),
              height: 40,
              width: 60,
              child: Center(
                child: Text(
                  "Yearly",
                  style: TextStyle(
                      fontFamily: FontConfig.bold,
                      fontSize: Sizeconfig.small,
                      color: _tabController.index == 0 ? ColorConfig.light : ColorConfig.grey),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              decoration: BoxDecoration(
                  color: _tabController.index == 1 ? ColorConfig.lightGreen : ColorConfig.light,
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                  border: Border.all(width: 1, color: ColorConfig.smokeLight)),
              height: 40,
              width: 60,
              child: Center(
                child: Text(
                  "Monthly",
                  style: TextStyle(
                      fontFamily: FontConfig.bold,
                      fontSize: Sizeconfig.small,
                      color: _tabController.index == 1 ? ColorConfig.light : ColorConfig.grey),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              decoration: BoxDecoration(
                  color: _tabController.index == 2 ? ColorConfig.lightGreen : ColorConfig.light,
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                  border: Border.all(width: 1, color: ColorConfig.smokeLight)),
              height: 40,
              width: 60,
              child: Center(
                child: Text(
                  "Weekly",
                  style: TextStyle(
                      fontFamily: FontConfig.bold,
                      fontSize: Sizeconfig.small,
                      color: _tabController.index == 2 ? ColorConfig.light : ColorConfig.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// TODO: Residential Tabbar
class Residential extends StatefulWidget {
  @override
  _ResidentialState createState() => _ResidentialState();
}

class _ResidentialState extends State<Residential> with TickerProviderStateMixin {
  TabController _tabController;
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 9);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: TabBar(
        isScrollable: true,
        controller: _tabController,
        tabs: [
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-apartment.png"), "Apartment", _tabController, 0),
          residentialAndCommercialtabBarItems(AssetImage("assets/icons/buy-villa.png"), "Villa", _tabController, 1),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-townhouse.png"), "Townhouse", _tabController, 2),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-penthouse.png"), "Penthouse", _tabController, 3),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-villa-compound.png"), "villa\ncompound", _tabController, 4),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-hotel.png"), "Hotel\nApartment", _tabController, 5),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-residential-land.png"), "Residential\nPlot", _tabController, 6),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-residential-floor.png"), "Residential\nFloor", _tabController, 7),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-residential-building.png"), "Residential\nBuilding", _tabController, 8),
        ],
      ),
    );
  }
}

Widget buildTabitems(context, Proposal proposal, tabController) {
  return Tab(
    child: Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: tabController.index == 0 ? ColorConfig.lightGreen : ColorConfig.light,
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          border: Border.all(width: 1, color: ColorConfig.smokeLight)),
      child: Center(
        child: Text(
          proposal.name,
          style: TextStyle(
              fontFamily: FontConfig.bold,
              fontSize: Sizeconfig.small,
              color: tabController.index == 0 ? ColorConfig.light : ColorConfig.grey),
        ),
      ),
    ),
  );
}
//  TODO Commercial TabBar

class Commercial extends StatefulWidget {
  @override
  _CommercialState createState() => _CommercialState();
}

class _CommercialState extends State<Commercial> with TickerProviderStateMixin {
  TabController _tabController;
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 14);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: TabBar(
        isScrollable: true,
        controller: _tabController,
        tabs: [
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-commercial-office.png"), "Office", _tabController, 0),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-commercial-shop.png"), "Shop", _tabController, 1),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-commercial-warehouse.png"), "Warehouse", _tabController, 2),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-commercial-factory.png"), "Labour\n camp", _tabController, 3),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-commercial-villa.png"), "Commercial\n  Villa", _tabController, 4),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-commercial-units.png"), "Bulk\nUnits", _tabController, 5),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-commercial-plot.png"), "Commercial\n  Plot", _tabController, 6),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-commercial-floor.png"), "Commercial\n  Floor", _tabController, 7),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-commercial-building.png"), "Commercial\n  Building", _tabController, 8),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-commercial-factory-1.png"), "Factory", _tabController, 9),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-commercial-land.png"), "Industrial\n  Land", _tabController, 10),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/buy-residential-land.png"), "Mixed Use\n  Land", _tabController, 11),
          residentialAndCommercialtabBarItems(AssetImage("assets/icons/showroom.png"), "Showroom", _tabController, 12),
          residentialAndCommercialtabBarItems(
              AssetImage("assets/icons/other.png"), "Other\nCommercial", _tabController, 13),
        ],
      ),
    );
  }
}
