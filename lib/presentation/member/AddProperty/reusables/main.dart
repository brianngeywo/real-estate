import 'dart:io';

import 'package:Realify/backend/bloc/add_property_bloc/add_property_bloc.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/Filter/reusables/main.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

residentialAndCommercialtabBarItems(
    AssetImage image, String itemTitle, TabController _tabController, int itemPosition) {
  return Container(
    decoration: BoxDecoration(
      color: _tabController.index == itemPosition ? ColorConfig.lightGreen : ColorConfig.light,
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    height: 110,
    width: 110,
    child: Tab(
      child: Text(
        itemTitle,
        style: TextStyle(color: _tabController.index == itemPosition ? ColorConfig.lightGreen : ColorConfig.grey),
      ),
      icon: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
          border: Border.all(
            width: 1,
            color: _tabController.index == itemPosition ? ColorConfig.lightGreen : ColorConfig.smokeDark,
          ),
        ),
        height: 70,
        width: 70,
        child: Image(
          image: image,
          color: ColorConfig.dark,
        ),
      ),
    ),
  );
}

List propertyInputs = [];
Widget propertyFeatureWidget(List inputs, TextEditingController controller) {
  return BlocBuilder<AddPropertyBloc, AddPropertyState>(
    builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: Container(
          padding: EdgeInsets.only(
            right: 15,
            left: 10,
          ),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
              color: ColorConfig.smokeLight,
            ),
          ),
          child: TextField(
            controller: controller,
            onSubmitted: (value) {
              inputs.add(controller.text);
              BlocProvider.of<AddPropertyBloc>(context).add(AddPropertyFeaturesEvent(value: controller.text));
            },
            style: TextStyle(
              fontFamily: FontConfig.regular,
              fontSize: Sizeconfig.small,
              color: ColorConfig.dark,
            ),
            decoration: InputDecoration(
              hintText: "new field...",
              hintStyle: TextStyle(
                fontFamily: FontConfig.regular,
                fontSize: Sizeconfig.small,
                color: ColorConfig.dark,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      );
    },
  );
}

List propertyFeatures = [];

convertListToMap(proposal, county, category, subCategory, price, bedrooms, locality, propertyName, description,
    rentalFrequency, area, areaUnit, phone, bathrooms, image, imageUrls, BuildContext context) {
  String message = "";
  RealifyPropertyRepository repository = RealifyPropertyRepository();
  // // Map map = list.asMap();
  // var map = Map<String, String>.fromIterable(list);
  // RealifyProperty property = RealifyProperty.fromMap(map);
  // print(map);
  // print(property);
  try {
    repository.uploadProperty(proposal, county, category, subCategory, price, bedrooms, locality, propertyName,
        description, rentalFrequency, area, areaUnit, phone, bathrooms, image, imageUrls);
    message = "property uploaded successfully!";
  } catch (e) {
    message = "there was a problem when uploading property";
  }

  showSnackbar(message, context);
}

// TODO: bedrooms tabbar

class Bedroomtype extends StatefulWidget {
  @override
  _BedroomtypeState createState() => _BedroomtypeState();
}

class _BedroomtypeState extends State<Bedroomtype> with TickerProviderStateMixin {
  TabController _tabController;
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 10);
    _tabController.addListener(_handleTabSelection);
    _tabController.index = 0;
    title = "studio";
  }

  void _handleTabSelection() {
    setState(() {});
  }

  String title = "";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPropertyBloc, AddPropertyState>(
      listener: (context, state) {
        if (state is SelectedBedroomState) {}
      },
      builder: (context, state) {
        return Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: TabBar(
            isScrollable: true,
            controller: _tabController,
            onTap: (index) {
              switch (index) {
                case 0:
                  setState(() {
                    title = "studio";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBedroomEvent(index: index, bedroom: title)));
                  break;
                case 1:
                  setState(() {
                    title = "bedsitter";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBedroomEvent(index: index, bedroom: title)));
                  break;
                case 2:
                  setState(() {
                    title = "2";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBedroomEvent(index: index, bedroom: title)));
                  break;
                case 3:
                  setState(() {
                    title = "2";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBedroomEvent(index: index, bedroom: title)));
                  break;
                case 4:
                  setState(() {
                    title = "3";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBedroomEvent(index: index, bedroom: title)));
                  break;
                case 5:
                  setState(() {
                    title = "4";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBedroomEvent(index: index, bedroom: title)));
                  break;
                case 6:
                  setState(() {
                    title = "5";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBedroomEvent(index: index, bedroom: title)));

                  break;
                case 7:
                  setState(() {
                    title = "6";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBedroomEvent(index: index, bedroom: title)));
                  break;
                case 8:
                  setState(() {
                    title = "7";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBedroomEvent(index: index, bedroom: title)));
                  break;
                case 9:
                  setState(() {
                    title = "8+";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBedroomEvent(index: index, bedroom: title)));
                  break;
                default:
                  setState(() {
                    title = "studio";
                  });
              }
            },
            tabs: [
              bedroomTabBarItems("studio", _tabController, 0),
              bedroomTabBarItems("bedsitter", _tabController, 1),
              bedroomTabBarItems("1", _tabController, 2),
              bedroomTabBarItems("2", _tabController, 3),
              bedroomTabBarItems("3", _tabController, 4),
              bedroomTabBarItems("4", _tabController, 5),
              bedroomTabBarItems("5", _tabController, 6),
              bedroomTabBarItems("6", _tabController, 7),
              bedroomTabBarItems("7", _tabController, 8),
              bedroomTabBarItems("8+", _tabController, 9),
            ],
          ),
        );
      },
    );
  }
}

