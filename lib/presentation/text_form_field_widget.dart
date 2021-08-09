import 'package:flutter/material.dart';

/// *  textInputType - The type of information for which to optimize the text input control.
/// *  hintText - Text that suggests what sort of input the field accepts.
/// *  prefixIcon - Pass Icon if required
/// *  defaultText - If there is predefined value is there for a text field
/// *  focusNode - Currently focus node
/// *  obscureText - Is Password field?
/// *  controller - Text controller
/// *  functionValidate - Validation function(currently I have used to check empty field)
/// *  parametersValidate - Value to validate
/// *  actionKeyboard - Keyboard action eg. next, done, search, etc
/// *  onSubmitField - Done click action
/// *  onFieldTap - On focus on TextField
// ignore: must_be_immutable
class TextFormFieldWidget extends StatefulWidget {
  final TextInputType textInputType;
  final String hintText;
  final Widget prefixIcon;
  final Widget suffixIcon;

  // final String defaultText;
  final FocusNode focusNode;
  final bool obscureText;
  final TextEditingController controller;

  final TextInputAction actionKeyboard;
  final Function onSubmitField;
  final Function onFieldTap;
  final Function onChanged;
  final Color textColor;
  int maxlines =0;
  int minlines =0;
  final bool expands;
  final Color borderSideColor;
  final Color clearIconColor;

  TextFormFieldWidget({
    Key key,
    @required this.hintText,
    @required this.focusNode,
    @required this.textInputType,
    // required this.defaultText,
    this.obscureText = false,
    @required this.controller,
    this.actionKeyboard = TextInputAction.next,
    @required this.onSubmitField,
    @required this.onFieldTap,
    this.prefixIcon,
    this.suffixIcon,
    this.textColor = Colors.black,
    this.maxlines = 1,
    this.minlines = 1,
    this.expands = false,
    @required this.onChanged,
    @required this.borderSideColor,
    @required this.clearIconColor,
  });

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Theme.of(context).primaryColor,
      ),
      child: TextFormField(
        focusNode: widget.focusNode,
        expands: widget.expands,
        minLines: widget.minlines,
        maxLines: widget.maxlines,
        onChanged: (_) => widget.onChanged,
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          // labelText: 'property description',
          hintText: widget.hintText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderSideColor,
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderSideColor,
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          suffixIcon: widget.controller.text.isNotEmpty
              ? InkWell(
                  onTap: () => setState(
                    () => widget.controller.clear(),
                  ),
                  child: Icon(
                    Icons.clear,
                    color: widget.clearIconColor,
                    size: 22,
                  ),
                )
              : null,
        ),
        keyboardType: widget.textInputType,
      ),
    );
  }
}
