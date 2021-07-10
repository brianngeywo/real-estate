import 'package:Realify/backend/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:Realify/backend/bloc/selected_radio_bloc/select_radio_button_bloc.dart';
import 'package:Realify/backend/models/radio_list.dart';
import 'package:Realify/presentation/member/Settings/main.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/SignUp/DropDown.dart';
import 'package:Realify/presentation/public/SignUp/userFields.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int selectedRadio;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState() {
      selectedRadio = val;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SelectRadioButtonBloc()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        body: SafeArea(
          child: Column(
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
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => SignIn()));
                          Navigator.of(context).pop();
                        },
                        iconSize: Sizeconfig.huge,
                        color: ColorConfig.dark,
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.1),
                      child: Text(
                        "Sign Up",
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
              Expanded(
                flex: 14,
                child: Container(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, left: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: ColorConfig.smokeLight,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      controller: nameTextEditingController,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "company name/ personal name",
                                        hintStyle: TextStyle(
                                          fontFamily: FontConfig.regular,
                                          fontSize: Sizeconfig.small,
                                          color: Color.fromRGBO(0, 0, 0, 0.5),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: ColorConfig.smokeLight,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      controller: phoneTextEditingController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "0798767470",
                                        hintStyle: TextStyle(
                                          fontFamily: FontConfig.regular,
                                          fontSize: Sizeconfig.small,
                                          color: Color.fromRGBO(0, 0, 0, 0.5),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          InkWell(
                            onTap: () {
                              showDialogBox(context);
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    BlocBuilder<SelectRadioButtonBloc, SelectRadioButtonState>(
                                      builder: (context, state) {
                                        if (state is RadioButtonSelectedBlocState) {
                                          setState(() {
                                            selectedRadioOption = state.title;
                                          });
                                        }
                                        return Text(
                                          selectedRadioOption,
                                          style: TextStyle(
                                            fontFamily: FontConfig.regular,
                                            fontSize: Sizeconfig.small,
                                            color: ColorConfig.grey,
                                          ),
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Foundation.asterisk,
                                        size: Sizeconfig.small,
                                        color: ColorConfig.darkGreen,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.5, bottom: 20),
                                  child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Icon(
                                  Foundation.asterisk,
                                  size: Sizeconfig.small,
                                  color: ColorConfig.darkGreen,
                                ),
                              ),
                              Text(
                                "All Fields are required",
                                style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    fontSize: Sizeconfig.small,
                                    color: ColorConfig.grey),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'By Clicking Create Account, I agree the Terms & Conditions',
                                style: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    fontSize: Sizeconfig.small,
                                    color: ColorConfig.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(color: ColorConfig.grey.withOpacity(0.3)),
              Container(
                height: 68,
                width: double.maxFinite,
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: MaterialButton(
                  elevation: 0.0,
                  color: ColorConfig.darkGreen,
                  onPressed: () {
                    if (nameTextEditingController.text.isNotEmpty &&
                        nameTextEditingController.text != null &&
                        phoneTextEditingController.text.isNotEmpty &&
                        phoneTextEditingController.text != null &&
                        selectedRadioOption != "select Role") {
                      BlocProvider.of<AuthBloc>(context).add(AddUserToFirestoreEvent(
                          name: nameTextEditingController.text,
                          phone: phoneTextEditingController.text,
                          role: selectedRadioOption));
                    } else {
                      String message = "no field should be blank";
                      showSnackbar(message, context);
                    }
                  },
                  child: Text(
                    "Create Account",
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

  var roles = [
    RadioList(index: 0, name: 'Owner'),
    RadioList(index: 1, name: 'Agent / Brokerage'),
    RadioList(index: 2, name: 'Developer'),
  ];
  // Default Radio Button Item
  String radioItem = '';

  // Group Value for Radio Button.
  int id;
  String selectedRadioOption = "select Role";
  showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => SelectRadioButtonBloc(),
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.all(0),
            content: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 0.1,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 5),
                    color: Colors.white,
                    child: Row(
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
                        )
                      ],
                    ),
                  ),
                  BlocConsumer<SelectRadioButtonBloc, SelectRadioButtonState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Flexible(
                        child: Column(
                          children: roles
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
                                      BlocProvider.of<SelectRadioButtonBloc>(context)
                                          .add(SelectRadioButtonBlocEvent(index: e.index, title: e.name));
                                    }),
                              )
                              .toList(),
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    width: double.maxFinite,
                    height: 70,
                    color: Colors.white,
                    child: MaterialButton(
                      elevation: 0.0,
                      color: ColorConfig.darkGreen,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'DONE',
                        style: TextStyle(
                          fontFamily: FontConfig.bold,
                          fontSize: Sizeconfig.small,
                          color: ColorConfig.light,
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
      },
    );
  }
}

void showSnackbar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