// TODO: bath tabbar

class Bathroomtype extends StatefulWidget {
  @override
  _BathroomtypeState createState() => _BathroomtypeState();
}

class _BathroomtypeState extends State<Bathroomtype> with TickerProviderStateMixin {
  TabController _tabController;
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 10);
    _tabController.addListener(_handleTabSelection);
    _tabController.index = 0;
    title = "0";
  }

  void _handleTabSelection() {
    setState(() {});
  }

  String title = "";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPropertyBloc, AddPropertyState>(
      listener: (context, state) {
        if (state is SelectedBedroomState) {}
      },
      builder: (context, state) {
        return Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: TabBar(
            isScrollable: true,
            controller: _tabController,
            onTap: (index) {
              switch (index) {
                case 0:
                  setState(() {
                    title = "0";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBathroomEvent(index: index, bathroom: title)));
                  break;
                case 1:
                  setState(() {
                    title = "1";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBathroomEvent(index: index, bathroom: title)));
                  break;
                case 2:
                  setState(() {
                    title = "2";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBathroomEvent(index: index, bathroom: title)));
                  break;
                case 3:
                  setState(() {
                    title = "3";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBathroomEvent(index: index, bathroom: title)));
                  break;
                case 4:
                  setState(() {
                    title = "4";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBathroomEvent(index: index, bathroom: title)));
                  break;
                case 5:
                  setState(() {
                    title = "5";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBathroomEvent(index: index, bathroom: title)));
                  break;
                case 6:
                  setState(() {
                    title = "6";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBathroomEvent(index: index, bathroom: title)));

                  break;
                case 7:
                  setState(() {
                    title = "7";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBathroomEvent(index: index, bathroom: title)));
                  break;
                case 8:
                  setState(() {
                    title = "8";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBathroomEvent(index: index, bathroom: title)));
                  break;
                case 9:
                  setState(() {
                    title = "9+";
                  });
                  BlocProvider.of<AddPropertyBloc>(context).add((SelectedBathroomEvent(index: index, bathroom: title)));
                  break;
                default:
                  setState(() {
                    title = "0";
                  });
              }
            },
            tabs: [
              bedroomTabBarItems("0", _tabController, 0),
              bedroomTabBarItems("1", _tabController, 1),
              bedroomTabBarItems("2", _tabController, 2),
              bedroomTabBarItems("3", _tabController, 3),
              bedroomTabBarItems("4", _tabController, 4),
              bedroomTabBarItems("5", _tabController, 5),
              bedroomTabBarItems("6", _tabController, 6),
              bedroomTabBarItems("7", _tabController, 7),
              bedroomTabBarItems("8", _tabController, 8),
              bedroomTabBarItems("9+", _tabController, 9),
            ],
          ),
        );
      },
    );
  }
}

class SelectImagesPage extends StatefulWidget {
  @override
  _SelectImagesPageState createState() => _SelectImagesPageState();
}

class _SelectImagesPageState extends State<SelectImagesPage> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  List<String> imageUrls = <String>[];
  List<String> urls = <String>[];
  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String id = Uuid().v4();
    Reference reference = FirebaseStorage.instance.ref().child("$id/$fileName");
    UploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    String imagesurl = await (await uploadTask).ref.getDownloadURL();
    return imagesurl;
  }

  Widget buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 2,
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

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#008080",
          actionBarTitle: "Select Images",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: InkWell(
        onTap: loadAssets,
        child: Container(
          height: 50,
          color: ColorConfig.lightGreen,
          width: double.infinity,
          child: Center(
              child: Text(
            "Click to Pick images",
            style: TextStyle(color: ColorConfig.light, fontSize: Sizeconfig.medium),
          )),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<AddPropertyBloc, AddPropertyState>(
          builder: (context, state) {
            return Column(
              children: <Widget>[
                // Center(child: Text('Error: ')),
                SizedBox(height: 10),
                if (images.length > 0)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 160,
                      height: 40,
                      child: MaterialButton(
                        onPressed: () {
                          for (var imageFile in images) {
                            
                            setState(() {
                              postImage(imageFile).then((value) => imageUrls.add(value));
                              urls = imageUrls;
                            });
                            print(urls);
                            BlocProvider.of<AddPropertyBloc>(context).add(UploadImagesEvent(images: urls));
                          }
                          Navigator.of(context).pop();
                        },
                        color: ColorConfig.lightGreen,
                        textColor: ColorConfig.light,
                        child: Row(
                          children: [
                            Icon(Icons.upload),
                            SizedBox(width: 5),
                            Text("upload images"),
                          ],
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 10),

                if (images.length <= 0)
                  Align(
                    alignment: Alignment(0, 0),
                    child: Text("No images selected",
                        style: TextStyle(
                          fontSize: Sizeconfig.large,
                          color: ColorConfig.darkGreen,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                Flexible(
                  child: buildGridView(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
