part of 'search_property_bloc_bloc.dart';

@immutable
abstract class SearchPropertyEvent {}

class SelectedCountyEvent extends SearchPropertyEvent {
  final String county;
  SelectedCountyEvent({
    this.county = '',
  });
}

class EnteredMinPriceEvent extends SearchPropertyEvent {
  final String minPrice;
  EnteredMinPriceEvent({
    this.minPrice = '',
  });
}

class EnteredMaxPriceEvent extends SearchPropertyEvent {
  final String maxPrice;
  EnteredMaxPriceEvent({
    this.maxPrice = '',
  });
}

class SelectedBedroomEvent extends SearchPropertyEvent {
  final int index;
  final String bedroom;
  SelectedBedroomEvent({
    this.index = 0,
    this.bedroom = "",
  });
}

class SelectedProposalEvent extends SearchPropertyEvent {
  final int index;
  final String proposal;
  SelectedProposalEvent({
    this.index = 0,
    this.proposal = '',
  });
}

class SelectedCategoryEvent extends SearchPropertyEvent {
  final int index;
  final String categoryTitle;
  SelectedCategoryEvent({
    this.index = 0,
    this.categoryTitle = '',
  });
}

class SelectedSubCategoryEvent extends SearchPropertyEvent {
  final int index;
  final String subcategoryTitle;
  SelectedSubCategoryEvent({
    this.index = 0,
    this.subcategoryTitle = "",
  });
}

class AddRentalFrequencyEvent extends SearchPropertyEvent {
  final String frequency;
  final int index;
  AddRentalFrequencyEvent({
    @required this.frequency,
    @required this.index,
  });
}
