import 'package:Realify/presentation/my_imports.dart';

class SearchListingChoicesList extends StatefulWidget {
  SearchListingChoicesList({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);
  final String title;
  final String url;
  @override
  State<SearchListingChoicesList> createState() => _SearchListingChoicesListState();
}

class _SearchListingChoicesListState extends State<SearchListingChoicesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConfig.grey.withOpacity(0.4),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
              color: ColorConfig.lightGreen,
              image: DecorationImage(image: AssetImage("assets/images/interface.png"))
            ),
            child: Image(
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
              image: NetworkImage(
                widget.url,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 120,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
                backgroundBlendMode: BlendMode.darken,
                color: ColorConfig.grey.withOpacity(0.35),
              ),
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: FontConfig.bold,
                    fontSize: Sizeconfig.higantic,
                    color: ColorConfig.light,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
