import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = '6ae17db0b708df19d6a3124032a2ef7b';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double longtitude;
  double lattitude;

  void getLocationData() async {
    Location location = Location();
    await location.getLocation();

    longtitude = location.longtitude;
    lattitude = location.lattitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lattitude&lon=$longtitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();

    var temperature = weatherData['main']['temp'];
    var condition = weatherData['weather'][0]['id'];
    var cityName = weatherData['name'];

    print('$temperature $condition $cityName');

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
    }));
  }

  @override
  void initState() {
    super.initState();
    print('initState');
    getLocationData();
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactive call');
  }

  void getData() async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lattitude&lon=$longtitude&appid=$apiKey';
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      var decodeData = jsonDecode(data);

      var temperature = decodeData['main']['temp'];
      var condition = decodeData['weather'][0]['id'];
      var cityName = decodeData['name'];

      print('$temperature $condition $cityName');
    } else {
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
      body: Center(
        child: SpinKitDoubleBounce(
          color : Colors.white,
          size : 100
        ),
      ),
    );
  }
}
