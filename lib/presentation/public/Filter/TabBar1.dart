import 'package:Realify/backend/bloc/search_property_bloc/search_property_bloc_bloc.dart';
import 'package:Realify/backend/models/RealifyProperty.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/Filter/Counties.dart';
import 'package:Realify/presentation/public/Filter/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBar1 extends StatefulWidget {
  @override
  _TabBar1State createState() => _TabBar1State();
}

class _TabBar1State extends State<TabBar1> {
  TextEditingController minPriceTextEditingController = TextEditingController();
  TextEditingController maxPriceTextEditingController = TextEditingController();
  String rentalFrequency = "daily";
  String selectedPropertyType = "Apartment";
  String bedrooms = "studio";

  String _selectedLocation;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Icon(
                Entypo.home,
                size: Sizeconfig.huge,
                color: ColorConfig.darkGreen,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Property Types",
                  style: TextStyle(
                    fontFamily: FontConfig.bold,
                    fontSize: Sizeconfig.medium,
                    color: ColorConfig.dark,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        // Propertytype(),
        // SizedBox(
        //   height: 10,
        // ),
        BlocBuilder<SearchPropertyBloc, SearchPropertyState>(
          builder: (context, state) {
            return Wrap(
              direction: Axis.horizontal,
              children: residentialCategoryTypeList
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedPropertyType == e ? ColorConfig.lightGreen : ColorConfig.light,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          border: Border.all(
                            width: 1,
                            color: selectedPropertyType == e ? ColorConfig.lightGreen : ColorConfig.smokeDark,
                          ),
                        ),
                        child: MaterialButton(
                          elevation: 0,
                          onPressed: () {
                            setState(() {
                              selectedPropertyType = e;
                            });
                            BlocProvider.of<SearchPropertyBloc>(context)
                                .add((SelectedSubCategoryEvent(subcategoryTitle: e)));
                          },
                          color: Colors.transparent,
                          textColor: selectedPropertyType == e ? ColorConfig.light : ColorConfig.grey,
                          child: Text(e),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Icon(
                FontAwesome5.city,
                size: Sizeconfig.huge,
                color: ColorConfig.darkGreen,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Select County",
                  style: TextStyle(
                    fontFamily: FontConfig.bold,
                    fontSize: Sizeconfig.medium,
                    color: ColorConfig.dark,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 70,
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: 15,
                    left: 10,
                  ),
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorConfig.smokeLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        MaterialIcons.location_on,
                        size: 20,
                        color: ColorConfig.grey,
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: BlocConsumer<SearchPropertyBloc, SearchPropertyState>(
                          listener: (context, state) {
                            if (state is SearchPropertySelectedCounty) {}
                          },
                          builder: (context, state) {
                            return Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    // itemHeight: 2,
                                    iconSize: 25,
                                    elevation: 0,
                                    value: _selectedLocation,
                                    hint: Text(
                                      _selectedLocation == null ? "Nairobi".toUpperCase() : _selectedLocation,
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.7),
                                      ),
                                    ),
                                    items: countyListDrop.map((e) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          e.title.toUpperCase(),
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.7),
                                          ),
                                        ),
                                        value: e.title,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedLocation = value;
                                      });
                                      BlocProvider.of<SearchPropertyBloc>(context)
                                          .add(SelectedCountyEvent(county: value.toUpperCase()));
                                    },
                                  ),
                                ));
                          },
                        ),
                        // child: TextField(
                        //   style: TextStyle(
                        //     fontFamily: FontConfig.regular,
                        //     fontSize: Sizeconfig.small,
                        //     color: ColorConfig.greyLight,
                        //   ),
                        //   decoration: InputDecoration(
                        //     hintText: "Select location",
                        //     hintStyle: TextStyle(
                        //       fontFamily: FontConfig.regular,
                        //       fontSize: Sizeconfig.small,
                        //       color: ColorConfig.greyLight,
                        //     ),
                        //     border: InputBorder.none,
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Icon(
                Ionicons.ios_pricetag,
                size: Sizeconfig.huge,
                color: ColorConfig.darkGreen,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Price Range",
                  style: TextStyle(
                    fontFamily: FontConfig.bold,
                    fontSize: Sizeconfig.medium,
                    color: ColorConfig.dark,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<SearchPropertyBloc, SearchPropertyState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 40,
                      // width: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          width: 1,
                          color: ColorConfig.smokeDark,
                        ),
                      ),
                      child: TextFormField(
                        controller: minPriceTextEditingController,
                        onChanged: (value) {
                          BlocProvider.of<SearchPropertyBloc>(context).add(EnteredMinPriceEvent(minPrice: value));
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontFamily: FontConfig.regular,
                          color: ColorConfig.dark,
                          fontSize: Sizeconfig.medium,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "From Kshs",
                          hintStyle: TextStyle(
                            fontFamily: FontConfig.regular,
                            color: ColorConfig.dark,
                            fontSize: Sizeconfig.medium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'to',
                    style: TextStyle(
                      fontFamily: FontConfig.regular,
                      fontSize: Sizeconfig.medium,
                      color: ColorConfig.grey,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 40,
                      // width: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          width: 1,
                          color: ColorConfig.smokeDark,
                        ),
                      ),
                      child: TextFormField(
                        controller: maxPriceTextEditingController,
                        onChanged: (value) {
                          BlocProvider.of<SearchPropertyBloc>(context).add(EnteredMaxPriceEvent(maxPrice: value));
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontFamily: FontConfig.regular,
                          color: ColorConfig.dark,
                          fontSize: Sizeconfig.medium,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "To Kshs",
                          hintStyle: TextStyle(
                            fontFamily: FontConfig.regular,
                            color: ColorConfig.dark,
                            fontSize: Sizeconfig.medium,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Icon(
                FontAwesome.bed,
                size: Sizeconfig.huge,
                color: ColorConfig.darkGreen,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Bedrooms",
                  style: TextStyle(
                    fontFamily: FontConfig.bold,
                    fontSize: Sizeconfig.medium,
                    color: ColorConfig.dark,
                  ),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<SearchPropertyBloc, SearchPropertyState>(
          builder: (context, state) {
            return Container(
              // height: 60,
              width: double.infinity,
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Wrap(
                children: bedroomList
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        decoration: BoxDecoration(
                            color: bedrooms == e ? ColorConfig.lightGreen : ColorConfig.light,
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            ),
                            border: Border.all(width: 1, color: ColorConfig.smokeLight)),
                        height: 40,
                        width: 60,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              bedrooms = e;
                            });
                            BlocProvider.of<SearchPropertyBloc>(context).add(SelectedBedroomEvent(bedroom: bedrooms));
                          },
                          child: Center(
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontFamily: FontConfig.bold,
                                  fontSize: Sizeconfig.small,
                                  color: bedrooms == e ? ColorConfig.light : ColorConfig.grey),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
        SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}
