import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/city.dart';
import 'package:http/http.dart' as http;
import '../models/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Constants myconstants = Constants();

  //intialising data assets
  int temperature = 0;
  int maxTemp = 0;
  String weatherStateName = 'Loading...';
  int humidity = 0;
  int windSpeed = 0;
  var currentData = 'Loading...';
  String imageUrl = '';
  int woeid = 44418; //earth id of default city ie london
  String location = 'London';

//getting selected city and its data
  var selectedCities = City.getSelectedCities();
  List<String> cities = [
    'London'
  ]; // list with selected city holds london as default

  List weatherList = []; //holds weather data after api calling

//Api call url
  String searchLocationUrl =
      'https://www.metaweather.com/api/location/search/?query='; //to get woeid
  String searchWeatherurl =
      'https://www.metaweather.com/api/location/'; // to get weather details

  //get the where on earth ID
  void fetchLocation(String Location) async {
    var searchResult = await http.get(Uri.parse(searchLocationUrl + location));
    var result = json.decode(searchResult.body)[0];
    setState(() {
      woeid = result['woeid'];
    });

    print(result['woeid']);
  }

  void fetchWeatherData() async {
    var weatherResult =
        await http.get(Uri.parse(searchWeatherurl + woeid.toString()));
    var result = json.decode(weatherResult.body);
    var weatherData = result['cobsolidated_weather'];

    setState(() {
      for (int i = 0; i < 7; i++) {
        weatherData.add(weatherData[
            i]); // for taking weather data of the next 6 days for the location searched
      }
    });
    temperature = weatherData[0]['the_temperature'].round();
    print(weatherData[0]);
    print(temperature);
  }

  @override
  void initState() {
    fetchLocation(cities[0]);
    fetchWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
    );
  }
}
