import 'package:Realify/backend/models/Property_image.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Realify/backend/bloc/add_property_bloc/add_property_bloc.dart';
import 'package:Realify/presentation/member/AddProperty/AddBuyTabBar.dart';
import 'package:Realify/presentation/member/AddProperty/Counties.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class RentTabBar extends StatefulWidget {
  // List propertyFields;
  RentTabBar({
    Key key,
    // @required this.propertyFields = const [],
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
  }

  String rentalFrequency = "daily";
  String selectedPropertyType = "Apartment";
  String bedrooms = "studio";
  String bathrooms = "0";
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

  List<County> countyListDrop = [
    County(title: "mombasa", countyCode: 1),
    County(title: "Kwale", countyCode: 2),
    County(title: "Kilifi", countyCode: 3),
    County(title: "Tana River", countyCode: 4),
    County(title: "Lamu", countyCode: 5),
    County(title: "Taita Taveta", countyCode: 6),
    County(title: "Garissa", countyCode: 7),
    County(title: "Wajir", countyCode: 8),
    County(title: "Mandera", countyCode: 9),
    County(title: "Marsabit", countyCode: 10),
    County(title: "Isiolo", countyCode: 11),
    County(title: "Meru", countyCode: 12),
    County(title: "Tharaka-Nithi", countyCode: 13),
    County(title: "Embu", countyCode: 14),
    County(title: "Kitui", countyCode: 15),
    County(title: "Machakos", countyCode: 16),
    County(title: "Makueni", countyCode: 17),
    County(title: "Nyandarua", countyCode: 18),
    County(title: "Nyeri", countyCode: 19),
    County(title: "Kirinyaga", countyCode: 20),
    County(title: "Murang'a", countyCode: 21),
    County(title: "Kiambu", countyCode: 22),
    County(title: "Turkana", countyCode: 23),
    County(title: "West Pokot", countyCode: 24),
    County(title: "Samburu", countyCode: 25),
    County(title: "Trans Nzoia", countyCode: 26),
    County(title: "Uasin Gishu", countyCode: 27),
    County(title: "Elgeyo Marakwet", countyCode: 28),
    County(title: "Nandi", countyCode: 29),
    County(title: "Baringo", countyCode: 30),
    County(title: "Laikipia", countyCode: 31),
    County(title: "Nakuru", countyCode: 32),
    County(title: "Narok", countyCode: 33),
    County(title: "Kajiado", countyCode: 34),
    County(title: "Kericho", countyCode: 35),
    County(title: "Bomet", countyCode: 36),
    County(title: "Kakamega", countyCode: 37),
    County(title: "Vihiga", countyCode: 38),
    County(title: "Bungoma", countyCode: 39),
    County(title: "Busia", countyCode: 40),
    County(title: "Siaya", countyCode: 41),
    County(title: "Kisumu", countyCode: 42),
    County(title: "Homa Bay", countyCode: 43),
    County(title: "Migori", countyCode: 44),
    County(title: "Kisii", countyCode: 45),
    County(title: "Nyamira", countyCode: 46),
    County(title: "Nairobi", countyCode: 47),
  ];
  String _selectedLocation;
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
        BlocBuilder<AddPropertyBloc, AddPropertyState>(
          builder: (context, state) {
            return Wrap(
              direction: Axis.horizontal,
              children: residentialCategoryTypeList
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedPropertyType == e ? ColorConfig.lightGreen : ColorConfig.light,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          border: Border.all(
                            width: 1,
                            color: selectedPropertyType == e ? ColorConfig.lightGreen : ColorConfig.smokeDark,
                          ),
                        ),
                        child: MaterialButton(
                          elevation: 0,
                          onPressed: () {
                            print(e);
                            setState(() {
                              selectedPropertyType = e;
                            });
                            BlocProvider.of<AddPropertyBloc>(context)
                                .add((SelectedSubCategoryEvent(subcategoryTitle: e)));
                          },
                          color: Colors.transparent,
                          textColor: selectedPropertyType == e ? ColorConfig.light : ColorConfig.grey,
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
                FontAwesome5.city,
                size: Sizeconfig.huge,
                color: ColorConfig.darkGreen,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Select county",
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
        Container(
          height: 70,
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: 15,
                    left: 10,
                  ),
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorConfig.smokeLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        MaterialIcons.location_on,
                        size: 20,
                        color: ColorConfig.grey,
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: BlocConsumer<AddPropertyBloc, AddPropertyState>(
                          listener: (context, state) {
                            if (state is AddPropertySelectedCounty) {}
                          },
                          builder: (context, state) {
                            return Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    // itemHeight: 2,
                                    iconSize: 25,
                                    elevation: 0,
                                    value: _selectedLocation,
                                    hint: Text(
                                      _selectedLocation == null ? "Nairobi".toUpperCase() : _selectedLocation,
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.7),
                                      ),
                                    ),
                                    items: countyListDrop.map((e) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          e.title.toUpperCase(),
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.7),
                                          ),
                                        ),
                                        value: e.title,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedLocation = value;
                                      });
                                      BlocProvider.of<AddPropertyBloc>(context)
                                          .add(SelectedCountyEvent(county: value.toUpperCase()));
                                    },
                                  ),
                                ));
                          },
                        ),
                        // child: TextField(
                        //   style: TextStyle(
                        //     fontFamily: FontConfig.regular,
                        //     fontSize: Sizeconfig.small,
                        //     color: ColorConfig.greyLight,
                        //   ),
                        //   decoration: InputDecoration(
                        //     hintText: "Select location",
                        //     hintStyle: TextStyle(
                        //       fontFamily: FontConfig.regular,
                        //       fontSize: Sizeconfig.small,
                        //       color: ColorConfig.greyLight,
                        //     ),
                        //     border: InputBorder.none,
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Icon(
                FontAwesome5.city,
                size: Sizeconfig.huge,
                color: ColorConfig.darkGreen,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Enter area name and town",
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
        BlocBuilder<AddPropertyBloc, AddPropertyState>(
          builder: (context, state) {
            return Container(
              height: 70,
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        right: 15,
                        left: 10,
                      ),
                      height: 40,
                      decoration: BoxDecoration(
                        color: ColorConfig.smokeLight,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            MaterialIcons.location_on,
                            size: 20,
                            color: ColorConfig.grey,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: TextField(
                                controller: locationTextEditingController,
                                onChanged: (value) {
                                  BlocProvider.of<AddPropertyBloc>(context).add(AddLocalityEvent(location: value));
                                },
                                style: TextStyle(
                                  fontFamily: FontConfig.regular,
                                  fontSize: Sizeconfig.small,
                                  color: ColorConfig.greyLight,
                                ),
                                decoration: InputDecoration(
                                  hintText: ".e.g area, town",
                                  hintStyle: TextStyle(
                                    fontFamily: FontConfig.regular,
                                    fontSize: Sizeconfig.small,
                                    color: ColorConfig.greyLight,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
        BlocBuilder<AddPropertyBloc, AddPropertyState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: detailsTextEditingController,
                onChanged: (value) {
                  BlocProvider.of<AddPropertyBloc>(context).add(AddPropertyTitleEvent(title: value));
                },
                style: TextStyle(
                  fontFamily: FontConfig.regular,
                  fontSize: Sizeconfig.small,
                  color: ColorConfig.dark,
                ),
                decoration: InputDecoration(
                  hintText: "property title",
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
        BlocBuilder<AddPropertyBloc, AddPropertyState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: descriptionTextEditingController,
                minLines: 1,
                maxLines: 500,
                onChanged: (value) {
                  BlocProvider.of<AddPropertyBloc>(context).add(AddPropertyDescriptionEvent(description: value));
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
        BlocBuilder<AddPropertyBloc, AddPropertyState>(
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
                      BlocProvider.of<AddPropertyBloc>(context).add(EnteredPriceEvent(price: value));
                    },
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontFamily: FontConfig.regular,
                      fontSize: Sizeconfig.small,
                      color: ColorConfig.dark,
                    ),
                    decoration: InputDecoration(
                      hintText: "Price*",
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
        BlocBuilder<AddPropertyBloc, AddPropertyState>(
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
                            BlocProvider.of<AddPropertyBloc>(context).add(AddRentalFrequencyEvent(frequency: e));
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
        BlocBuilder<AddPropertyBloc, AddPropertyState>(
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
                            BlocProvider.of<AddPropertyBloc>(context).add(
                                AddPropertyAreaEvent(area: value, areaUnit: areaUnit.isEmpty ? 'Sq.M.' : areaUnit));
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontFamily: FontConfig.regular,
                            fontSize: Sizeconfig.small,
                            color: ColorConfig.dark,
                          ),
                          decoration: InputDecoration(
                            hintText: "area*",
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
                      child: BlocConsumer<AddPropertyBloc, AddPropertyState>(
                        listener: (context, state) {
                          if (state is AddPropertyAreaState) {}
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
                                          BlocProvider.of<AddPropertyBloc>(context)
                                              .add(AddPropertyAreaEvent(areaUnit: 'Sq.M.'));
                                          break;
                                        case 2:
                                          BlocProvider.of<AddPropertyBloc>(context)
                                              .add(AddPropertyAreaEvent(areaUnit: 'Sq.Ft.'));
                                          break;
                                        case 3:
                                          BlocProvider.of<AddPropertyBloc>(context)
                                              .add(AddPropertyAreaEvent(areaUnit: 'Sq.Yd'));
                                          break;
                                        default:
                                          BlocProvider.of<AddPropertyBloc>(context)
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
        BlocBuilder<AddPropertyBloc, AddPropertyState>(
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
                            BlocProvider.of<AddPropertyBloc>(context).add(SelectedBedroomEvent(bedroom: bedrooms));
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
        BlocBuilder<AddPropertyBloc, AddPropertyState>(
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
                            BlocProvider.of<AddPropertyBloc>(context).add(SelectedBathroomEvent(bathroom: bathrooms));
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
                child: BlocBuilder<AddPropertyBloc, AddPropertyState>(
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
                              BlocProvider.of<AddPropertyBloc>(context).add(AddPhoneEvent(phone: value)),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "798767470",
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
        // BlocConsumer<AddPropertyBloc, AddPropertyState>(
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
        // BlocBuilder<AddPropertyBloc, AddPropertyState>(
        //   builder: (context, state) {
        //     return MaterialButton(
        //       onPressed: () {
        //         BlocProvider.of<AddPropertyBloc>(context).add(AddNewFieldEvent(
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
        if (isUploading == true)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        if (isUploading == true)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text("Please wait while Saving images..."),
            ),
          ),
        if (isUploading == true)
          SizedBox(
            height: 5,
          ),
        BlocConsumer<AddPropertyBloc, AddPropertyState>(
          listener: (context, state) {
            if (state is UploadingImagesState) {
              setState(() {
                isUploading = true;
              });
            }
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
                onTap: () => loadAssets().then((value) {
                    if (images.length > 0 && images.length != null) {
                    setState(() {
                      isUploading = true;
                    });
                    uploadFiles(images).then((value) {
                      BlocProvider.of<AddPropertyBloc>(context).add(UploadingImagesEvent(propertyImagesList: value));
                    });
                  }
                }),
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
        images.length > 0 && images.length != null
            ? buildGridView()
            : Container(
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "no images selected",
                    style: TextStyle(
                      fontSize: Sizeconfig.medium,
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
