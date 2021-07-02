import 'package:flutter/foundation.dart';

class PropertyImage {
  final String url;
  PropertyImage({
    @required this.url,
  });
}

class PropertyList {
  final List<PropertyImage> propertyImages;

  PropertyList({@required this.propertyImages});
}
