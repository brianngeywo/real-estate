import 'package:Realify/backend/models/Property_image.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/backend/services/RealifyPropertyApiProvider.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class RealifyPropertyRepository {
  RealifyPropertyApiProvider realifyPropertyApiProvider = RealifyPropertyApiProvider();
  uploadProperty(proposal, county, category, subCategory, price, bedrooms, locality, propertyName, description,
      rentalFrequency, area, areaUnit, phone, bathrooms, image, imageUrls) async {
    await realifyPropertyApiProvider.uploadProperty(proposal, county, category, subCategory, price, bedrooms, locality,
        propertyName, description, rentalFrequency, area, areaUnit, phone, bathrooms, image, imageUrls);
  }

  updateProperty(proposal, county, category, subCategory, price, bedrooms, locality, propertyName, description,
      rentalFrequency, area, areaUnit, phone, bathrooms, image, imageUrls, propertyId) async {
    await realifyPropertyApiProvider.updateProperty(proposal, county, category, subCategory, price, bedrooms, locality,
        propertyName, description, rentalFrequency, area, areaUnit, phone, bathrooms, image, imageUrls, propertyId);
  }

  sendContactMessage(String name, String phone, String message, BuildContext context) {
    realifyPropertyApiProvider.sendContactMessageAndDetails(name, phone, message, context);
  }

  reportPropertyListing(String typeOfProblem, String name, String phone, String description, BuildContext context,
      RealifyProperty property) {
    realifyPropertyApiProvider.reportPropertyListing(typeOfProblem, name, phone, description, context, property);
  }

  Future<PropertyList> uploadFiles(List<Asset> _images) async {
    PropertyList propertyImagesList = await realifyPropertyApiProvider.uploadFiles(_images);
    return propertyImagesList;
  }
}
