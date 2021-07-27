import 'dart:async';

import 'package:Realify/backend/models/Property_image.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/backend/models/places.dart';
import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

part 'add_property_event.dart';
part 'add_property_state.dart';

class AddPropertyBloc extends Bloc<AddPropertyEvent, AddPropertyState> {
  AddPropertyBloc() : super(AddPropertyInitial());
  RealifyPropertyRepository repository = RealifyPropertyRepository();
  TextEditingController controller = TextEditingController();
  List<String> imageUrls = <String>[];
  @override
  Stream<AddPropertyState> mapEventToState(
    AddPropertyEvent event,
  ) async* {
    if (event is AddPropertyInitialEvent) {
      yield AddPropertyInitial();
    }
    if (event is SelectedProposalEvent) {
      yield AddPropertySelectedProposal(index: event.index, proposal: event.proposal);
    }
    if (event is SelectedCategoryEvent) {
      yield AddPropertySelectedPropertyType(index: event.index, categoryTitle: event.categoryTitle);
    }
    if (event is SelectedSubCategoryEvent) {
      yield AddPropertySelectedPropertySubType(subcategoryTitle: event.subcategoryTitle);
    }
    if (event is SelectedCountyEvent) {
      yield AddPropertySelectedCounty(county: event.county);
    }
    if (event is EnteredPriceEvent) {
      yield EnteredPriceState(price: event.price);
    }
    if (event is SelectedBathroomEvent) {
      yield SelectedBathroomState(bathroom: event.bathroom, index: event.index);
    }
    if (event is SelectedBedroomsOfferedEvent) {
      yield SelectedBedroomsOfferedState(bedrooms: event.bedrooms);
    }
    if (event is SelectedBedroomsPricesEvent) {
      yield SelectedBedroomsPricesState(prices: event.prices);
    }
    if (event is SelectedBedroomEvent) {
      yield SelectedBedroomState(bedroom: event.bedroom, index: event.index);
    }
    if (event is AddLocalityEvent) {
      yield AddedLocalityState(location: event.location);
    }
    if (event is AddPropertyTitleEvent) {
      yield AddedPropertyTitleState(title: event.title);
    }
    if (event is AddPropertyDescriptionEvent) {
      yield AddedPropertyDescriptionState(description: event.description);
    }
    if (event is AddRentalFrequencyEvent) {
      yield AddRentalFrequencyState(frequency: event.frequency.toLowerCase(), index: event.index);
    }
    if (event is AddPropertyAreaEvent) {
      yield AddPropertyAreaState(area: event.area, areaUnit: event.areaUnit);
    }
    if (event is AddPhoneEvent) {
      yield AddedPhoneState(phone: event.phone);
    }
    if (event is StartPropertyUploadEvent) {
      yield StartPropertyUploadState();
    }
    if (event is UploadImagesEvent) {
      yield* _mapUploadImagesToState(event);
    }
    if (event is AddPlaceDetailsEvent) {
      yield AddPlaceDetailsState(place: event.place);
    }
    if (event is UploadPropertyEvent) {
      repository.uploadProperty(
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
          event.bedroomsOffered,
          event.bedroomsOfferedPrice,
          event.place);
      yield UploadedPropertyState();
    }
      if (event is UploadHotelEvent) {
      repository.uploadHotel(
          event.county,
          event.subCategory,
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
          event.bedroomsOffered,
          event.bedroomsOfferedPrice,
          event.place);
      yield UploadedPropertyState();
    }
  }
}

Stream<AddPropertyState> _mapUploadImagesToState(UploadImagesEvent event) async* {
  RealifyPropertyRepository repository = RealifyPropertyRepository();
  PropertyList propertyImagesList = await repository.uploadFiles(event.propertyImagesList);
  yield UploadedImagesState(propertyImageList: propertyImagesList);
}
