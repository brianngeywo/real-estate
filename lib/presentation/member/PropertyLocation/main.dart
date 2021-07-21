import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/my_imports.dart';

class PropertyLocation extends StatefulWidget {
  final RealifyProperty property;
  const PropertyLocation({
    Key key,
    @required this.property,
  }) : super(key: key);

  @override
  _PropertyLocationState createState() => _PropertyLocationState();
}

class _PropertyLocationState extends State<PropertyLocation> {
  GoogleMapController _controller;
  List<Marker> _markers = [];
  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
        markerId: MarkerId(widget.property.id),
        position: LatLng(widget.property.lat, widget.property.lng),
        infoWindow: InfoWindow(title: widget.property.details)));
  }

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
                      widget.property.location,
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
            Expanded(
              flex: 1,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.property.lat, widget.property.lng),
                  zoom: 12,
                ),
                mapType: MapType.normal,
                markers: Set<Marker>.of(_markers),
                onMapCreated: (GoogleMapController controller) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
