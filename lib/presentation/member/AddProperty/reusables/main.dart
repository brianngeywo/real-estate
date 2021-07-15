import 'package:Realify/backend/bloc/add_property_bloc/add_property_bloc.dart';
import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/Filter/reusables/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    title = "1";
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
  }

  void _handleTabSelection() {
    setState(() {});
  }

  String title = "";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPropertyBloc, AddPropertyState>(
      listener: (context, state) {
        if (state is SelectedBathroomState) {}
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
