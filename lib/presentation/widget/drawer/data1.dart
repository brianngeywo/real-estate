// import 'package:Realify/presentation/member/AboutUs/main.dart';
// import 'package:Realify/presentation/member/ContactUs/main.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/Filter/main.dart';

class Data1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Row(
            children: [
              Icon(
                IconName.iconhome,
                size: Sizeconfig.large,
                color: ColorConfig.grey,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                MenuName.home,
                style: TextStyle(fontFamily: FontConfig.regular, fontSize: Sizeconfig.small, color: ColorConfig.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Filter()));
          },
          child: Row(
            children: [
              Icon(
                IconName.iconsearch,
                size: Sizeconfig.large,
                color: ColorConfig.grey,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                MenuName.search,
                style: TextStyle(fontFamily: FontConfig.regular, fontSize: Sizeconfig.small, color: ColorConfig.grey),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
        // InkWell(
        //   onTap: () {
        //     Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => Filter()));
        //   },
        //   child: Row(
        //     children: [
        //       Icon(
        //         IconName.iconlsearch,
        //         size: Sizeconfig.large,
        //         color: ColorConfig.grey,
        //       ),
        //       SizedBox(
        //         width: 15,
        //       ),
        //       Text(
        //         MenuName.lsearch,
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
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => SavedSearch()));
        //   },
        //   child: Row(
        //     children: [
        //       Icon(
        //         IconName.iconssearch,
        //         size: Sizeconfig.large,
        //         color: ColorConfig.grey,
        //       ),
        //       SizedBox(
        //         width: 15,
        //       ),
        //       Text(
        //         MenuName.ssearch,
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
        //         context, MaterialPageRoute(builder: (context) => Favourite()));
        //   },
        //   child: Row(
        //     children: [
        //       Icon(
        //         IconName.iconfavourites,
        //         size: Sizeconfig.large,
        //         color: ColorConfig.grey,
        //       ),
        //       SizedBox(
        //         width: 15,
        //       ),
        //       Text(
        //         MenuName.favourites,
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
        //         context, MaterialPageRoute(builder: (context) => FloorPlan()));
        //   },
        //   child: Row(
        //     children: [
        //       Icon(
        //         IconName.iconfloor,
        //         size: Sizeconfig.large,
        //         color: ColorConfig.grey,
        //       ),
        //       SizedBox(
        //         width: 15,
        //       ),
        //       Text(
        //         MenuName.floor,
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
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => ManageAlert()));
        //   },
        //   child: Row(
        //     children: [
        //       Icon(
        //         IconName.iconalert,
        //         size: Sizeconfig.large,
        //         color: ColorConfig.grey,
        //       ),
        //       SizedBox(
        //         width: 15,
        //       ),
        //       Text(
        //         MenuName.alert,
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
        //         context, MaterialPageRoute(builder: (context) => Blog()));
        //   },
        //   child: Row(
        //     children: [
        //       Icon(
        //         IconName.iconblog,
        //         size: Sizeconfig.large,
        //         color: ColorConfig.grey,
        //       ),
        //       SizedBox(
        //         width: 15,
        //       ),
        //       Text(
        //         MenuName.blog,
        //         style: TextStyle(
        //             fontFamily: FontConfig.regular,
        //             fontSize: Sizeconfig.small,
        //             color: ColorConfig.grey),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
