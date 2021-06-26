import 'package:Realify/backend/bloc/search_property_bloc/search_property_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  List<DropdownMenuItem<int>> listDrop = [];

  void loadData() {
    listDrop = [];
    listDrop.add(new DropdownMenuItem(
      child: Text(
        'Nairobi'.toUpperCase(),
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.7),
        ),
      ),
      value: 1,
    ));
    listDrop.add(new DropdownMenuItem(
      child: Text(
        'uasin gishu'.toUpperCase(),
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.7),
        ),
      ),
      value: 2,
    ));
    // listDrop.add(new DropdownMenuItem(
    //   child: Text(
    //     '62',
    //     style: TextStyle(
    //       color: Color.fromRGBO(0, 0, 0, 0.7),
    //     ),
    //     // overflow: TextOverflow.ellipsis,
    //   ),
    //   value: 2,
    // ));
    // listDrop.add(new DropdownMenuItem(
    //   child: Text(
    //     "353",
    //     style: TextStyle(
    //       color: Color.fromRGBO(0, 0, 0, 0.7),
    //     ),
    //   ),
    //   value: 3,
    // ));
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return BlocConsumer<SearchPropertyBloc, SearchPropertyState>(
                          listener: (context, state) {
        if (state is SearchPropertySelectedCounty) {
          
        }
      },
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                // itemHeight: 2,
                iconSize: 25,
                elevation: 0,
                value: selected,
                hint: Text(
                  'Nairobi'.toUpperCase(),
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                  ),
                ),
                items: listDrop,
                onChanged: (value) {
                  selected = value;
                  switch (value) {
                    case 1:
                      BlocProvider.of<SearchPropertyBloc>(context)
                          .add(SelectedCountyEvent(county: 'Nairobi'.toUpperCase()));
                      break;
                    case 2:
                      BlocProvider.of<SearchPropertyBloc>(context)
                          .add(SelectedCountyEvent(county: 'UASIN GISHU'.toUpperCase()));
                      break;
                    default:
                      BlocProvider.of<SearchPropertyBloc>(context)
                          .add(SelectedCountyEvent(county: 'Nairobi'.toUpperCase()));
                  }
                },
              ),
            ));
      },
    );
  }
}
