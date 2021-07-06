import 'dart:async';

import 'package:Realify/backend/models/Property_image.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'update_property_event.dart';
part 'update_property_state.dart';

class UpdatePropertyBloc extends Bloc<UpdatePropertyEvent, UpdatePropertyState> {
  UpdatePropertyBloc() : super(UpdatePropertyInitial());
    RealifyPropertyRepository repository = RealifyPropertyRepository();
  TextEditingController controller = TextEditingController();
  List<String> imageUrls = <String>[];

  @override
  Stream<UpdatePropertyState> mapEventToState(
    UpdatePropertyEvent event,
  ) async* {
    if (event is SelectedProposalEvent) {
      yield UpdatePropertySelectedProposal(index: event.index, proposal: event.proposal);
    }
    if (event is SelectedCategoryEvent) {
      yield UpdatePropertySelectedPropertyType(index: event.index, categoryTitle: event.categoryTitle);
    }
    if (event is SelectedSubCategoryEvent) {
      yield UpdatePropertySelectedPropertySubType(subcategoryTitle: event.subcategoryTitle);
    }
    if (event is SelectedCountyEvent) {
      yield UpdatePropertySelectedCounty(county: event.county);
    }
    if (event is EnteredPriceEvent) {
      yield EnteredPriceState(price: event.price);
    }
    if (event is SelectedBathroomEvent) {
      yield SelectedBathroomState(bathroom: event.bathroom, index: event.index);
    }
    if (event is SelectedBedroomEvent) {
      yield SelectedBedroomState(bedroom: event.bedroom, index: event.index);
    }
    if (event is AddLocalityEvent) {
      yield UpdatedLocalityState(location: event.location);
    }
    if (event is AddPropertyTitleEvent) {
      yield UpdatedPropertyTitleState(title: event.title);
    }
    if (event is AddPropertyDescriptionEvent) {
      yield UpdatedPropertyDescriptionState(description: event.description);
    }
    if (event is AddRentalFrequencyEvent) {
      yield UpdateRentalFrequencyState(frequency: event.frequency.toLowerCase(),index: event.index);
    }
    if (event is AddPropertyAreaEvent) {
      yield UpdatePropertyAreaState(area: event.area, areaUnit: event.areaUnit);
    }
    if (event is AddPhoneEvent) {
      yield UpdatedPhoneState(phone: event.phone);
    }
    if (event is AddPropertyFeaturesEvent) {
      yield UpdatePropertyFeaturesState(value: event.value);
    }
    if (event is UploadingImagesEvent) {
      yield* _mapUploadingImagesToState(event);
    }
    if (event is UploadImagesEvent) {
      yield* _mapUploadedImagesToState(event);
    }
    if (event is UploadPropertyEvent) {
      repository.updateProperty(
          event.proposal,
          event.county,
          event.category,
          event.subCategory,
          event.price,
          event.bedrooms,
          event.locality,
          event.propertyName,
          event.description,
          event.rentalFrequency,
          event.area,
          event.areaUnit,
          event.phone,
          event.bathrooms,
          event.image,
          event.images,
          event.propertyId);
      yield UploadedPropertyState();
    }
  }
  }
Stream<UpdatePropertyState> _mapUploadedImagesToState(UploadImagesEvent event) async* {
  print("property bloc image list");
  print(event.propertyImagesList.propertyImages);
  yield UploadedImagesState(propertyImageList: event.propertyImagesList);
}

Stream<UpdatePropertyState> _mapUploadingImagesToState(UploadingImagesEvent event) async* {
  yield UploadingImagesState(propertyImageList: event.propertyImagesList);
}

