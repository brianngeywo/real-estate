import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:uuid/uuid.dart';

import 'package:Realify/backend/bloc/update_property_bloc/update_property_bloc.dart';
import 'package:Realify/backend/models/Property_image.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/member/UpdateProperty/AddBuyTabBar.dart';
import 'package:Realify/presentation/member/UpdateProperty/Counties.dart';
import 'package:Realify/presentation/member/UpdateProperty/UpdateProperty.dart';
import 'package:Realify/presentation/my_imports.dart';

class RentTabBar extends StatefulWidget {
  final RealifyProperty property;
  const RentTabBar({
    Key key,
    @required this.property,
  }) : super(key: key);
  @override
  _RentTabBarState createState() => _RentTabBarState();
}

class _RentTabBarState extends State<RentTabBar> with AutomaticKeepAliveClientMixin {
  TextEditingController locationTextEditingController = TextEditingController();
  TextEditingController detailsTextEditingController = TextEditingController();
  TextEditingController priceTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController();
  TextEditingController areaextEditingController = TextEditingController();
  TextEditingController phoneextEditingController = TextEditingController();
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  List<PropertyImage> urls = <PropertyImage>[];
  PropertyList propertyList;
  PropertyImage propertyImage;
  bool isUploading = false;
  String areaUnit = "";

  @override
  void initState() {
    super.initState();
    selectedPropertyType = widget.property.subCategoryType;
    rentalFrequency = widget.property.paymentPeriod;
    bedrooms = widget.property.bedrooms;
    bathrooms = widget.property.bathrooms;
  }

  String rentalFrequency = "";
  String selectedPropertyType = "";
  String bedrooms = "";
  String bathrooms = "";
  Future<PropertyImage> postImage(Asset imageFile) async {
    String url;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String id = Uuid().v4();
    firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance.ref("$id/$fileName");
    firebase_storage.UploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    uploadTask.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
      print('Task state: ${snapshot.state}');
      print('Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
      // BlocProvider.of<AddPropertyBloc>(context).add(UploadingImagesEvent());
    }, onError: (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      print(uploadTask.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });

    // We can still optionally use the Future alongside the stream.

    await uploadTask;
    print('Upload complete.');
    propertyImage = PropertyImage(url: await (await uploadTask).ref.getDownloadURL());
    return propertyImage;
  }

  Future<PropertyList> uploadFiles(List<Asset> _images) async {
    propertyList = PropertyList(propertyImages: await Future.wait(_images.map((_image) => postImage(_image))));
    print("urls");
    print(propertyList.propertyImages);
    return propertyList;
  }

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

