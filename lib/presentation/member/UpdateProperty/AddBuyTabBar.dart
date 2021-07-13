import 'package:Realify/backend/bloc/update_property_bloc/update_property_bloc.dart';
import 'package:Realify/backend/models/Property_image.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/member/UpdateProperty/UpdateProperty.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class BuyTabBar extends StatefulWidget {
  final RealifyProperty property;
  const BuyTabBar({
    Key key,
    @required this.property,
  }) : super(key: key);
  @override
  _BuyTabBarState createState() => _BuyTabBarState();
}

class _BuyTabBarState extends State<BuyTabBar> with AutomaticKeepAliveClientMixin {
  TextEditingController detailsTextEditingController = TextEditingController();
  TextEditingController priceTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController();
  TextEditingController areaTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  List<PropertyImage> urls = <PropertyImage>[];
  String areaUnit = "";
  @override
  void initState() {
    super.initState();
    selectedPropertyType = widget.property.subCategoryType;
    bedrooms = widget.property.bedrooms;
    bathrooms = widget.property.bathrooms;
    detailsTextEditingController.text = widget.property.name;
    priceTextEditingController.text = widget.property.price;
    descriptionTextEditingController.text = widget.property.description;
    areaTextEditingController.text = widget.property.area;
    phoneTextEditingController.text = widget.property.phone;
  }

