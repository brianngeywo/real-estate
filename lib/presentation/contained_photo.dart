import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget containedPhoto(double width, double height, BorderRadius borderRadius, String pictureUrl,) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
    child: Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: CachedNetworkImage(
        imageUrl: pictureUrl,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      ),
    ),
  );
}
