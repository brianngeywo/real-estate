import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:flutter/material.dart';

class HomelandImageGallery extends StatelessWidget {
  const HomelandImageGallery({Key key, this.property}) : super(key: key);
  final RealifyProperty property;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox.expand(
              child: Align(
                alignment: Alignment(0, 0),
                child: Container(
                  height: 400,
                  width: double.maxFinite,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: property.images.map((e) {
                        return Hero(
                          tag: "image-${property.image}-$e",
                          child: Image(
                            image: NetworkImage(
                              e,
                            ),
                            height: 350,
                            width: 330,
                            fit: BoxFit.contain,
                          ),
                        );
                      }).toList()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
