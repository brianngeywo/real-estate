import 'package:Realify/presentation/member/AddProperty/AddHotelListing.dart';
import 'package:Realify/presentation/member/AddProperty/AddRentalListing.dart';
import 'package:Realify/presentation/my_imports.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case addRentalNav:
      return MaterialPageRoute(builder: (_) => AddRentalListing());
    case addHotelNav:
      return MaterialPageRoute(builder: (_) => AddHotelListing());
    case myHomepage:
      return MaterialPageRoute(builder: (_) => HomePage());
    // case addListingNav:
    //   return MaterialPageRoute(builder: (_) => AddListing());
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(child: Text('No route defined for ${settings.name}')),
              ));
  }
}

//Dynamic Routes for generating navigation
const String addRentalNav = AddRentalListing.id;
// const String addListingNav = AddListing.id;
const String addHotelNav = AddHotelListing.id;
const String myHomepage = HomePage.route;
