import 'package:Realify/backend/models/AddListingChoiceClass.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/SearchListingChoices/list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchListingChoices extends StatefulWidget {
  static const route = "search_list_choices";

  SearchListingChoices({
    Key key,
  }) : super(key: key);

  @override
  _SearchListingChoicesState createState() => _SearchListingChoicesState();
}

class _SearchListingChoicesState extends State<SearchListingChoices>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.light,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Search Listing".toUpperCase(),
          style: TextStyle(
              fontFamily: FontConfig.bold,
              fontSize: Sizeconfig.medium,
              color: ColorConfig.dark),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: SingleChildScrollView(
                child: Column(
                    children: searchlistingChoicesList.map((element) {
                  return Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, element.nav),
                      child: SearchListingChoicesList(
                          title: element.title, url: element.url),
                    ),
                  );
                }).toList()),
              ),
            ),
            Text(""),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 100,
                child: Row(
                  children: [
                    Card(
                      child: SizedBox(
                        height: 90,
                        width: 250,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              "https://images.unsplash.com/photo-1612253280934-3e0eb5b25251?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1534&q=80",
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        height: 50,
                        width: 250,
                        child: Image.network(
                          "https://images.unsplash.com/photo-1612253280934-3e0eb5b25251?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1534&q=80",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
