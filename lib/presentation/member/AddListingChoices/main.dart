import 'package:Realify/backend/models/AddListingChoiceClass.dart';
import 'package:Realify/presentation/member/AddListingChoices/list.dart';
import 'package:Realify/presentation/my_imports.dart';

class AddListingChoices extends StatefulWidget {
  static const route = 'add_listing_choices';
  AddListingChoices({
    Key key,
  }) : super(key: key);
  @override
  _AddListingChoicesState createState() => _AddListingChoicesState();
}

class _AddListingChoicesState extends State<AddListingChoices> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.light,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Add Listing".toUpperCase(),
          style: TextStyle(fontFamily: FontConfig.bold, fontSize: Sizeconfig.medium, color: ColorConfig.dark),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    children: addlistingChoicesList.map((element) {
                  return Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, element.nav),
                      child: AddListingChoicesList(
                        title: element.title,
                        url: element.url,
                      ),
                    ),
                  );
                }).toList()),
              ),
            ),
            Container(
              height: 55,
              width: double.infinity,
              color: Colors.white,
              child: MaterialButton(
                elevation: 0.0,
                color: ColorConfig.darkGreen,
                onPressed: () {},
                child: Text(
                  "Advertise with us",
                  style: TextStyle(color: ColorConfig.light, fontSize: Sizeconfig.small, fontFamily: FontConfig.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