  String selectedPropertyType = "";
  String bedrooms = "";
  String bathrooms = "";
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 30,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "home",
          doneButtonTitle: "done",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#009590",
          actionBarTitle: "Homeland",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Widget buildCurrentGridView() {
    return Container(
      height: 1200,
      width: 250,
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        children: List.generate(widget.property.images.length, (index) {
          String image = widget.property.images[index];
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.network(image),
          );
        }),
      ),
    );
  }

  Widget buildGridView() {
    return Container(
      height: 1200,
      width: 250,
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: AssetThumb(
              asset: asset,
              width: 300,
              height: 300,
            ),
          );
        }),
      ),
    );
  }

  int selected = null;
  List<DropdownMenuItem<int>> listDrop = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdatePropertyBloc, UpdatePropertyState>(
      listener: (context, state) {
        if (state is StartPropertyUploadState) {
          if (images != null && images.length > 0) {
            BlocProvider.of<UpdatePropertyBloc>(context).add(UploadImagesEvent(propertyImagesList: images));
          } else {
            BlocProvider.of<UpdatePropertyBloc>(context).add(StartPropertyUpdateEvent());
          }
        }
      },
      builder: (context, state) {
     
        return ListView(
          addAutomaticKeepAlives: true,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Icon(
                    Entypo.home,
                    size: Sizeconfig.huge,
                    color: ColorConfig.darkGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Property Types",
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
            SizedBox(
              height: 10,
            ),
            // Propertytype(),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<UpdatePropertyBloc, UpdatePropertyState>(
              builder: (context, state) {
                return Wrap(
                  direction: Axis.horizontal,
                  children: residentialCategoryTypeList
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  selectedPropertyType == e.toLowerCase() ? ColorConfig.lightGreen : ColorConfig.light,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              border: Border.all(
                                width: 1,
                                color: selectedPropertyType == e.toLowerCase()
                                    ? ColorConfig.lightGreen
                                    : ColorConfig.smokeDark,
                              ),
                            ),
                            child: MaterialButton(
                              elevation: 0,
                              onPressed: () {
                                setState(() {
                                  selectedPropertyType = e.toLowerCase();
                                });
                                BlocProvider.of<UpdatePropertyBloc>(context)
                                    .add((SelectedSubCategoryEvent(subcategoryTitle: e)));
                              },
                              color: Colors.transparent,
                              textColor: selectedPropertyType == e.toLowerCase() ? ColorConfig.light : ColorConfig.grey,
                              child: Text(e),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Icon(
                    FontAwesome5.clipboard_list,
                    size: Sizeconfig.huge,
                    color: ColorConfig.darkGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Property Details",
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
            SizedBox(
              height: 10,
            ),
            BlocBuilder<UpdatePropertyBloc, UpdatePropertyState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
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
                        controller: detailsTextEditingController,
                        onChanged: (value) =>
                            BlocProvider.of<UpdatePropertyBloc>(context).add(AddPropertyTitleEvent(title: value)),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "property title",
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
                );
              },
            ),

            SizedBox(
              height: 10,
            ),
            BlocBuilder<UpdatePropertyBloc, UpdatePropertyState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
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
                        controller: descriptionTextEditingController,
                        minLines: 20,
                        maxLines: 500,
                        onChanged: (value) {
                          BlocProvider.of<UpdatePropertyBloc>(context)
                              .add(AddPropertyDescriptionEvent(description: value));
                        },
                        style: TextStyle(
                          fontFamily: FontConfig.regular,
                          fontSize: Sizeconfig.small,
                          color: ColorConfig.dark,
                        ),
                        decoration: InputDecoration(
                          hintText: "Property Description",
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
                );
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15, right: 15),
            //   child: Container(height: 1, width: double.maxFinite, color: ColorConfig.grey.withOpacity(0.3)),
            // ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Icon(
                    Ionicons.ios_pricetag,
                    size: Sizeconfig.huge,
                    color: ColorConfig.darkGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Price",
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
            SizedBox(
              height: 10,
            ),
            BlocBuilder<UpdatePropertyBloc, UpdatePropertyState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    padding: EdgeInsets.only(
                      right: 15,
                      left: 10,
                    ),
                    height: 40,
                    decoration: BoxDecoration(
                      color: ColorConfig.smokeLight,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: TextField(
                        controller: priceTextEditingController,
                        onChanged: (value) {
                          BlocProvider.of<UpdatePropertyBloc>(context).add(EnteredPriceEvent(price: value));
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontFamily: FontConfig.regular,
                          fontSize: Sizeconfig.small,
                          color: ColorConfig.dark,
                        ),
                        decoration: InputDecoration(
                          hintText: widget.property.price,
                          hintStyle: TextStyle(
                            fontFamily: FontConfig.regular,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Icon(
                    AntDesign.appstore_o,
                    size: Sizeconfig.huge,
                    color: ColorConfig.darkGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Area",
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
            SizedBox(
              height: 10,
            ),
            BlocBuilder<UpdatePropertyBloc, UpdatePropertyState>(
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.only(
                    right: 15,
                    left: 10,
                  ),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            right: 15,
                            left: 10,
                          ),
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: ColorConfig.smokeLight,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: TextField(
                              controller: areaTextEditingController,
                              onChanged: (value) {
                                BlocProvider.of<UpdatePropertyBloc>(context).add(
                                    AddPropertyAreaEvent(area: value, areaUnit: areaUnit.isEmpty ? 'Sq.M.' : areaUnit));
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontFamily: FontConfig.regular,
                                fontSize: Sizeconfig.small,
                                color: ColorConfig.dark,
                              ),
                              decoration: InputDecoration(
                                hintText: widget.property.area,
                                hintStyle: TextStyle(
                                  fontFamily: FontConfig.regular,
                                  fontSize: Sizeconfig.small,
                                  color: ColorConfig.dark,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: ColorConfig.smokeLight,
                              border: Border.all(
                                width: 1,
                                color: ColorConfig.smokeLight,
                              ),
                              borderRadius: BorderRadius.circular(3)),
                          child: BlocConsumer<UpdatePropertyBloc, UpdatePropertyState>(
                            listener: (context, state) {
                              if (state is UpdatePropertyAreaState) {}
                            },
                            builder: (context, state) {
                              return Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      // itemHeight: 2,
                                      iconSize: 25,
                                      elevation: 0,
                                      value: selected,
                                      hint: Text(
                                        'Square Metres',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 0.7),
                                        ),
                                      ),
                                      items: listDrop,
                                      onChanged: (value) {
                                        selected = value;
                                        setState(() {
                                          switch (value) {
                                            case 1:
                                              BlocProvider.of<UpdatePropertyBloc>(context)
                                                  .add(AddPropertyAreaEvent(areaUnit: 'Sq.M.'));
                                              break;
                                            case 2:
                                              BlocProvider.of<UpdatePropertyBloc>(context)
                                                  .add(AddPropertyAreaEvent(areaUnit: 'Sq.Ft.'));
                                              break;
                                            case 3:
                                              BlocProvider.of<UpdatePropertyBloc>(context)
                                                  .add(AddPropertyAreaEvent(areaUnit: 'Sq.Yd'));
                                              break;
                                            default:
                                              BlocProvider.of<UpdatePropertyBloc>(context)
                                                  .add(AddPropertyAreaEvent(areaUnit: 'Sq.M.'));
                                          }
                                        });
                                      },
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Icon(
                    FontAwesome.bed,
                    size: Sizeconfig.huge,
                    color: ColorConfig.darkGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Bedrooms",
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
            // Bedroomtype(),
            BlocBuilder<UpdatePropertyBloc, UpdatePropertyState>(
              builder: (context, state) {
                return Container(
                  // height: 60,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Wrap(
                    children: bedroomList
                        .map(
                          (e) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                            decoration: BoxDecoration(
                                color: bedrooms == e ? ColorConfig.lightGreen : ColorConfig.light,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3),
                                ),
                                border: Border.all(width: 1, color: ColorConfig.smokeLight)),
                            height: 40,
                            width: 60,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  bedrooms = e;
                                });
                                BlocProvider.of<UpdatePropertyBloc>(context)
                                    .add(SelectedBedroomEvent(bedroom: bedrooms));
                              },
                              child: Center(
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      fontFamily: FontConfig.bold,
                                      fontSize: Sizeconfig.small,
                                      color: bedrooms == e ? ColorConfig.light : ColorConfig.grey),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Icon(
                    FontAwesome.bed,
                    size: Sizeconfig.huge,
                    color: ColorConfig.darkGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Bathrooms",
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
            BlocBuilder<UpdatePropertyBloc, UpdatePropertyState>(
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Wrap(
                    children: bathroomList
                        .map(
                          (e) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                            decoration: BoxDecoration(
                                color: bathrooms == e ? ColorConfig.lightGreen : ColorConfig.light,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3),
                                ),
                                border: Border.all(width: 1, color: ColorConfig.smokeLight)),
                            height: 40,
                            width: 60,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  bathrooms = e;
                                });
                                BlocProvider.of<UpdatePropertyBloc>(context)
                                    .add(SelectedBathroomEvent(bathroom: bathrooms));
                              },
                              child: Center(
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      fontFamily: FontConfig.bold,
                                      fontSize: Sizeconfig.small,
                                      color: bathrooms == e ? ColorConfig.light : ColorConfig.grey),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Icon(
                    Ionicons.ios_call,
                    size: Sizeconfig.huge,
                    color: ColorConfig.darkGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Contact Details",
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

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
                    child: BlocBuilder<UpdatePropertyBloc, UpdatePropertyState>(
                      builder: (context, state) {
                        return Container(
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
                              onChanged: (value) =>
                                  BlocProvider.of<UpdatePropertyBloc>(context).add(AddPhoneEvent(phone: value)),
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Icon(
                    Entypo.image_inverted,
                    size: Sizeconfig.huge,
                    color: ColorConfig.darkGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Property Image",
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
            SizedBox(
              height: 10,
            ),
            BlocBuilder<UpdatePropertyBloc, UpdatePropertyState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
                  child: InkWell(
                    onTap: () {
                      loadAssets();
                    },
                    child: DottedBorder(
                      strokeWidth: 2,
                      color: ColorConfig.greyLight,
                      strokeCap: StrokeCap.butt,
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Image(
                            height: 72,
                            width: 72,
                            image: AssetImage("assets/images/interface.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            images.length > 0 ? buildGridView() : buildCurrentGridView()
          ],
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class Dropdown1 extends StatefulWidget {
  @override
  _Dropdown1State createState() => _Dropdown1State();
}

class _Dropdown1State extends State<Dropdown1> {
  int selected = null;
  List<DropdownMenuItem<int>> listDrop = [];

  void loadData() {
    listDrop = [];
    listDrop.add(new DropdownMenuItem(
      child: Text(
        '254',
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.7),
        ),
      ),
      value: 1,
    ));
    // listDrop.add(new DropdownMenuItem(
    //   child: Text(
    //     '62',
    //     style: TextStyle(
    //       color: Color.fromRGBO(0, 0, 0, 0.7),
    //     ),
    //     // overflow: TextOverflow.ellipsis,
    //   ),
    //   value: 2,
    // ));
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            // itemHeight: 2,
            iconSize: 25,
            elevation: 0,
            value: selected,
            hint: Text(
              '254',
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.7),
              ),
            ),
            items: listDrop,
            onChanged: (value) {
              selected = value;
              setState(() {});
            },
          ),
        ));
  }
}
