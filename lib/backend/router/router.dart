import 'package:Realify/presentation/member/AddListingChoices/main.dart';
import 'package:Realify/presentation/member/AddProperty/AddHotelListing.dart';
import 'package:Realify/presentation/member/AddProperty/AddRentalListing.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/AdevrtiseWithUsPage/main.dart';
import 'package:Realify/presentation/public/Filter/SearchHotel.dart';
import 'package:Realify/presentation/public/Filter/SearchRental.dart';
import 'package:Realify/presentation/public/SearchListingChoices/main.dart';
import 'package:page_transition/page_transition.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case addRentalNav:
      return PageTransition(
        child: AddRentalListing(),
        duration: Duration(milliseconds: 400),
        type: PageTransitionType.rightToLeftWithFade,
      );
    case addHotelNav:
      return MaterialPageRoute(builder: (_) => AddHotelListing());
    case searchRentalNav:
      return PageTransition(
        child: SearchRental(),
        duration: Duration(milliseconds: 400),
        type: PageTransitionType.rightToLeftWithFade,
      );
    case searchHotelNav:
      return PageTransition(
        child: SearchHotel(),
        duration: Duration(milliseconds: 400),
        type: PageTransitionType.rightToLeftWithFade,
      );
    case searchNav:
      return PageTransition(
        child: SearchListingChoices(),
        duration: Duration(milliseconds: 400),
        type: PageTransitionType.topToBottom,
      );
    case addListingNav:
      return PageTransition(
        child: AddListingChoices(),
        duration: Duration(milliseconds: 400),
        type: PageTransitionType.topToBottom,
      );
    case myHomepage:
      return MaterialPageRoute(builder: (_) => HomePage());
    case advertiseWithUsNav:
      return MaterialPageRoute(builder: (_) => AdvertiseWithUsPage());
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
const String addListingNav = AddListingChoices.route;
const String advertiseWithUsNav = AdvertiseWithUsPage.route;
