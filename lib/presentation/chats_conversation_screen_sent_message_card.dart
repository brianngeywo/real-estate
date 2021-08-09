import 'package:flutter/material.dart';

import 'contained_photo.dart';

class ChatsConversationScreenSentMessageCard extends StatefulWidget {
  final MainAxisAlignment mainAxisAlignment;
  final BorderRadius borderRadius;
  final String message;
  final Color cardColor;
  final Color textColor;
  final String profileUrl;
  const ChatsConversationScreenSentMessageCard({
    Key key,
    @required this.mainAxisAlignment,
    @required this.borderRadius,
    this.message = '',
    @required this.cardColor,
    this.profileUrl = "",
    @required this.textColor,
  }) : super(key: key);
  @override
  _ChatsConversationScreenSentMessageCardState createState() => _ChatsConversationScreenSentMessageCardState();
}

class _ChatsConversationScreenSentMessageCardState extends State<ChatsConversationScreenSentMessageCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(1, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.profileUrl.isNotEmpty
              ? containedPhoto(
                  40,
                  40,
                  BorderRadius.circular(1000),
                  widget.profileUrl,
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: widget.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: widget.borderRadius,
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.618,
                ),
                padding: const EdgeInsets.all(7),
                child: Text(
                  widget.message,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
