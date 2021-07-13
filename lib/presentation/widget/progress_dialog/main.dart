import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/themes/TypoGraphy.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  String message;
  ProgressDialog({@required this.message});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              SizedBox(width: 6.0),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(ColorConfig.lightGreen),
              ),
              SizedBox(width: 26.0),
              Text(
                message,
                style: TextStyle(fontFamily: FontConfig.regular),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showMyDialogBox(BuildContext context, String message) {
  showDialog(context: context, builder: (BuildContext context) {
    return ProgressDialog(
          message: message,
        );
  });
}