  void loadData() {
    listDrop = [];
    listDrop.add(new DropdownMenuItem(
      child: Text(
        'Square Metres',
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.7),
        ),
      ),
      value: 1,
    ));
    listDrop.add(new DropdownMenuItem(
      child: Text(
        'Square Feet',
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.7),
        ),
        // overflow: TextOverflow.ellipsis,
      ),
      value: 2,
    ));
    listDrop.add(new DropdownMenuItem(
      child: Text(
        'Square Yard',
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.7),
        ),
        // overflow: TextOverflow.ellipsis,
      ),
      value: 3,
    ));
  }

  @override
  Widget build(BuildContext context) {
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
                          color: selectedPropertyType == e.toLowerCase() ? ColorConfig.lightGreen : ColorConfig.light,
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
                            print(e);
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
              child: TextFormField(
                controller: detailsTextEditingController,
                onChanged: (value) {
                  BlocProvider.of<UpdatePropertyBloc>(context).add(AddPropertyTitleEvent(title: value));
                },
                style: TextStyle(
                  fontFamily: FontConfig.regular,
                  fontSize: Sizeconfig.small,
                  color: ColorConfig.dark,
                ),
                decoration: InputDecoration(
                  hintText: widget.property.name,
                  hintStyle: TextStyle(
                    fontFamily: FontConfig.regular,
                    fontSize: Sizeconfig.small,
                    color: ColorConfig.dark,
                  ),
                  border: InputBorder.none,
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(height: 1, width: double.maxFinite, color: ColorConfig.grey.withOpacity(0.3)),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<UpdatePropertyBloc, UpdatePropertyState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: descriptionTextEditingController,
                minLines: 1,
                maxLines: 500,
                onChanged: (value) {
                  BlocProvider.of<UpdatePropertyBloc>(context).add(AddPropertyDescriptionEvent(description: value));
                },
                style: TextStyle(
                  fontFamily: FontConfig.regular,
                  fontSize: Sizeconfig.small,
                  color: ColorConfig.dark,
                ),
                decoration: InputDecoration(
                  hintText: widget.property.description,
                  hintStyle: TextStyle(
                    fontFamily: FontConfig.regular,
                    fontSize: Sizeconfig.small,
                    color: ColorConfig.dark,
                  ),
                  border: InputBorder.none,
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(height: 1, width: double.maxFinite, color: ColorConfig.grey.withOpacity(0.3)),
        ),
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
                MaterialCommunityIcons.av_timer,
                size: Sizeconfig.huge,
                color: ColorConfig.darkGreen,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Payment period",
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
        // Rentaltype(),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<UpdatePropertyBloc, UpdatePropertyState>(
          builder: (context, state) {
            return Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Wrap(
                children: rentalFrequencyList
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            color: rentalFrequency == e ? ColorConfig.lightGreen : ColorConfig.light,
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            ),
                            border: Border.all(width: 1, color: ColorConfig.smokeLight)),
                        height: 40,
                        width: 60,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              rentalFrequency = e;
                            });
                            BlocProvider.of<UpdatePropertyBloc>(context).add(AddRentalFrequencyEvent(frequency: e));
                          },
                          child: Center(
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontFamily: FontConfig.bold,
                                  fontSize: Sizeconfig.small,
                                  color: rentalFrequency == e ? ColorConfig.light : ColorConfig.grey),
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
                          controller: areaextEditingController,
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
                            BlocProvider.of<UpdatePropertyBloc>(context).add(SelectedBedroomEvent(bedroom: bedrooms));
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
        // Bathroomtype(),
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
        // Padding(
        //   padding: EdgeInsets.only(left: 15, right: 15),
        //   child: Row(
        //     children: [
        //       Icon(
        //         FontAwesome5.hashtag,
        //         size: Sizeconfig.huge,
        //         color: ColorConfig.darkGreen,
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8.0),
        //         child: Text(
        //           "Permit Number",
        //           style: TextStyle(
        //             fontFamily: FontConfig.bold,
        //             fontSize: Sizeconfig.medium,
        //             color: ColorConfig.dark,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Padding(
        //   padding: EdgeInsets.only(left: 15, right: 15),
        //   child: TextFormField(
        //     style: TextStyle(
        //       fontFamily: FontConfig.regular,
        //       fontSize: Sizeconfig.small,
        //       color: ColorConfig.dark,
        //     ),
        //     decoration: InputDecoration(
        //       hintText: "e.g 1234",
        //       hintStyle: TextStyle(
        //         fontFamily: FontConfig.regular,
        //         fontSize: Sizeconfig.small,
        //         color: ColorConfig.dark,
        //       ),
        //       border: InputBorder.none,
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 15, right: 15),
        //   child: Container(height: 1, width: double.maxFinite, color: ColorConfig.grey.withOpacity(0.3)),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
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
        // SizedBox(
        //   height: 10,
        // ),
        // Padding(
        //   padding: EdgeInsets.only(left: 15, right: 15),
        //   child: TextFormField(
        //     style: TextStyle(
        //       fontFamily: FontConfig.regular,
        //       fontSize: Sizeconfig.small,
        //       color: ColorConfig.dark,
        //     ),
        //     decoration: InputDecoration(
        //       hintText: "someone@qwer.com",
        //       hintStyle: TextStyle(
        //         fontFamily: FontConfig.regular,
        //         fontSize: Sizeconfig.small,
        //         color: ColorConfig.dark,
        //       ),
        //       border: InputBorder.none,
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 15, right: 15),
        //   child: Container(height: 1, width: double.maxFinite, color: ColorConfig.grey.withOpacity(0.3)),
        // ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConfig.smoke,
                    border: Border.all(
                      width: 1,
                      color: ColorConfig.smokeLight,
                    ),
                  ),
                  child: Dropdown1(),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 2,
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
                          controller: phoneextEditingController,
                          onChanged: (value) =>
                              BlocProvider.of<UpdatePropertyBloc>(context).add(AddPhoneEvent(phone: value)),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: widget.property.phone,
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
        // Padding(
        //   padding: EdgeInsets.only(left: 15, right: 15),
        //   child: Row(
        //     children: [
        //       Icon(
        //         FontAwesome5.list_alt,
        //         size: Sizeconfig.huge,
        //         color: ColorConfig.darkGreen,
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8.0),
        //         child: Text(
        //           "Property Features",
        //           style: TextStyle(
        //             fontFamily: FontConfig.bold,
        //             fontSize: Sizeconfig.medium,
        //             color: ColorConfig.dark,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 15, right: 15),
        //   child: Container(
        //     padding: EdgeInsets.only(
        //       right: 15,
        //       left: 10,
        //     ),
        //     height: 40,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(5),
        //       border: Border.all(
        //         width: 1,
        //         color: ColorConfig.smokeLight,
        //       ),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.only(bottom: 5.0),
        //       child: TextField(
        //         style: TextStyle(
        //           fontFamily: FontConfig.regular,
        //           fontSize: Sizeconfig.small,
        //           color: ColorConfig.dark,
        //         ),
        //         decoration: InputDecoration(
        //           hintText: "abc...",
        //           hintStyle: TextStyle(
        //             fontFamily: FontConfig.regular,
        //             fontSize: Sizeconfig.small,
        //             color: ColorConfig.dark,
        //           ),
        //           border: InputBorder.none,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // BlocConsumer<UpdatePropertyBloc, UpdatePropertyState>(
        //   listener: (context, state) {
        //     if (state is AddedNewFieldState) {
        //       // propertyFeatures.add(state.widget);
        //       setState(() {
        //         featuresListController = state.textEditingController;
        //         textEditingValue = TextEditingValue(text: textEditingValueText + 1.toString());
        //       });
        //     }
        //   },
        //   builder: (context, state) {
        //     if (widget.propertyFields.isNotEmpty) {
        //       // propertyFeatures.add(state.widget);
        //       print(textEditingValue);
        //       return Column(
        //         children: widget.propertyFields.map((feature) {
        //           return Container(
        //             child: feature,
        //           );
        //         }).toList(),
        //       );
        //     } else {
        //       return Column(children: [
        //         propertyFeatureWidget(featuresList, featuresListController),
        //       ]);
        //     }
        //   },
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // BlocBuilder<UpdatePropertyBloc, UpdatePropertyState>(
        //   builder: (context, state) {
        //     return MaterialButton(
        //       onPressed: () {
        //         BlocProvider.of<UpdatePropertyBloc>(context).add(AddNewFieldEvent(
        //             widget: propertyFeatureWidget(featuresList, featuresListController),
        //             propertyFields: propertyFeatures,
        //             textEditingController: featuresListController,
        //             textEditingValue: textEditingValue));
        //       },
        //       color: ColorConfig.lightGreen,
        //       textColor: ColorConfig.light,
        //       child: Text("Add field"),
        //     );
        //   },
        // ),
        // SizedBox(
        //   height: 20,
        // ),
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
        isUploading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : SizedBox(height: 0),
        isUploading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text("Please wait while Updating images..."),
                ),
              )
            : SizedBox(
                height: 0,
              ),
        isUploading
            ? SizedBox(
                height: 5,
              )
            : SizedBox(height: 0),
        BlocConsumer<UpdatePropertyBloc, UpdatePropertyState>(
          listener: (context, state) {
            // if (state is UploadingImagesState) {
            //   setState(() {
            //     isUploading = true;
            //   });
            // }
            if (state is UploadedImagesState) {
              setState(() {
                isUploading = false;
              });
            }
          },
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isUploading = true;
                  });
                  loadAssets().then((value) {
                    if (images.length > 0) {
                      uploadFiles(images).then((value) {
                        BlocProvider.of<UpdatePropertyBloc>(context)
                            .add(UploadingImagesEvent(propertyImagesList: value));
                      });
                    }
                  });
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
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
