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
  final String category;
  SearchPropertySelectedProposal({this.category = ''});
}

class SearchPropertySelectedPropetyType extends SearchPropertyState {
    final int index;

  final String subCategory;
  SearchPropertySelectedPropetyType({this.index = 0, this.subCategory = ''});
}

class SelectedBedroomState extends SearchPropertyState {
  final String bedroom;
  SelectedBedroomState({this.bedroom = ''});
}
