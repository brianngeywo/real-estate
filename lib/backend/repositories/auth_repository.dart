import 'package:Realify/backend/models/phone_euth_model.dart';
import 'package:Realify/backend/models/realify_user.dart';
import 'package:Realify/backend/services/authentication_api_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  AuthenticationApiProvider _authFirebaseProvider = AuthenticationApiProvider();

  addUserToFirebase(String name, String phone, String role) {
    _authFirebaseProvider.addUserToFirestore(name, phone, role);
  }

  Future<RealifyUser> getUser() async {
    var user = await _authFirebaseProvider.getUser();
    return user;
  }

  Future<List<DocumentSnapshot>> signInAndGetUser() async {
    var documents = await _authFirebaseProvider.signInAndGetUser();
    return documents;
  }
}
