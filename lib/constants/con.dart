import 'package:Realify/presentation/my_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
FirebaseAuth auth = FirebaseAuth.instance;
const kGoogleApiKey = "AIzaSyBTdjT83lRaqjcDYFthjetVo3NhCst76qM";
const callbackUrl = "https://us-central1-realify-75289.cloudfunctions.net/callback";
Color fgColor = ColorConfig.light;
Color backgroundColor = ColorConfig.darkGreen;