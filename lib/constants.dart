import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
FirebaseAuth auth = FirebaseAuth.instance;
