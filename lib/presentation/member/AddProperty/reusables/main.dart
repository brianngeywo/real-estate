import 'package:Realify/backend/bloc/add_property_bloc/add_property_bloc.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
import 'package:Realify/presentation/my_imports.dart';
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
    rentalFrequency, area, areaUnit, phone, BuildContext context) {
  String message = "";
  RealifyPropertyRepository repository = RealifyPropertyRepository();
  // // Map map = list.asMap();
  // var map = Map<String, String>.fromIterable(list);
  // RealifyProperty property = RealifyProperty.fromMap(map);
  // print(map);
  // print(property);
  try {
    repository.uploadProperty(
      proposal,
      county,
      category,
      subCategory,
      price,
      bedrooms,
      locality,
      propertyName,
      description,
      rentalFrequency,
      area,
      areaUnit,
      phone,
    );
    message = "property uploaded successfully!";
  } catch (e) {
    message = "there was a problem when uploading property";
  }

  showSnackbar(message, context);
}
