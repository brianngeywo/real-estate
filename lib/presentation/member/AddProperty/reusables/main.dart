import 'package:Realify/presentation/my_imports.dart';

residentialAndCommercialtabBarItems(
    AssetImage image, String itemTitle, TabController _tabController, int itemPosition) {
  return Container(
    decoration: BoxDecoration(
      color: _tabController.index == itemPosition ? ColorConfig.lightGreen : ColorConfig.light,
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    height: 110,
    width: 110,
    child: Tab(
      child: Text(
        itemTitle,
        style: TextStyle(color: _tabController.index == itemPosition ? ColorConfig.lightGreen : ColorConfig.grey),
      ),
      icon: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
          border: Border.all(
            width: 1,
            color: _tabController.index == itemPosition ? ColorConfig.lightGreen : ColorConfig.smokeDark,
          ),
        ),
        height: 70,
        width: 70,
        child: Image(
          image: image,
          color: ColorConfig.dark,
        ),
      ),
    ),
  );
}