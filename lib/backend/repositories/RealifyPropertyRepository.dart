import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/backend/services/RealifyPropertyApiProvider.dart';
import 'package:Realify/presentation/my_imports.dart';

class RealifyPropertyRepository {
  RealifyPropertyApiProvider realifyPropertyApiProvider = RealifyPropertyApiProvider();
  uploadProperty(
    proposal,
    county,
    category,
    subCategory,
    price,
    bedrooms,
    locality,
    propertyName,
    description,
    rentalFrequency,
    area,
    areaUnit,
    phone,
    bathrooms,
  ) {
    realifyPropertyApiProvider.uploadProperty(
      proposal,
      county,
      category,
      subCategory,
      price,
      bedrooms,
      locality,
      propertyName,
      description,
      rentalFrequency,
      area,
      areaUnit,
      phone,
      bathrooms,
    );
    // return 200;
  }
  sendContactMessage(String name, String phone, String message, BuildContext context) {
    realifyPropertyApiProvider.sendContactMessageAndDetails(name, phone, message, context);
  }

  reportPropertyListing(String typeOfProblem, String name, String phone, String description, BuildContext context,
      RealifyProperty property) {
    realifyPropertyApiProvider.reportPropertyListing(typeOfProblem, name, phone, description, context, property);
  }
}
