import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    Location location = Location();
    await location.getLocation();

    print(location.lattitude);
    print(location.longtitude);
  }

  @override
  void initState() {
    super.initState();
    print('initState');
    getLocation();
    getData();
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactive call');
  }

  void getData() async  {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=6ae17db0b708df19d6a3124032a2ef7b';
    http.Response response = await http.get(url);
    
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      var decodeData = jsonDecode(data);

      var temperature = decodeData['main']['temp'];
      var condition = decodeData['weather'][0]['id'];
      var cityName = decodeData['name'];

      print('$temperature $condition $cityName');
    }
    else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    String myMargin = '15';
    double myMarginAsADouble;

    try {
      myMarginAsADouble = double.parse(myMargin);
    } catch (e) {
      print(e);
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(myMarginAsADouble ?? 30.0),
        color: Colors.red,
      ),
    );
  }
}
