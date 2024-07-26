import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weatherapp/widgets/card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

const apiKey = 'YOUR_API_KEY'; // Replace with your API key

Future<WeatherModel> fetchWeather(String cityName) async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return WeatherModel.fromJson(data);
  } else {
    throw Exception('Failed to load weather data');
  }
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityName = 'Mumbai'; //Default city
  WeatherModel? weatherData;
  bool isLoading = false;
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await fetchWeather(cityName);
      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  String getAnimationForCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'rain':
        return 'assets/rainy.json';
      case 'clouds':
        return 'assets/cloudy.json';
      case 'snow':
        return 'assets/snowy.json';
      // Add more conditions and corresponding animations as needed
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff5842A9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    controller: cityController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 25),
                      hintText: 'Enter city name',
                      hintStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1),
                      fillColor: const Color.fromARGB(255, 142, 119, 223),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Container(
                        padding: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              cityName = cityController.text;
                              fetchWeatherData();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                isLoading
                    ? const CircularProgressIndicator()
                    : weatherData == null
                        ? const Text('No data')
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${weatherData!.cityName}',
                                style: const TextStyle(
                                    fontSize: 50,
                                    color: Colors.white,
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '${weatherData!.temp}°C',
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w700),
                              ),
                              Lottie.asset(
                                getAnimationForCondition(
                                    weatherData!.condition),
                                height: 200,
                                width: 200,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  WeatherCard(
                                      imagePath: 'assets/humidity.png',
                                      value: '${weatherData!.humidity}%'),
                                  WeatherCard(
                                      imagePath: 'assets/windspeed.png',
                                      value: '${weatherData!.windSpeed} m/s'),
                                ],
                              ),
                            ],
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
