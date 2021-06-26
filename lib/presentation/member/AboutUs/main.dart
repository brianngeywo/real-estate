import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/HomePage/main.dart';

class AboutUs extends StatelessWidget {
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
                      "About Us",
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
            Divider(color: ColorConfig.grey.withOpacity(0.3)),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "WHO WE ARE",
                        style: TextStyle(
                            fontFamily: FontConfig.bold, fontSize: Sizeconfig.medium, color: ColorConfig.dark),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '''We are a kenyan startup that looks to make it easier for any kenyan to find a place to stay. We mainly operate in nairobi and will soon expand to the rest of kenya so to ensure all kenyans get access to this service. We work by linking property owners, real estate agents, property managers to any kenyan who is looking for a house to live in or sell.''',
                      style: TextStyle(
                          fontFamily: FontConfig.regular, fontSize: Sizeconfig.medium, color: ColorConfig.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     "WHAT WE ARE NOT",
                    //     style: TextStyle(
                    //         fontFamily: FontConfig.bold, fontSize: Sizeconfig.medium, color: ColorConfig.dark),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Text(
                    //   '''We are not real estate agents or property manager.''',
                    //   style: TextStyle(
                    //       fontFamily: FontConfig.regular, fontSize: Sizeconfig.medium, color: ColorConfig.grey),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     "HOW WE STARTED OUT",
                    //     style: TextStyle(
                    //         fontFamily: FontConfig.bold, fontSize: Sizeconfig.medium, color: ColorConfig.dark),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Text(
                    //   '''Cras hendrerit, neque ut pulvinar tempor, leo dolor elementum dolor, interdum malesuada mauris augue non tellus. Integer mollis ligula non enim imperdiet rhoncus.Vivamus ac lorem magna.''',
                    //   style: TextStyle(
                    //       fontFamily: FontConfig.regular, fontSize: Sizeconfig.medium, color: ColorConfig.grey),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
