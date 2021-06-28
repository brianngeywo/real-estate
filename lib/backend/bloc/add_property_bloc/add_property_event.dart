part of 'add_property_bloc.dart';

@immutable
abstract class AddPropertyEvent {}

class SelectedCountyEvent extends AddPropertyEvent {
  final String county;
  SelectedCountyEvent({
    this.county = '',
  });
}

class EnteredPriceEvent extends AddPropertyEvent {
  final String price;
  EnteredPriceEvent({
    this.price = '',
  });
}

class SelectedBedroomEvent extends AddPropertyEvent {
  final int index;
  final String bedroom;
  SelectedBedroomEvent({
    this.index = 0,
    this.bedroom = "",
  });
}


class SelectedBathroomEvent extends AddPropertyEvent {
  final int index;
  final String bathroom;
  SelectedBathroomEvent({
    this.index = 0,
    this.bathroom = "",
  });
}
class SelectedProposalEvent extends AddPropertyEvent {
  final int index;
  final String proposal;
  SelectedProposalEvent({
    this.index = 0,
    this.proposal = '',
  });
}

class SelectedCategoryEvent extends AddPropertyEvent {
  final int index;
  final String categoryTitle;
  SelectedCategoryEvent({
    this.index = 0,
    this.categoryTitle = '',
  });
}

class SelectedSubCategoryEvent extends AddPropertyEvent {
  final int index;
  final String subcategoryTitle;
  SelectedSubCategoryEvent({
    this.index = 0,
    this.subcategoryTitle = "",
  });
}

class AddLocalityEvent extends AddPropertyEvent {
  final String location;
  AddLocalityEvent({
    this.location = '',
  });
}

class AddPropertyTitleEvent extends AddPropertyEvent {
  final String title;
  AddPropertyTitleEvent({
    this.title = '',
  });
}

class AddPropertyDescriptionEvent extends AddPropertyEvent {
  final String description;
  AddPropertyDescriptionEvent({
    this.description = '',
  });
}

class AddRentalFrequencyEvent extends AddPropertyEvent {
  final String frequency;
  AddRentalFrequencyEvent({
    this.frequency = '',
  });
}

class AddPropertyAreaEvent extends AddPropertyEvent {
  final String areaUnit;
  final String area;
  AddPropertyAreaEvent({
    this.areaUnit = '',
    this.area = '',
  });
}

class AddPhoneEvent extends AddPropertyEvent {
  final String phone;
  AddPhoneEvent({
    this.phone = '',
  });
}

class AddPropertyFeaturesEvent extends AddPropertyEvent {
  final String value;
  AddPropertyFeaturesEvent({
    this.value = '',
  });
}

class AddNewFieldEvent extends AddPropertyEvent {
  final TextEditingValue textEditingValue;
  final TextEditingController textEditingController;
  final List propertyFields;
  final Widget widget;
  AddNewFieldEvent({
    @required this.widget,
    @required this.textEditingController,
    @required this.textEditingValue,
    this.propertyFields = const [],
  });
}

class UploadPropertyEvent extends AddPropertyEvent {
    final String proposal;
  final String county;
  final String category;
  final String subCategory;
  final String price;
  final String bathrooms;
  final String bedrooms;
  final String locality;
  final String propertyName;
  final String description;
  final String rentalFrequency;
  final String area;
  final String areaUnit;
  final String phone;
  UploadPropertyEvent({
    @required this.proposal,
    @required this.county,
    @required this.category,
    @required this.subCategory,
    @required this.price,
    @required this.bathrooms,
    @required this.bedrooms,
    @required this.locality,
    @required this.propertyName,
    @required this.description,
    @required this.rentalFrequency,
    @required this.area,
    @required this.areaUnit,
    @required this.phone,
  });
}
