import 'dart:async';

import 'package:Realify/backend/models/Property_image.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/backend/models/places.dart';
import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

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
      yield UpdateRentalFrequencyState(frequency: event.frequency.toLowerCase(), index: event.index);
    }
    if (event is AddPropertyAreaEvent) {
      yield UpdatePropertyAreaState(area: event.area, areaUnit: event.areaUnit);
    }
    if (event is AddPhoneEvent) {
      yield UpdatedPhoneState(phone: event.phone);
    }
    if (event is StartPropertyUploadEvent) {
      yield StartPropertyUploadState();
    }
    if (event is StartPropertyUpdateEvent) {
      yield StartPropertyUpdateState();
    }

    if (event is SelectedBedroomsPricesEvent) {
      yield SelectedBedroomsPricesState(prices: event.prices);
    }
    if (event is SelectedBedroomEvent) {
      yield SelectedBedroomState(bedroom: event.bedroom, index: event.index);
    }
    if (event is UpdatePlaceDetailsEvent) {
      yield UpdatePlaceDetailsState(place: event.place);
    }
    if (event is UploadImagesEvent) {
      yield* _mapUploadImagesToState(event);
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
        event.propertyId,
        event.bedroomsOffered,
        event.bedroomsOfferedPrice,
      );
      yield UploadedPropertyState();
    }
  }
}

Stream<UpdatePropertyState> _mapUploadImagesToState(UploadImagesEvent event) async* {
  RealifyPropertyRepository repository = RealifyPropertyRepository();
  PropertyList propertyImagesList = await repository.uploadFiles(event.propertyImagesList);
  yield UploadedImagesState(propertyImageList: propertyImagesList);
}
