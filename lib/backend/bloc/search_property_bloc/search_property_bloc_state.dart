part of 'search_property_bloc_bloc.dart';

@immutable
abstract class SearchPropertyState {}

class SearchPropertyInitial extends SearchPropertyState {}

class SearchPropertySelectedCounty extends SearchPropertyState {
  final String county;
  SearchPropertySelectedCounty({this.county = ''});
}

class EnteredMinPriceState extends SearchPropertyState {
  final String minPrice;
  EnteredMinPriceState({this.minPrice = ''});
}

class EnteredMaxPriceState extends SearchPropertyState {
  final String maxPrice;
  EnteredMaxPriceState({this.maxPrice = ''});
}

class SearchPropertySelectedProposal extends SearchPropertyState {
  final int index;
  final String proposal;
  SearchPropertySelectedProposal({
    this.index = 0,
    this.proposal = '',
  });
}

class SearchPropertySelectedPropertyType extends SearchPropertyState {
  final int index;
  final String categoryTitle;
  SearchPropertySelectedPropertyType({
    this.index = 0,
    this.categoryTitle = '',
  });
}

class SearchPropertySelectedPropertySubType extends SearchPropertyState {
  final int index;
  final String subcategoryTitle;
  SearchPropertySelectedPropertySubType({
    this.index = 0,
    this.subcategoryTitle = '',
  });
}

class SelectedBedroomState extends SearchPropertyState {
  final int index;
  final String bedroom;
  SelectedBedroomState({
    this.index = 0,
    this.bedroom = '',
  });
}

class AddRentalFrequencyState extends SearchPropertyState {
  final String frequency;
  final int index;
  AddRentalFrequencyState({
   @required this.frequency,
   @required this.index,
  });
}
