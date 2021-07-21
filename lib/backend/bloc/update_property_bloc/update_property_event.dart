part of 'update_property_bloc.dart';

@immutable
abstract class UpdatePropertyEvent {}

class SelectedCountyEvent extends UpdatePropertyEvent {
  final String county;
  SelectedCountyEvent({
    this.county = '',
  });
}

class EnteredPriceEvent extends UpdatePropertyEvent {
  final String price;
  EnteredPriceEvent({
    this.price = '',
  });
}

class SelectedBedroomEvent extends UpdatePropertyEvent {
  final int index;
  final String bedroom;
  SelectedBedroomEvent({
    this.index = 0,
    this.bedroom = "",
  });
}

class SelectedBathroomEvent extends UpdatePropertyEvent {
  final int index;
  final String bathroom;
  SelectedBathroomEvent({
    this.index = 0,
    this.bathroom = "",
  });
}

class SelectedProposalEvent extends UpdatePropertyEvent {
  final int index;
  final String proposal;
  SelectedProposalEvent({
    this.index = 0,
    this.proposal = '',
  });
}

class SelectedCategoryEvent extends UpdatePropertyEvent {
  final int index;
  final String categoryTitle;
  SelectedCategoryEvent({
    this.index = 0,
    this.categoryTitle = '',
  });
}

class SelectedSubCategoryEvent extends UpdatePropertyEvent {
  final int index;
  final String subcategoryTitle;
  SelectedSubCategoryEvent({
    this.index = 0,
    this.subcategoryTitle = "",
  });
}

class AddLocalityEvent extends UpdatePropertyEvent {
  final String location;
  AddLocalityEvent({
    this.location = '',
  });
}

class AddPropertyTitleEvent extends UpdatePropertyEvent {
  final String title;
  AddPropertyTitleEvent({
    this.title = '',
  });
}

class AddPropertyDescriptionEvent extends UpdatePropertyEvent {
  final String description;
  AddPropertyDescriptionEvent({
    this.description = '',
  });
}

class AddRentalFrequencyEvent extends UpdatePropertyEvent {
  final String frequency;
  final int index;
  AddRentalFrequencyEvent({
    @required this.frequency,
    this.index = 0,
  });
}

class AddPropertyAreaEvent extends UpdatePropertyEvent {
  final String areaUnit;
  final String area;
  AddPropertyAreaEvent({
    this.areaUnit = '',
    this.area = '',
  });
}

class AddPhoneEvent extends UpdatePropertyEvent {
  final String phone;
  AddPhoneEvent({
    this.phone = '',
  });
}


class UploadImagesEvent extends UpdatePropertyEvent {
  final List<Asset> propertyImagesList;
  UploadImagesEvent({
    @required this.propertyImagesList,
  });
}
class UpdatePlaceDetailsEvent extends UpdatePropertyEvent {
  final Place place;
  UpdatePlaceDetailsEvent({
    @required this.place,
  });
}

class SelectedBedroomsOfferedEvent extends UpdatePropertyEvent {
  final List<dynamic> bedrooms;
  SelectedBedroomsOfferedEvent({
    @required this.bedrooms,
  });
}

class SelectedBedroomsPricesEvent extends UpdatePropertyEvent {
  final List<String> prices;
  SelectedBedroomsPricesEvent({
    @required this.prices,
  });
}

class StartPropertyUploadEvent extends UpdatePropertyEvent {}

class StartPropertyUpdateEvent extends UpdatePropertyEvent {}

class UploadPropertyEvent extends UpdatePropertyEvent {
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
  final String image;
  final String propertyId;
  final List<String> images;
    final List<dynamic> bedroomsOffered;
  final List<dynamic> bedroomsOfferedPrice;
  UploadPropertyEvent({
    @required this.propertyId,
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
    @required this.image,
    @required this.images,
    @required this.bedroomsOffered,
    @required this.bedroomsOfferedPrice,
  });
}
