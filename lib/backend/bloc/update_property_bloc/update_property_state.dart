part of 'update_property_bloc.dart';

@immutable
abstract class UpdatePropertyState {}

class UpdatePropertyInitial extends UpdatePropertyState {}

class UpdatePropertySelectedCounty extends UpdatePropertyState {
  final String county;
  UpdatePropertySelectedCounty({this.county = ''});
}

class EnteredPriceState extends UpdatePropertyState {
  final String price;
  EnteredPriceState({this.price = ''});
}

class UpdatePropertySelectedProposal extends UpdatePropertyState {
  final int index;
  final String proposal;
  UpdatePropertySelectedProposal({
    this.index = 0,
    this.proposal = '',
  });
}

class UploadPropertyState extends UpdatePropertyState {
  final RealifyProperty property;
  UploadPropertyState({
    @required this.property,
  });
}

class UpdatePropertySelectedPropertyType extends UpdatePropertyState {
  final int index;
  final String categoryTitle;
  UpdatePropertySelectedPropertyType({
    this.index = 0,
    this.categoryTitle = '',
  });
}

class UpdatePropertySelectedPropertySubType extends UpdatePropertyState {
  final int index;
  final String subcategoryTitle;
  UpdatePropertySelectedPropertySubType({
    this.index = 0,
    this.subcategoryTitle = '',
  });
}

class SelectedBathroomState extends UpdatePropertyState {
  final int index;
  final String bathroom;
  SelectedBathroomState({
    this.index = 0,
    this.bathroom = '',
  });
}

class SelectedBedroomState extends UpdatePropertyState {
  final int index;
  final String bedroom;
  SelectedBedroomState({
    this.index = 0,
    this.bedroom = '',
  });
}

class UpdatedLocalityState extends UpdatePropertyState {
  final String location;
  UpdatedLocalityState({
    this.location = '',
  });
}

class UpdatedPropertyTitleState extends UpdatePropertyState {
  final String title;
  UpdatedPropertyTitleState({
    this.title = '',
  });
}

class UpdatePropertyAreaState extends UpdatePropertyState {
  final String areaUnit;
  final String area;
  UpdatePropertyAreaState({
    this.areaUnit = '',
    this.area = '',
  });
}

class UpdateRentalFrequencyState extends UpdatePropertyState {
  final String frequency;
  final int index;
  UpdateRentalFrequencyState({
    @required this.frequency,
    @required this.index,
  });
}

class UpdatedPropertyDescriptionState extends UpdatePropertyState {
  final String description;
  UpdatedPropertyDescriptionState({
    this.description = '',
  });
}

class UpdatedPhoneState extends UpdatePropertyState {
  final String phone;
  UpdatedPhoneState({
    this.phone = '',
  });
}

class UploadedPropertyState extends UpdatePropertyState {}

class StartPropertyUploadState extends UpdatePropertyState {}

class StartPropertyUpdateState extends UpdatePropertyState {}

class UploadedImagesState extends UpdatePropertyState {
  final PropertyList propertyImageList;
  UploadedImagesState({
    @required this.propertyImageList,
  });
}
