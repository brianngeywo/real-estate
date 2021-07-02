part of 'add_property_bloc.dart';

@immutable
abstract class AddPropertyState {}

class AddPropertyInitial extends AddPropertyState {}

class AddPropertySelectedCounty extends AddPropertyState {
  final String county;
  AddPropertySelectedCounty({this.county = ''});
}

class EnteredPriceState extends AddPropertyState {
  final String price;
  EnteredPriceState({this.price = ''});
}

class AddPropertySelectedProposal extends AddPropertyState {
  final int index;
  final String proposal;
  AddPropertySelectedProposal({
    this.index = 0,
    this.proposal = '',
  });
}

class UploadPropertyState extends AddPropertyState {
  final RealifyProperty property;
  UploadPropertyState({
    @required this.property,
  });
}

class AddPropertySelectedPropertyType extends AddPropertyState {
  final int index;
  final String categoryTitle;
  AddPropertySelectedPropertyType({
    this.index = 0,
    this.categoryTitle = '',
  });
}

class AddPropertySelectedPropertySubType extends AddPropertyState {
  final int index;
  final String subcategoryTitle;
  AddPropertySelectedPropertySubType({
    this.index = 0,
    this.subcategoryTitle = '',
  });
}

class SelectedBathroomState extends AddPropertyState {
  final int index;
  final String bathroom;
  SelectedBathroomState({
    this.index = 0,
    this.bathroom = '',
  });
}

class SelectedBedroomState extends AddPropertyState {
  final int index;
  final String bedroom;
  SelectedBedroomState({
    this.index = 0,
    this.bedroom = '',
  });
}

class AddedLocalityState extends AddPropertyState {
  final String location;
  AddedLocalityState({
    this.location = '',
  });
}

class AddedPropertyTitleState extends AddPropertyState {
  final String title;
  AddedPropertyTitleState({
    this.title = '',
  });
}

class AddPropertyAreaState extends AddPropertyState {
  final String areaUnit;
  final String area;
  AddPropertyAreaState({
    this.areaUnit = '',
    this.area = '',
  });
}

class AddRentalFrequencyState extends AddPropertyState {
  final String frequency;
  AddRentalFrequencyState({
    this.frequency = '',
  });
}

class AddedPropertyDescriptionState extends AddPropertyState {
  final String description;
  AddedPropertyDescriptionState({
    this.description = '',
  });
}

class AddedPhoneState extends AddPropertyState {
  final String phone;
  AddedPhoneState({
    this.phone = '',
  });
}

class AddPropertyFeaturesState extends AddPropertyState {
  final String value;
  AddPropertyFeaturesState({
    this.value = '',
  });
}

class AddedNewFieldState extends AddPropertyState {
  final TextEditingController textEditingController;
  final List propertyFields;
  AddedNewFieldState({
    // @required this.propertyFeatures,
    @required this.textEditingController,
    this.propertyFields,
  });
}

class UploadedPropertyState extends AddPropertyState {}

class AddedImagesState extends AddPropertyState {}

class UploadedImagesState extends AddPropertyState {
  final PropertyList propertyList;
  UploadedImagesState({
    @required this.propertyList,
  });
}


class UploadingImagesState extends AddPropertyState {
  final double progress;
  UploadingImagesState({
    this.progress = 0.0,
  });
}
