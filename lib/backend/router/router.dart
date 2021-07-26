import 'package:Realify/presentation/my_imports.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case addRentalNav:
    //   return MaterialPageRoute(builder: (_) => AddRental());
    // case addHotelNav:
    //   return MaterialPageRoute(builder: (_) => AddHotel());
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
// const String addRentalNav = AddRental.id;
// const String addListingNav = AddListing.id;
// const String addHotelNav = AddHotel.id;
const String myHomepage = HomePage.route;
