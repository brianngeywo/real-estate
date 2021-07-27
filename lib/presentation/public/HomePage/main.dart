import 'package:Realify/backend/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
import 'package:Realify/presentation/member/AddListingChoices/main.dart';
import 'package:Realify/presentation/member/AddProperty/main.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/Filter/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  static const route = 'home';
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getDeviceDetails() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var box = await Hive.openBox("device details");
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    box.putAll({
      "version": version,
      "build number": buildNumber,
    });
  }

  @override
  void initState() {
    super.initState();
    getDeviceDetails();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
          drawer: DrawerMenu(),
          body: Builder(
              builder: (context) => SafeArea(
                    child: StreamBuilder(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: CircularProgressIndicator(
                                  color: ColorConfig.lightGreen,
                                ),
                              ),
                            );
                          }
                          return BlocBuilder<AuthBloc, AuthBlocState>(
                            builder: (context, state) {
                              if (state is UserRegisteredState) {
                                return Stack(
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
                                            "Kwetu App",
                                            style: TextStyle(
                                                fontFamily: FontConfig.logoFont,
                                                fontSize: 56,
                                                color: ColorConfig.light),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            "Find a place to stay.",
                                            style: TextStyle(
                                                fontFamily: FontConfig.bold,
                                                fontSize: Sizeconfig.small,
                                                color: ColorConfig.light),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25.0,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 40, right: 40),
                                          width: double.maxFinite,
                                          child: MaterialButton(
                                            color: ColorConfig.lightGreen,
                                            onPressed: () {
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) => Filter()));
                                            },
                                            child: Text(
                                              "Let's Search".toUpperCase(),
                                              style: TextStyle(
                                                fontFamily: FontConfig.bold,
                                                fontSize: Sizeconfig.small,
                                                color: ColorConfig.light,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.0,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 40, right: 40),
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
                                                border: Border.all(
                                                  color: ColorConfig.light,
                                                )),
                                            width: double.maxFinite,
                                            child: MaterialButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context, MaterialPageRoute(builder: (context) => AddListingChoices()));
                                              },
                                              child: Text(
                                                "Add Property Listing".toUpperCase(),
                                                style: TextStyle(
                                                  fontFamily: FontConfig.regular,
                                                  fontSize: Sizeconfig.small,
                                                  color: ColorConfig.light,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: SizeConfig.isMobilePortrait ? 150 : 70,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                              if (state is UserNotRegisteredState) {
                                return SignUp();
                              }
                              return Stack(
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
                                          "Kwetu App",
                                          style: TextStyle(
                                              fontFamily: FontConfig.logoFont, fontSize: 56, color: ColorConfig.light),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Find a place to stay.",
                                          style: TextStyle(
                                              fontFamily: FontConfig.bold,
                                              fontSize: Sizeconfig.medium,
                                              color: ColorConfig.light),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25.0,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 40, right: 40),
                                        width: double.maxFinite,
                                        child: MaterialButton(
                                          color: ColorConfig.lightGreen,
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Filter()));
                                          },
                                          child: Text(
                                            "Let's Search".toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: FontConfig.bold,
                                              fontSize: Sizeconfig.small,
                                              color: ColorConfig.light,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                      snapshot.hasData
                                          ? SizedBox(height: 0.0)
                                          : Center(
                                              child: Text(
                                                "Log in to add new property listing".toUpperCase(),
                                                style: TextStyle(
                                                    fontFamily: FontConfig.bold,
                                                    fontSize: Sizeconfig.tiny,
                                                    color: ColorConfig.light),
                                              ),
                                            ),
                                      SizedBox(height: snapshot.hasData ? 0 : 12),
                                      Padding(
                                        padding: EdgeInsets.only(left: 40, right: 40),
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(3),
                                              border: Border.all(
                                                color: ColorConfig.light,
                                              )),
                                          width: double.maxFinite,
                                          child: MaterialButton(
                                            onPressed: () {
                                              snapshot.hasData
                                                  ? Navigator.push(
                                                      context, MaterialPageRoute(builder: (context) => AddListingChoices()))
                                                  : BlocProvider.of<AuthBloc>(context).add(SigninWithGoogleEvent(context: context));
                                            },
                                            child: Text(
                                              snapshot.hasData
                                                  ? "Add Property Listing".toUpperCase()
                                                  : "Login".toUpperCase(),
                                              style: TextStyle(
                                                fontFamily: FontConfig.regular,
                                                fontSize: Sizeconfig.small,
                                                color: ColorConfig.light,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.isMobilePortrait ? 150 : 70,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                  ))),
    );
  }
}
