import 'package:Realify/backend/models/realify_user.dart';
import 'package:Realify/backend/services/authentication_api_provider.dart';
import 'package:Realify/constants/con.dart';
import 'package:Realify/presentation/search_users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_conversation_screen.dart';
import 'chats_list_card.dart';
import 'database.dart';

class ChatsListScreen extends StatefulWidget {
  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  FirebaseAuth auth;
  String myUsername;
  AuthenticationApiProvider authenticationApiProvider;
  RealifyUser myUser;
  String getChatRoomIdbyUserId(String a, String b) {
    // if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    //   return "$b\_$a";
    // } else {
    //   return "$a\_$b";
    // }
    if (a.hashCode <= b.hashCode) {
      return '$a-$b';
    } else {
      return '$b-$a';
    }
  }

  getPrefs() async {
    myUser = await authenticationApiProvider.getUser();
    myUsername = myUser.name;
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection("users").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          // leading: const Icon(Icons.home),
          title: const Text(
            "HomeLand",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: IconButton(
                padding: const EdgeInsets.only(right: 10),
                onPressed: () {
                  showSearch(context: context, delegate: ChatsSearch());
                },
                icon: const Icon(Icons.search_rounded),
              ),
            ),
          ]),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                RealifyUser user = RealifyUser.fromSnapshot(document);

                return user.id != auth.currentUser.uid
                    ? InkWell(
                        onTap: () {
                          String chatRoomId = getChatRoomIdbyUserId(auth.currentUser.uid, user.id);
                          Map<String, dynamic> chatRoomInforMap = {
                            "users": [myUsername, user.name]
                          };
                          DatabaseMethods().createChatRoom(chatRoomId, chatRoomInforMap);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ChatConversationScreen(
                                  user: user,
                                );
                              },
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            chatsListCard(user),
                            const Divider(),
                          ],
                        ),
                      )
                    : Container();
              }).toList(),
            );
          }
          return const Text("no chats found...");
        },
      ),
    );
  }
}
