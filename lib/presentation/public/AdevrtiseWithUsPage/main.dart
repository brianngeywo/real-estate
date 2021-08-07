import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AdvertiseWithUsPage extends StatefulWidget {
  static const route = 'advertiseWithUsButton';
  @override
  _AdvertiseWithUsPageState createState() => _AdvertiseWithUsPageState();
}

class _AdvertiseWithUsPageState extends State<AdvertiseWithUsPage> {
  TextEditingController _ratingController = TextEditingController();

  double _userRating = 3.0;
  bool _isVertical = false;

  IconData _selectedIcon;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Rating Bar'),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 40.0),
            _heading('Rating Indicator'),
            RatingBarIndicator(
              rating: _userRating,
              itemBuilder: (context, index) => Icon(
                _selectedIcon ?? Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 50.0,
              unratedColor: Colors.amber.withAlpha(50),
              direction: _isVertical ? Axis.vertical : Axis.horizontal,
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _ratingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter rating',
                  labelText: 'Enter rating',
                  suffixIcon: MaterialButton(
                    onPressed: () {
                      _userRating = double.parse(_ratingController.text ?? '0.0');
                      setState(() {});
                    },
                    child: Text('Rate'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heading(String text) => Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      );
}
