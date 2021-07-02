import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'search_property_bloc_event.dart';
part 'search_property_bloc_state.dart';

class SearchPropertyBloc extends Bloc<SearchPropertyEvent, SearchPropertyState> {
  SearchPropertyBloc() : super(SearchPropertyInitial());

  @override
  Stream<SearchPropertyState> mapEventToState(
    SearchPropertyEvent event,
  ) async* {
    if (event is SelectedProposalEvent) {
      yield SearchPropertySelectedProposal(index: event.index, proposal: event.proposal);
    }
    if (event is SelectedCategoryEvent) {
      yield SearchPropertySelectedPropertyType(index: event.index, categoryTitle: event.categoryTitle);
    }
    if (event is SelectedSubCategoryEvent) {
      yield SearchPropertySelectedPropertySubType(index: event.index, subcategoryTitle: event.subcategoryTitle);
    }
    if (event is SelectedCountyEvent) {
      yield SearchPropertySelectedCounty(county: event.county);
    }
    if (event is EnteredMinPriceEvent) {
      yield EnteredMinPriceState(minPrice: event.minPrice);
    }
    if (event is EnteredMaxPriceEvent) {
      yield EnteredMaxPriceState(maxPrice: event.maxPrice);
    }
    if (event is SelectedBedroomEvent) {
      yield SelectedBedroomState(bedroom: event.bedroom, index: event.index);
    }
    if (event is AddRentalFrequencyEvent) {
      yield AddRentalFrequencyState(frequency: event.frequency.toLowerCase());
    }
  }
}
