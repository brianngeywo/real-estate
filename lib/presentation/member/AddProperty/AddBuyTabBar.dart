import 'package:Realify/backend/models/Property_image.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/backend/models/places.dart';
import 'package:Realify/backend/models/realify_user.dart';
import 'package:Realify/backend/repositories/auth_repository.dart';
import 'package:Realify/backend/services/place_service.dart';
import 'package:Realify/presentation/member/AddProperty/address_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Realify/backend/bloc/add_property_bloc/add_property_bloc.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class BuyTabBar extends StatefulWidget {
  // List propertyFields;
  BuyTabBar({
    Key key,
    // @required this.propertyFields = const [],
  }) : super(key: key);
  @override
  _BuyTabBarState createState() => _BuyTabBarState();
}

class _BuyTabBarState extends State<BuyTabBar> {
  TextEditingController locationTextEditingController = TextEditingController();
  TextEditingController detailsTextEditingController = TextEditingController();
  TextEditingController priceTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController();
  TextEditingController areaTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  final _controller = TextEditingController();
  String route = "";
  String locality = "";
  String county = "";
  String country = "";
  String formattedAddress = "";
  double lat = 0;
  double lng = 0;
  AuthRepository authRepository = AuthRepository();
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  List<PropertyImage> urls = <PropertyImage>[];
 Place placeDetails = Place();
  String areaUnit = "sq.m.";
  String selectedPropertyType = "Hotel";
  String bedrooms = "studio";
  String bathrooms = "1";
  RealifyUser user = RealifyUser();
  final requiredValidator = RequiredValidator(errorText: 'this field is required');
  final _formKey = GlobalKey<FormState>();
  List _apartmentBedrooms;
  List<String> prices = [];
  getUser() {
    authRepository.getUser().then((value) => {
          setState(() {
            user = value;
            phoneTextEditingController.text = value.phone;
            BlocProvider.of<AddPropertyBloc>(context).add(AddPhoneEvent(phone: value.phone));
          })
        });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    _apartmentBedrooms = [];
    BlocProvider.of<AddPropertyBloc>(context).add(AddRentalFrequencyEvent(frequency: rentalFrequency));
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

  String rentalFrequency = "daily";
  String _selectedLocation;
  int selected = null;
  List<DropdownMenuItem<int>> listDrop = [];
  Map<int, TextEditingController> _mapControllers = Map();
  TextEditingController _controllerOf(int index) {
    var item = _mapControllers[index];
    if (item == null) {
      item = TextEditingController();
      _mapControllers[index] = item;
    }
    return item;
  }

  List<String> _textsOf(Map<int, TextEditingController> mapControllers) {
    // Sort map by index of the builder.
    var sortedKeys = mapControllers.keys.toList()..sort();

    List<String> texts = [];
    for (var key in sortedKeys) {
      texts.add(mapControllers[key].text);
    }
    print(texts);
    BlocProvider.of<AddPropertyBloc>(context).add(SelectedBedroomsPricesEvent(prices: texts));
    setState(() {
      prices = [];
      prices.addAll(texts);
    });
    return texts;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPropertyBloc, AddPropertyState>(
      listener: (context, state) {
        if (state is StartPropertyUploadState) {
          if (descriptionTextEditingController.text.isNotEmpty &&
              phoneTextEditingController.text.isNotEmpty &&
              _apartmentBedrooms != null &&
              _apartmentBedrooms.length > 0 &&
              prices != null &&
              prices.length > 0) {
            if (images != null && images.length > 0) {
              BlocProvider.of<AddPropertyBloc>(context).add(UploadImagesEvent(propertyImagesList: images));
            } else {
              showSnackbar("please select Images", context);
              BlocProvider.of<AddPropertyBloc>(context).add(AddPropertyInitialEvent());
              Navigator.of(context).pop();
            }
          } else {
            showSnackbar("please enter details before submitting", context);
            BlocProvider.of<AddPropertyBloc>(context).add(AddPropertyInitialEvent());
            Navigator.of(context).pop();
          }
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
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
              SizedBox(
                height: 10,
              ),
              BlocBuilder<AddPropertyBloc, AddPropertyState>(
                builder: (context, state) {
                  return Wrap(
                    direction: Axis.horizontal,
                    children: lodgingsList
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
                        "Enter area name or town",
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
                    height: 60,
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                                    padding: const EdgeInsets.only(bottom: 5.0, left: 5.0),
                                    child: TextField(
                                      controller: _controller,
                                      style: TextStyle(
                                        fontFamily: FontConfig.regular,
                                        fontSize: Sizeconfig.small,
                                        color: ColorConfig.dark,
                                      ),
                                      readOnly: true,
                                      onTap: () async {
                                        // generate a new token here
                                        final Suggestion result = await showSearch(
                                          context: context,
                                          delegate: AddressSearch(),
                                        );
                                        // This will change the text displayed in the TextField
                                        if (result != null) {
                                          placeDetails = await PlaceApiProvider().getPlaceDetailFromId(result.placeId);
                                          setState(() {
                                            _controller.text = result.description;
                                            route = placeDetails.route;
                                            locality = placeDetails.locality;
                                            county = placeDetails.administrativeAreaLevel1;
                                            country = placeDetails.country;
                                            formattedAddress = placeDetails.formattedAddress;
                                            lat = placeDetails.lat;
                                            lng = placeDetails.lng;
                                          });
                                          placeDetails != null
                                              ? BlocProvider.of<AddPropertyBloc>(context)
                                                  .add(AddPlaceDetailsEvent(place: placeDetails))
                                              : null;
                                        }
                                      },
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
              BlocBuilder<AddPropertyBloc, AddPropertyState>(
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
                              BlocProvider.of<AddPropertyBloc>(context).add(AddPropertyTitleEvent(title: value)),
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
              BlocBuilder<AddPropertyBloc, AddPropertyState>(
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
                          validator: requiredValidator,
                          controller: descriptionTextEditingController,
                          minLines: 20,
                          maxLines: 500,
                          onChanged: (value) {
                            BlocProvider.of<AddPropertyBloc>(context)
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
                                controller: areaTextEditingController,
                                onChanged: (value) {
                                  BlocProvider.of<AddPropertyBloc>(context).add(AddPropertyAreaEvent(
                                      area: value, areaUnit: areaUnit.isEmpty ? 'Sq.M.' : areaUnit));
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
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
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
              SizedBox(
                height: 10,
              ),
              BlocBuilder<AddPropertyBloc, AddPropertyState>(
                builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: MultiSelectFormField(
                      autovalidate: false,
                      fillColor: ColorConfig.smokeLight,
                      chipBackGroundColor: ColorConfig.lightGreen,
                      chipLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: ColorConfig.light),
                      dialogTextStyle: TextStyle(fontFamily: FontConfig.regular, fontSize: Sizeconfig.medium),
                      checkBoxActiveColor: ColorConfig.lightGreen,
                      checkBoxCheckColor: ColorConfig.light,
                      dialogShapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      title: Text(
                        "Choose bedrooms offered at the property",
                        style: TextStyle(fontFamily: FontConfig.regular, fontSize: Sizeconfig.large),
                      ),
                      dataSource: [
                        {
                          "display": "studio",
                          "value": "studio",
                        },
                        {
                          "display": "bedsitter",
                          "value": "bedsitter",
                        },
                        {
                          "display": "1 bedroom",
                          "value": "1",
                        },
                        {
                          "display": "2 bedroom",
                          "value": "2",
                        },
                        {
                          "display": "3 bedroom",
                          "value": "3",
                        },
                        {
                          "display": "4 bedroom",
                          "value": "4",
                        },
                        {
                          "display": "5 bedroom",
                          "value": "5",
                        },
                        {
                          "display": "6+ bedroom",
                          "value": "6+",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                      okButtonLabel: 'OK',
                      cancelButtonLabel: 'CANCEL',
                      hintWidget: Text('Please choose one or more'),
                      initialValue: _apartmentBedrooms,
                      onSaved: (value) {
                        if (value == null) return;
                        setState(() {
                          _apartmentBedrooms = value;
                        });
                        if (_apartmentBedrooms.length > 0) {
                          BlocProvider.of<AddPropertyBloc>(context).add(SelectedBedroomsOfferedEvent(bedrooms: value));
                        }
                        print(_apartmentBedrooms);
                      },
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
                                  BlocProvider.of<AddPropertyBloc>(context)
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
              _apartmentBedrooms.length > 0
                  ? Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _apartmentBedrooms.length,
                        itemBuilder: (context, index) {
                          return BlocBuilder<AddPropertyBloc, AddPropertyState>(
                            builder: (context, state) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                                child: Container(
                                  padding: EdgeInsets.only(right: 15, left: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: ColorConfig.smokeLight,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: TextFormField(
                                      validator: requiredValidator,
                                      controller: _controllerOf(index),
                                      onChanged: (value) {
                                        // BlocProvider.of<AddPropertyBloc>(context).add(EnteredPriceEvent(price: value));
                                        // prices.add(_controllerOf(index).text);
                                        // print(prices);
                                        _formKey.currentState.save();
                                        _textsOf(_mapControllers);
                                      },
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        fontFamily: FontConfig.regular,
                                        fontSize: Sizeconfig.small,
                                        color: ColorConfig.dark,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: _apartmentBedrooms[index].toString() + " bedroom Price*",
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
                          );
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: Text("Please choose bedrooms offered first!",
                          style: TextStyle(fontFamily: FontConfig.regular)),
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
                                validator: requiredValidator,
                                controller: phoneTextEditingController,
                                onChanged: (value) =>
                                    BlocProvider.of<AddPropertyBloc>(context).add(AddPhoneEvent(phone: value)),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: user.phone.isNotEmpty ? user.phone : "0798767470",
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

              BlocBuilder<AddPropertyBloc, AddPropertyState>(
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
                    child: InkWell(
                      onTap: () => loadAssets(),
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
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
