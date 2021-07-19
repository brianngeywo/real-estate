
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/my_imports.dart';

class PropertyLocation extends StatefulWidget {
  @override
  _PropertyLocationState createState() => _PropertyLocationState();
}

class _PropertyLocationState extends State<PropertyLocation> {
  RealifyProperty property;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Navigator.of(context).pop();
                      },
                      iconSize: Sizeconfig.huge,
                      color: ColorConfig.dark,
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0.1),
                    child: Text(
                      "Property Location",
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
            Container(
                height: 1,
                width: double.maxFinite,
                color: ColorConfig.grey.withOpacity(0.3)),
            Expanded(
              flex: 1,
              child: GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.78825, -122.4324),
                  zoom: 10.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
