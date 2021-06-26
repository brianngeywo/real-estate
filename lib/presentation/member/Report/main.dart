import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Realify/backend/bloc/report_property_bloc/report_property_bloc.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/backend/models/radio_list.dart';
import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
import 'package:Realify/presentation/my_imports.dart';

class Report extends StatefulWidget {
  final RealifyProperty property;
  const Report({
    Key key,
    @required this.property,
  }) : super(key: key);
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  int selectedRadio;
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  RealifyPropertyRepository repository = RealifyPropertyRepository();
  RealifyProperty property;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportPropertyBloc(),
      child: Scaffold(
        backgroundColor: ColorConfig.light,
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment(0, 0.1),
                      child: IconButton(
                        icon: Icon(AntDesign.arrowleft),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        iconSize: Sizeconfig.huge,
                        color: ColorConfig.dark,
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.1),
                      child: Text(
                        "Report Property",
                        style: TextStyle(
                          fontFamily: FontConfig.bold,
                          fontSize: Sizeconfig.medium,
                          color: ColorConfig.dark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: ColorConfig.grey.withOpacity(0.3)),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showDialogBox(context);
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<ReportPropertyBloc, ReportPropertyState>(
                                builder: (context, state) {
                                  if (state is ReportRadioButtonSelectedState) {
                                    setState(() {
                                      selectedRadioOption = state.title;
                                    });
                                    print("index: " + state.index.toString());
                                    print("title: " + state.title);
                                  }
                                  return Text(
                                    selectedRadioOption,
                                    style: TextStyle(
                                      fontFamily: FontConfig.regular,
                                      fontSize: Sizeconfig.small,
                                      color: Color.fromRGBO(0, 0, 0, 0.5),
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(
                                  Foundation.asterisk,
                                  color: ColorConfig.darkGreen,
                                  size: Sizeconfig.small,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(color: ColorConfig.grey.withOpacity(0.3)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0),
                      child: TextFormField(
                        controller: nameTextEditingController,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          color: ColorConfig.dark,
                          fontFamily: FontConfig.regular,
                          fontSize: Sizeconfig.small,
                        ),
                        cursorHeight: 20,
                        cursorColor: ColorConfig.darkGreen,
                        decoration: InputDecoration(
                            hintText: "Name",
                            hintStyle: TextStyle(
                              fontFamily: FontConfig.regular,
                              fontSize: Sizeconfig.small,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(
                                top: 7.0,
                              ),
                              child: Icon(
                                Foundation.asterisk,
                                color: ColorConfig.darkGreen,
                                size: Sizeconfig.small,
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.5),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0),
                      child: TextFormField(
                        controller: phoneTextEditingController,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          color: ColorConfig.dark,
                          fontFamily: FontConfig.regular,
                          fontSize: Sizeconfig.small,
                        ),
                        cursorHeight: 20,
                        cursorColor: ColorConfig.darkGreen,
                        decoration: InputDecoration(
                            hintText: "Phone number",
                            hintStyle: TextStyle(
                              fontFamily: FontConfig.regular,
                              fontSize: Sizeconfig.small,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Icon(
                                Foundation.asterisk,
                                color: ColorConfig.darkGreen,
                                size: Sizeconfig.small,
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.5),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0),
                      child: TextFormField(
                        controller: descriptionTextEditingController,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: ColorConfig.dark,
                          fontFamily: FontConfig.regular,
                          fontSize: Sizeconfig.small,
                        ),
                        cursorHeight: 20,
                        cursorColor: ColorConfig.darkGreen,
                        decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(
                              fontFamily: FontConfig.regular,
                              fontSize: Sizeconfig.small,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Icon(
                                Foundation.asterisk,
                                color: ColorConfig.darkGreen,
                                size: Sizeconfig.small,
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.5),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: ColorConfig.grey.withOpacity(0.3)),
              Container(
                height: 68,
                width: double.maxFinite,
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: RaisedButton(
                  elevation: 0.0,
                  color: ColorConfig.darkGreen,
                  onPressed: () {
                    repository.reportPropertyListing(selectedRadioOption, nameTextEditingController.text,
                        phoneTextEditingController.text, descriptionTextEditingController.text, context, widget.property);
                    setState(() {
                      descriptionTextEditingController.text = "";
                      nameTextEditingController.text = "";
                      phoneTextEditingController.text = "";
                    });
                  },
                  child: Text(
                    "Send Report",
                    style: TextStyle(
                      color: ColorConfig.light,
                      fontSize: Sizeconfig.small,
                      fontFamily: FontConfig.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List radioList = [
    RadioList(index: 0, name: "property location is wrong"),
    RadioList(index: 1, name: "inaccurate property images"),
    RadioList(index: 2, name: "unauthorised use of images"),
    RadioList(index: 3, name: "property not available"),
    RadioList(index: 4, name: "other"),
  ];

  // Default Radio Button Item
  String radioItem = 'property location is wrong';

  // Group Value for Radio Button.
  int id = 1;
  String selectedRadioOption = "select a Problem";
  Widget showDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => ReportPropertyBloc(),
            child: AlertDialog(
              actionsPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width / 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SELECT ROLE",
                            style: TextStyle(
                              fontFamily: FontConfig.bold,
                              fontSize: Sizeconfig.medium,
                              color: ColorConfig.grey,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              MaterialCommunityIcons.close,
                              size: 24,
                              color: ColorConfig.greyDark,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      BlocConsumer<ReportPropertyBloc, ReportPropertyState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Flexible(
                            child: Column(
                              children: radioList
                                  .map(
                                    (e) => RadioListTile(
                                        activeColor: Colors.greenAccent,
                                        title: Text(e.name),
                                        value: e.index,
                                        groupValue: id,
                                        onChanged: (val) {
                                          setState(() {
                                            id = e.index;
                                            radioItem = e.name;
                                            selectedRadioOption = e.name;
                                          });

                                          BlocProvider.of<ReportPropertyBloc>(context)
                                              .add(SelectRadioButtonEvent(index: e.index, title: e.name));
                                          print(state.toString());
                                        }),
                                  )
                                  .toList(),
                            ),
                          );
                        },
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //         padding: const EdgeInsets.only(left: 10),
                      //         child: Radio(
                      //             activeColor: Colors.greenAccent,
                      //             value: 0,
                      //             groupValue: selectedRadio,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 selectedRadio = value;
                      //               });
                      //               print(selectedRadio);
                      //             })),
                      //     new Text(
                      //       'property location is wrong',
                      //       style: new TextStyle(
                      //           fontFamily: FontConfig.regular, fontSize: Sizeconfig.small, color: ColorConfig.dark),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //         padding: const EdgeInsets.only(left: 10),
                      //         child: Radio(
                      //             activeColor: Colors.greenAccent,
                      //             value: 1,
                      //             groupValue: selectedRadio,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 selectedRadio = value;
                      //               });
                      //               print(selectedRadio);
                      //             })),
                      //     new Text(
                      //       'inaccurate property images',
                      //       style: new TextStyle(
                      //           fontFamily: FontConfig.regular, fontSize: Sizeconfig.small, color: ColorConfig.dark),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //         padding: const EdgeInsets.only(left: 10),
                      //         child: Radio(
                      //             activeColor: Colors.greenAccent,
                      //             value: 2,
                      //             groupValue: selectedRadio,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 selectedRadio = value;
                      //               });
                      //               print(selectedRadio);
                      //             })),
                      //     new Text(
                      //       'Unauthorized use of images',
                      //       style: new TextStyle(
                      //           fontFamily: FontConfig.regular, fontSize: Sizeconfig.small, color: ColorConfig.dark),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //         padding: const EdgeInsets.only(left: 10),
                      //         child: Radio(
                      //             activeColor: Colors.greenAccent,
                      //             value: 3,
                      //             groupValue: selectedRadio,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 selectedRadio = value;
                      //               });
                      //               print(selectedRadio);
                      //             })),
                      //     new Text(
                      //       'Property is not available',
                      //       style: new TextStyle(
                      //           fontFamily: FontConfig.regular, fontSize: Sizeconfig.small, color: ColorConfig.dark),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //         padding: const EdgeInsets.only(left: 10),
                      //         child: Radio(
                      //             activeColor: Colors.greenAccent,
                      //             value: 4,
                      //             groupValue: selectedRadio,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 selectedRadio = value;
                      //               });
                      //               print(selectedRadio);
                      //             })),
                      //     new Text(
                      //       'Others',
                      //       style: new TextStyle(
                      //           fontFamily: FontConfig.regular, fontSize: Sizeconfig.small, color: ColorConfig.dark),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
