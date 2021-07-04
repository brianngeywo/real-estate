import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Realify/backend/bloc/search_property_bloc/search_property_bloc_bloc.dart';

class CountiesCodes extends StatefulWidget {
  @override
  _CountiesCodesState createState() => _CountiesCodesState();
}

class _CountiesCodesState extends State<CountiesCodes> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchPropertyBloc>(context).add(SelectedCountyEvent(county: 'Nairobi'.toUpperCase()));
  }

  int selected = null;
  List<County> listDrop = [
    County(title: "mombasa", countyCode: 1),
    County(title: "Kwale", countyCode: 2),
    County(title: "Kilifi", countyCode: 3),
    County(title: "Tana River", countyCode: 4),
    County(title: "Lamu", countyCode: 5),
    County(title: "Taita Taveta", countyCode: 6),
    County(title: "Garissa", countyCode: 7),
    County(title: "Wajir", countyCode: 8),
    County(title: "Mandera", countyCode: 9),
    County(title: "Marsabit", countyCode: 10),
    County(title: "Isiolo", countyCode: 11),
    County(title: "Meru", countyCode: 12),
    County(title: "Tharaka-Nithi", countyCode: 13),
    County(title: "Embu", countyCode: 14),
    County(title: "Kitui", countyCode: 15),
    County(title: "Machakos", countyCode: 16),
    County(title: "Makueni", countyCode: 17),
    County(title: "Nyandarua", countyCode: 18),
    County(title: "Nyeri", countyCode: 19),
    County(title: "Kirinyaga", countyCode: 20),
    County(title: "Murang'a", countyCode: 21),
    County(title: "Kiambu", countyCode: 22),
    County(title: "Turkana", countyCode: 23),
    County(title: "West Pokot", countyCode: 24),
    County(title: "Samburu", countyCode: 25),
    County(title: "Trans Nzoia", countyCode: 26),
    County(title: "Uasin Gishu", countyCode: 27),
    County(title: "Elgeyo Marakwet", countyCode: 28),
    County(title: "Nandi", countyCode: 29),
    County(title: "Baringo", countyCode: 30),
    County(title: "Laikipia", countyCode: 31),
    County(title: "Nakuru", countyCode: 32),
    County(title: "Narok", countyCode: 33),
    County(title: "Kajiado", countyCode: 34),
    County(title: "Kericho", countyCode: 35),
    County(title: "Bomet", countyCode: 36),
    County(title: "Kakamega", countyCode: 37),
    County(title: "Vihiga", countyCode: 38),
    County(title: "Bungoma", countyCode: 39),
    County(title: "Busia", countyCode: 40),
    County(title: "Siaya", countyCode: 41),
    County(title: "Kisumu", countyCode: 42),
    County(title: "Homa Bay", countyCode: 43),
    County(title: "Migori", countyCode: 44),
    County(title: "Kisii", countyCode: 45),
    County(title: "Nyamira", countyCode: 46),
    County(title: "Nairobi", countyCode: 47),
  ];
  String _selectedLocation;

  // void loadData() {
  //   // listDrop = [];
  //   // listDrop.add(new DropdownMenuItem(
  //   //   child: Text(
  //   //     'Nairobi'.toUpperCase(),
  //   //     style: TextStyle(
  //   //       color: Color.fromRGBO(0, 0, 0, 0.7),
  //   //     ),
  //   //   ),
  //   //   value: 1,
  //   // ));
  //   // listDrop.add(new DropdownMenuItem(
  //   //   child: Text(
  //   //     'uasin gishu'.toUpperCase(),
  //   //     style: TextStyle(
  //   //       color: Color.fromRGBO(0, 0, 0, 0.7),
  //   //     ),
  //   //   ),
  //   //   value: 2,
  //   // ));
  //   // listDrop.add(new DropdownMenuItem(
  //   //   child: Text(
  //   //     '62',
  //   //     style: TextStyle(
  //   //       color: Color.fromRGBO(0, 0, 0, 0.7),
  //   //     ),
  //   //     // overflow: TextOverflow.ellipsis,
  //   //   ),
  //   //   value: 2,
  //   // ));
  //   // listDrop.add(new DropdownMenuItem(
  //   //   child: Text(
  //   //     "353",
  //   //     style: TextStyle(
  //   //       color: Color.fromRGBO(0, 0, 0, 0.7),
  //   //     ),
  //   //   ),
  //   //   value: 3,
  //   // ));
  // }

  @override
  Widget build(BuildContext context) {
    // loadData();
    return BlocConsumer<SearchPropertyBloc, SearchPropertyState>(
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
                  'Nairobi'.toUpperCase(),
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                  ),
                ),
                items: listDrop.map((e) {
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
                      .add(SelectedCountyEvent(county: _selectedLocation.toUpperCase()));
                },
              ),
            ));
      },
    );
  }
}

DropdownMenuItem myDropdownItem(County county) {
  return DropdownMenuItem(
    child: Text(
      county.title.toUpperCase(),
      style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 0.7),
      ),
    ),
    value: county.countyCode,
  );
}

class County {
  final String title;
  final int countyCode;
  County({
    @required this.title,
    @required this.countyCode,
  });
}
