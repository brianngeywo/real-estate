import 'package:Realify/backend/models/AddListingChoiceClass.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/SearchListingChoices/list.dart';

class SearchListingChoices extends StatefulWidget {
  static const route = "search_list_choices";
  SearchListingChoices({
    Key key,
  }) : super(key: key);
  @override
  _SearchListingChoicesState createState() => _SearchListingChoicesState();
}

class _SearchListingChoicesState extends State<SearchListingChoices> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.light,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Search Listing".toUpperCase(),
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
                    children: searchlistingChoicesList.map((element) {
                  return Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Container(
                      color: ColorConfig.lightGreen,
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(context, element.nav),
                        child: SearchListingChoicesList(title: element.title, url: element.url),
                      ),
                    ),
                  );
                }).toList()),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
