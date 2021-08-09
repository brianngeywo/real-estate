import 'package:Realify/presentation/public/HomePage/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'add_phone_number.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uuid = const Uuid().v1();
  addUserinfoToDatabase(BuildContext context, String userId, Map<String, dynamic> userInformationMap) {
    _firestore.collection("users").doc(userId).set(userInformationMap);
  }


  checkIfPhoneFieldExists(BuildContext context, String userId) {
    FirebaseFirestore.instance.collection('users').doc(userId).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot["phone number"] == "" || documentSnapshot["public name"] == "") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AddPhoneNumberPage(
              userId: userId,
            ),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    });
  }

  Future addMessage(String chatRoomId, String messageId, Map<String, dynamic> messageInforMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInforMap);
  }

  updateLastMessageSent(String chatRoomId, Map<String, dynamic> lastMessageInforMap, String messageId) {
    return _firestore
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .update(lastMessageInforMap);
  }

  createChatRoom(String chatRoomId, Map<String, dynamic> chatRoomInforMap) async {
    final snapshot = await _firestore.collection("chatrooms").doc(chatRoomId).get();
    if (snapshot.exists) {
      //chatroom already exists
      return true;
    } else {
      return _firestore.collection("chatrooms").doc(chatRoomId).set(chatRoomInforMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return _firestore
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time sent", descending: false)
        .snapshots();
  }
}
