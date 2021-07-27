import 'package:Realify/presentation/my_imports.dart';

class AddListingChoicesList extends StatefulWidget {
  AddListingChoicesList({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);
  final String title;
  final String url;
  @override
  State<AddListingChoicesList> createState() => _AddListingChoicesListState();
}

class _AddListingChoicesListState extends State<AddListingChoicesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConfig.grey.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Image(
              fit: BoxFit.cover,
              height: 100,
              width: double.infinity,
              image: NetworkImage(
                widget.url,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 100,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
                backgroundBlendMode: BlendMode.darken,
                color: ColorConfig.grey.withOpacity(0.5),
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
