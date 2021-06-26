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
  final String bedroom;
  SelectedBedroomEvent({
    this.bedroom = '',
  });
}

class SelectedCategoryEvent extends SearchPropertyEvent {
  final int index;
  final String category;
  SelectedCategoryEvent({
    this.index = 0,
    this.category = '',
  });
}

class SelectedSubCategoryEvent extends SearchPropertyEvent {
    final int index;
  final String category;
  final String subCategory;
  SelectedSubCategoryEvent({
    this.index = 0,
    this.category = '',
    this.subCategory = '',
  });
}
