import 'package:Realify/presentation/member/AddProperty/AddHotelListing.dart';
import 'package:Realify/presentation/member/AddProperty/AddRentalListing.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/Filter/SearchHotel.dart';
import 'package:Realify/presentation/public/Filter/SearchRental.dart';
import 'package:Realify/presentation/public/SearchListingChoices/main.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case addRentalNav:
      return MaterialPageRoute(builder: (_) => AddRentalListing());
    case addHotelNav:
      return MaterialPageRoute(builder: (_) => AddHotelListing());
    case searchRentalNav:
      return MaterialPageRoute(builder: (_) => SearchRental());
    case searchHotelNav:
      return MaterialPageRoute(builder: (_) => SearchHotel());
    case searchNav:
      return MaterialPageRoute(builder: (_) => SearchListingChoices());
    case myHomepage:
      return MaterialPageRoute(builder: (_) => HomePage());
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(child: Text('No route defined for ${settings.name}')),
              ));
  }
}

//Dynamic Routes for generating navigation
const String addRentalNav = AddRentalListing.id;
const String searchRentalNav = SearchRental.id;
const String addHotelNav = AddHotelListing.id;
const String searchHotelNav = SearchHotel.id;
const String myHomepage = HomePage.route;
const String searchNav = SearchListingChoices.route;
