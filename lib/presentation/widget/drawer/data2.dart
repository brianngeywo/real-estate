import 'package:Realify/backend/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:Realify/presentation/member/AboutUs/main.dart';
import 'package:Realify/presentation/member/AddProperty/main.dart';
import 'package:Realify/presentation/member/ContactUs/main.dart';
import 'package:Realify/presentation/member/MyProperties/main.dart';
import 'package:Realify/presentation/member/Settings/main.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Data2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return Column(
            children: [
              snapshot.hasData
                  ? InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            IconName.iconsettings,
                            size: Sizeconfig.large,
                            color: ColorConfig.grey,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Personal Information",
                            style: TextStyle(
                                fontFamily: FontConfig.regular, fontSize: Sizeconfig.small, color: ColorConfig.grey),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(height: 0),
              SizedBox(height: snapshot.hasData ? 20 : 0),

              // InkWell(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentsPage()));
              //   },
              //   child: Row(
              //     children: [
              //       Icon(
              //         IconName.iconsettings,
              //         size: Sizeconfig.large,
              //         color: ColorConfig.grey,
              //       ),
              //       SizedBox(
              //         width: 15,
              //       ),
              //       Text(
              //         "Payments Page",
              //         style: TextStyle(
              //             fontFamily: FontConfig.regular, fontSize: Sizeconfig.small, color: ColorConfig.grey),
              //       ),
              //     ],
              //   ),
              // ),
              snapshot.hasData
                  ?
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddProperty()));
                },
                child: Row(
                  children: [
                    Icon(
                      IconName.iconproperty,
                      size: Sizeconfig.large,
                      color: ColorConfig.grey,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      MenuName.property,
                      style: TextStyle(
                          fontFamily: FontConfig.regular, fontSize: Sizeconfig.small, color: ColorConfig.grey),
                    ),
                  ],
                ),
              )
              : SizedBox(
                  height: 0,
                ),
              SizedBox(height: snapshot.hasData ? 20 : 0),
              snapshot.hasData
                  ? InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyProperties()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            IconName.iconmyproperties,
                            size: Sizeconfig.large,
                            color: ColorConfig.grey,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            MenuName.myprperties,
                            style: TextStyle(
                                fontFamily: FontConfig.regular, fontSize: Sizeconfig.small, color: ColorConfig.grey),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              SizedBox(height: snapshot.hasData ? 20 : 0),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => MyProperties()));
              //   },
              //   child: Row(
              //     children: [
              //       Icon(
              //         IconName.icondraft,
              //         size: Sizeconfig.large,
              //         color: ColorConfig.grey,
              //       ),
              //       SizedBox(
              //         width: 15,
              //       ),
              //       Text(
              //         MenuName.draft,
              //         style: TextStyle(
              //             fontFamily: FontConfig.regular,
              //             fontSize: Sizeconfig.small,
              //             color: ColorConfig.grey),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //         context, MaterialPageRoute(builder: (context) => Quota()));
              //   },
              //   child: Row(
              //     children: [
              //       Icon(
              //         IconName.iconquota,
              //         size: Sizeconfig.large,
              //         color: ColorConfig.grey,
              //       ),
              //       SizedBox(
              //         width: 15,
              //       ),
              //       Text(
              //         MenuName.quota,
              //         style: TextStyle(
              //             fontFamily: FontConfig.regular,
              //             fontSize: Sizeconfig.small,
              //             color: ColorConfig.grey),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // InkWell(
              //   onTap: () {},
              //   child: Row(
              //     children: [
              //       Icon(
              //         IconName.iconsettings,
              //         size: Sizeconfig.large,
              //         color: ColorConfig.grey,
              //       ),
              //       SizedBox(
              //         width: 15,
              //       ),
              //       Text(
              //         MenuName.settings,
              //         style: TextStyle(
              //             fontFamily: FontConfig.regular,
              //             fontSize: Sizeconfig.small,
              //             color: ColorConfig.grey),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              snapshot.hasData
                  ? InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            IconName.iconcontactus,
                            size: Sizeconfig.large,
                            color: ColorConfig.grey,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            MenuName.contactus,
                            style: TextStyle(
                                fontFamily: FontConfig.regular, fontSize: Sizeconfig.small, color: ColorConfig.grey),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(height: 0),
              SizedBox(height: snapshot.hasData ? 20 : 0),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
                },
                child: Row(
                  children: [
                    Icon(
                      IconName.iconaboutus,
                      size: Sizeconfig.large,
                      color: ColorConfig.grey,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      MenuName.aboutus,
                      style: TextStyle(
                          fontFamily: FontConfig.regular, fontSize: Sizeconfig.small, color: ColorConfig.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              snapshot.hasData
                  ? BlocBuilder<AuthBloc, AuthBlocState>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            BlocProvider.of<AuthBloc>(context).add(SignoutOfGoogleEvent());
                          },
                          child: Row(
                            children: [
                              Icon(
                                IconName.iconlogout,
                                size: Sizeconfig.large,
                                color: ColorConfig.grey,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                MenuName.logout,
                                style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    fontSize: Sizeconfig.small,
                                    color: ColorConfig.grey),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Container(),
            ],
          );
        });
  }
}
