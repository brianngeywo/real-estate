import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/member/MySpaces/list.dart';
import 'package:Realify/presentation/my_imports.dart';

class MySpaces extends StatefulWidget {
  MySpaces({
    Key key,
  }) : super(key: key);
  @override
  _MySpacesState createState() => _MySpacesState();
}

class _MySpacesState extends State<MySpaces> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.light,
      appBar: AppBar(
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(AntDesign.arrowleft),
        //   onPressed: () {
        //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        //   },
        //   iconSize: Sizeconfig.huge,
        //   color: ColorConfig.dark,
        // ),
        title: Text(
          "Kwetu Spaces".toUpperCase(),
          style: TextStyle(fontFamily: FontConfig.bold, fontSize: Sizeconfig.medium, color: ColorConfig.dark),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    children: spacesList.map((element) {
                  return Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: MySpacesList(title: element.spaceName, url: element.url),
                  );
                }).toList()),
              ),
            ),
            Container(
              height: 55,
              width: double.infinity,
              color: Colors.white,
              child: MaterialButton(
                elevation: 0.0,
                color: ColorConfig.darkGreen,
                onPressed: () {},
                child: Text(
                  "Advertise with us",
                  style: TextStyle(color: ColorConfig.light, fontSize: Sizeconfig.small, fontFamily: FontConfig.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
