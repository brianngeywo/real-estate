import 'package:Realify/backend/models/realify_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_conversation_screen.dart';
import 'chats_list_card.dart';

class ChatsSearch extends SearchDelegate {
  FirebaseAuth auth;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const BackButton(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    final Stream<QuerySnapshot> usersStream = query.isEmpty
        ? FirebaseFirestore.instance.collection("users").snapshots()
        : FirebaseFirestore.instance.collection("users").where("display name", isEqualTo: query).snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError || snapshot.data == null) {
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Could not complete request",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Loading Results...",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }
          return snapshot.data.docs.isEmpty
              ? const Text("no results...")
              : ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                    RealifyUser user = RealifyUser.fromSnapshot(documentSnapshot);
                    return user.id != auth.currentUser.uid
                        ? InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChatConversationScreen(user: user);
                                },
                              ),
                            ),
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
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Stream<QuerySnapshot> usersStream = query.isEmpty
        ? FirebaseFirestore.instance.collection("users").snapshots()
        : FirebaseFirestore.instance.collection("users").where("display name", isEqualTo: query).snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError || snapshot.data == null) {
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Could not complete request",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Loading suggestions...",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }

          return snapshot.data.docs.isEmpty
              ? const Text("no results...")
              : ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                    RealifyUser user = RealifyUser.fromSnapshot(documentSnapshot);
                    return user.id != auth.currentUser.uid
                        ? InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChatConversationScreen(user: user);
                                },
                              ),
                            ),
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
        });
  }
}
