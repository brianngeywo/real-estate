import 'package:Realify/backend/models/realify_user.dart';
import 'package:Realify/backend/services/authentication_api_provider.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/text_form_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import 'chats_conversation_screen_sent_message_card.dart';
import 'database.dart';

class ChatConversationScreen extends StatefulWidget {
  const ChatConversationScreen({Key key, @required this.user}) : super(key: key);
  final RealifyUser user;

  @override
  _ChatConversationScreenState createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  TextEditingController textController1 = TextEditingController();
  FirebaseAuth auth;
  AuthenticationApiProvider authenticationApiProvider = AuthenticationApiProvider();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode focusNode = FocusNode();
  String messageId = "";
  String chatRoomId = "";
  String myUsername = "";
  Uuid uuid = const Uuid();
  RealifyUser myUser;
  Stream messages = const Stream.empty();

  getMyInfoFromShardPrefs() async {
    // String? myName = await SharedPreferenceHelper().getDisplayname();
    myUser = await authenticationApiProvider.getUser();
    chatRoomId = getChatRoomIdbyUserId(auth.currentUser.uid, widget.user.id);
    await getAndSetMessages();
  }

  getChatRoomIdbyUserId(String a, String b) {
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

  // Stream<QuerySnapshot> messages;
  getAndSetMessages() async {
    messages = await DatabaseMethods().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  onLaunch() async {
    getMyInfoFromShardPrefs();
  }

  @override
  void initState() {
    super.initState();
    onLaunch();
  }

  sendMessage(bool sendClicked) async {
    String myUsername = await myUser.name;
    String myProfilePic = await myUser.photoUrl;
    if (textController1.text.isNotEmpty) {
      String message = textController1.text;
      var lastMessageTimeStamp = DateTime.now();
      Map<String, dynamic> messageInforMap = {
        "message": message,
        "sentBy": myUsername,
        "time sent": lastMessageTimeStamp,
        "imageUrl": myProfilePic,
      };
      //messageId
      if (messageId.isEmpty) {
        messageId = uuid.v1();
      }
      DatabaseMethods().addMessage(chatRoomId, messageId, messageInforMap).then(
        (value) {
          Map<String, dynamic> lastMessageInforMap = {
            "last message": message,
            "last message sent by": myUsername,
            "last message send time": lastMessageTimeStamp,
          };
          DatabaseMethods().updateLastMessageSent(chatRoomId, lastMessageInforMap, messageId);
          if (sendClicked) {
            // remove text typed
            textController1.text = "";
            //make message id blank
            messageId = "";
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        // automaticallyImplyLeading: true,
        backgroundColor: ColorConfig.grey,
        elevation: 0,
        title: Text(
          widget.user.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          Padding(
            padding:const EdgeInsets.only(right: 12.0),
            child: Center(
                child: IconButton(
              icon: const Icon(
                Icons.call,
                size: 26,
              ),
              onPressed: () => urlLauncher.launch("tel:${widget.user.phone}"),
            )),
          )
        ],
      ),
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: ColorConfig.grey,
              ),
            ),
            StreamBuilder(
              stream: messages,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data.docs.map<Widget>((DocumentSnapshot documentSnapshot) {
                      return ChatsConversationScreenSentMessageCard(
                        textColor: documentSnapshot["sentBy"] != myUsername ? Colors.black : Colors.white,
                        mainAxisAlignment:
                            documentSnapshot["sentBy"] != myUsername ? MainAxisAlignment.start : MainAxisAlignment.end,
                        borderRadius: documentSnapshot["sentBy"] != myUsername
                            ? const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )
                            : const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                        message: documentSnapshot["message"],
                        cardColor: documentSnapshot["sentBy"] != myUsername ? Colors.white : ColorConfig.grey,
                        profileUrl: documentSnapshot["sentBy"] != myUsername ? widget.user.photoUrl : "",
                      );
                    }).toList(),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorConfig.grey,
                      semanticsValue: snapshot.data,
                    ),
                  );
                }
              },
            ),
            // SingleChildScrollView(
            //   child: Container(
            //     margin: const EdgeInsets.only(bottom: 55.0),
            //     child: Column(
            //       mainAxisSize: MainAxisSize.max,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         widget.user.userId != currentUser!.uid
            //             ? ChatsConversationScreenSentMessageCard(
            //                 textColor: Colors.black,
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 borderRadius: const BorderRadius.only(
            //                   topRight: Radius.circular(20),
            //                   bottomLeft: Radius.circular(20),
            //                   bottomRight: Radius.circular(20),
            //                 ),
            //                 message: "message from my friend",
            //                 cardColor: Colors.white,
            //                 profileUrl: widget.user.photoUrl,
            //               )
            //             : ChatsConversationScreenSentMessageCard(
            //                 textColor: Colors.white,
            //                 mainAxisAlignment: MainAxisAlignment.end,
            //                 borderRadius: const BorderRadius.only(
            //                   topLeft: Radius.circular(20),
            //                   bottomLeft: Radius.circular(20),
            //                   bottomRight: Radius.circular(20),
            //                 ),
            //                 message: "message from me",
            //                 cardColor: backgroundColor,
            //               )
            //       ],
            //     ),
            //   ),
            // ),
            Align(
              alignment: const Alignment(0, 1),
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  right: 10,
                ),
                color: ColorConfig.grey,
                height: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: const Alignment(0, 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          // shape: BoxShape.rectangle,
                        ),
                        child: TextFormFieldWidget(
                          focusNode: focusNode,
                          hintText: "Type message",
                          textInputType: TextInputType.multiline,
                          controller: textController1,
                          onSubmitField: () {
                            // sendMessage(true);
                          },
                          onFieldTap: () {},
                          prefixIcon: null,
                          onChanged: (_) => setState(() {}),
                          borderSideColor: const Color(0x00000000),
                          clearIconColor: const Color(0xFF757575),
                          // expands: true,
                          minlines: 1,
                          maxlines: 200,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, 0.99),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFF285234),
                          // borderRadius: BorderRadius.circular(50),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () => sendMessage(true),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
