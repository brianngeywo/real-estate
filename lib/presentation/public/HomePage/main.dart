import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
import 'package:Realify/presentation/member/AddProperty/main.dart';
import 'package:Realify/presentation/my_imports.dart';

class HomePage extends StatefulWidget {
  final RealifyPropertyRepository realifyPropertyRepository;
  const HomePage({
    Key key,
    this.realifyPropertyRepository,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      body: Builder(
        builder: (context) => SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1612253280934-3e0eb5b25251?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1534&q=80",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color.fromRGBO(49, 122, 87, 1), Color.fromRGBO(0, 0, 0, 0.8)]),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    MaterialIcons.sort,
                    color: ColorConfig.light,
                    size: Sizeconfig.huge,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Homeland",
                      style: TextStyle(fontFamily: FontConfig.logoFont, fontSize: 56, color: ColorConfig.light),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Find properties in Kenya",
                      style:
                          TextStyle(fontFamily: FontConfig.bold, fontSize: Sizeconfig.small, color: ColorConfig.light),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    width: double.maxFinite,
                    child: RaisedButton(
                      color: ColorConfig.lightGreen,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Filter()));
                      },
                      child: Text(
                        "Let's Search",
                        style: TextStyle(
                          fontFamily: FontConfig.bold,
                          fontSize: Sizeconfig.small,
                          color: ColorConfig.light,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 40, right: 40),
                  //   child: Container(
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(3),
                  //         border: Border.all(
                  //           color: ColorConfig.light,
                  //         )),
                  //     width: double.maxFinite,
                  //     child: MaterialButton(
                  //       onPressed: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => AddProperty(
                  //                       realifyPropertyRepository: widget.realifyPropertyRepository,
                  //                     )));
                  //       },
                  //       child: Text(
                  //         "Add Property Listing",
                  //         style: TextStyle(
                  //           fontFamily: FontConfig.regular,
                  //           fontSize: Sizeconfig.small,
                  //           color: ColorConfig.light,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: SizeConfig.isMobilePortrait ? 150 : 70,
                  ),
                  // Center(
                  //   child: Text(
                  //     "Continue your last search",
                  //     style: TextStyle(
                  //         fontFamily: FontConfig.regular,
                  //         fontSize: Sizeconfig.small,
                  //         color: ColorConfig.light),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15.0,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
                  //   child: Container(
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(3),
                  //       border: Border.all(
                  //         color: ColorConfig.light,
                  //       ),
                  //     ),
                  //     width: double.maxFinite,
                  //     child: FlatButton(
                  //       onPressed: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => AddProperty()));
                  //       },
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             "Add Property",
                  //             style: TextStyle(
                  //               fontFamily: FontConfig.regular,
                  //               fontSize: Sizeconfig.small,
                  //               color: ColorConfig.light,
                  //             ),
                  //           ),
                  //           Icon(
                  //             Ionicons.ios_arrow_forward,
                  //             size: Sizeconfig.huge,
                  //             color: ColorConfig.light,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}