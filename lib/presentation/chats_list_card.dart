import 'package:Realify/backend/models/realify_user.dart';
import 'package:flutter/material.dart';

import 'contained_photo.dart';

Widget chatsListCard(RealifyUser user) {
  return ListTile(
    leading: containedPhoto(
      50,
      50,
      BorderRadius.circular(1000),
      user.photoUrl,
    ),
    title: Text(user.name),
    subtitle: Text(user.email),
  );
}
