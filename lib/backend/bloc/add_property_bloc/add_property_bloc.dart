import 'dart:async';

import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_property_event.dart';
part 'add_property_state.dart';

class AddPropertyBloc extends Bloc<AddPropertyEvent, AddPropertyState> {
  AddPropertyBloc() : super(AddPropertyInitial());
  RealifyPropertyRepository repository = RealifyPropertyRepository();
  TextEditingController controller = TextEditingController();
  @override
  Stream<AddPropertyState> mapEventToState(
    AddPropertyEvent event,
  ) async* {
    if (event is SelectedProposalEvent) {
      yield AddPropertySelectedProposal(index: event.index, proposal: event.proposal);
    }
    if (event is SelectedCategoryEvent) {
      yield AddPropertySelectedPropertyType(index: event.index, categoryTitle: event.categoryTitle);
    }
    if (event is SelectedSubCategoryEvent) {
      yield AddPropertySelectedPropertySubType(index: event.index, subcategoryTitle: event.subcategoryTitle);
    }
    if (event is SelectedCountyEvent) {
      yield AddPropertySelectedCounty(county: event.county);
    }
    if (event is EnteredPriceEvent) {
      yield EnteredPriceState(price: event.price);
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
      yield AddRentalFrequencyState(frequency: event.frequency);
    }
    if (event is AddPropertyAreaEvent) {
      yield AddPropertyAreaState(area: event.area, areaUnit: event.areaUnit);
    }
    if (event is AddPhoneEvent) {
      yield AddedPhoneState(phone: event.phone);
    }
    if (event is AddPropertyFeaturesEvent) {
      yield AddPropertyFeaturesState(value: event.value);
    }
    if (event is AddNewFieldEvent) {
      event.propertyFields.add(event.widget);
      controller.value = TextEditingValue(text: event.textEditingController.text);
      yield AddedNewFieldState(
        propertyFields: event.propertyFields,
        textEditingController: TextEditingController.fromValue(controller.value),
      );
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
          event.phone);
      yield UploadedPropertyState();
    }
  }
}
