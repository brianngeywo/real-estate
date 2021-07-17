import 'package:Realify/backend/models/realify_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthenticationApiProvider {
  final FirebaseAuth _firebaseAuth;
  AuthenticationApiProvider({
    FirebaseAuth firebaseAuth,
  })  : assert(firebaseAuth != null),
        _firebaseAuth = firebaseAuth;

  addUserToFirestore(String name, String phone, String role) {
    var user = FirebaseAuth.instance.currentUser;
    var userid = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection("users").doc(userid).set(
        {"phone": phone, "id": userid, "name": name, "role": role, "email": user.email, "photoUrl": user.photoURL});
  }

  Future<RealifyUser> getUser() async {
    var auth = FirebaseAuth.instance;
    RealifyUser currentUser = RealifyUser();
    DocumentSnapshot userDocSnap = await FirebaseFirestore.instance.collection("users").doc(auth.currentUser.uid).get();

    currentUser = RealifyUser.fromSnapshot(userDocSnap);
    return currentUser;
  }

  Future<List<DocumentSnapshot>> signInAndGetUser() async {
    var box = await Hive.openBox('user');
    final googleSignin = GoogleSignIn();
    var auth = FirebaseAuth.instance;
    final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
    GoogleSignInAccount user;
    User firebaseuser;
    final googleUser = await googleSignin.signIn();
    if (googleUser == null) return null;
    user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      firebaseuser = FirebaseAuth.instance.currentUser;
      box.put("user id", firebaseuser.uid);
      box.put("user name", firebaseuser.displayName);
      box.put("user email", firebaseuser.email);
    });
    // var firestore = FirebaseFirestore.instance;

    final QuerySnapshot result = await usersRef.where('id', isEqualTo: auth.currentUser.uid).get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents;
  }
}
