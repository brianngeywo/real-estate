import 'package:Realify/presentation/member/MyProperties/hotelTab.dart';
import 'package:Realify/presentation/member/MyProperties/rentalTab.dart';
import 'package:Realify/presentation/my_imports.dart';

class MyProperties extends StatefulWidget {
  MyProperties({
    Key key,
  }) : super(key: key);
  @override
  _MyPropertiesState createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> with TickerProviderStateMixin {
  TabController tabController;
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 2);
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      iconSize: Sizeconfig.huge,
                      color: ColorConfig.dark,
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0.1),
                    child: Text(
                      "My Listings",
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
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                controller: tabController,
                tabs: [
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
                          "Rentals",
                          style: TextStyle(
                            fontFamily: FontConfig.bold,
                            fontSize: Sizeconfig.small,
                            color: tabController.index == 0 ? ColorConfig.light : ColorConfig.dark,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          color: tabController.index == 1 ? ColorConfig.lightGreen : ColorConfig.light,
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                          border: Border.all(width: 1, color: ColorConfig.smokeLight)),
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Hotels",
                          style: TextStyle(
                            fontFamily: FontConfig.bold,
                            fontSize: Sizeconfig.small,
                            color: tabController.index == 1 ? ColorConfig.light : ColorConfig.dark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  RentalTabBar(),
                  HotelTabBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
