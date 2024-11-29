import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

import '../commomwidgets/expandable_container.dart';
import '../commomwidgets/listview_of_small_forcast_containers.dart';
import '../constants/constants.dart';
import '../helpermethods/group_forcast_by_logical_days.dart';
import '../helpermethods/temprature_convert.dart';


class CityNameWeather extends StatefulWidget {
  const CityNameWeather({super.key});

  @override
  State<CityNameWeather> createState() => CityNameWeatherHomePageState();
}

class CityNameWeatherHomePageState extends State<CityNameWeather> {
  final WeatherFactory _factory = WeatherFactory(apiKey);
  Weather? _currentWeatherByCityName;
  List<Weather>? _fiveDaysCurrentWeatherByCityName;
  final _cityController = TextEditingController();
  bool _isLoading = false;
  bool _hasCityName = false;
  String? errorMessage;
  Map? mapOfLogicalDays;

  Future<void> fetchWeatherData(String cityName) async {
    setState(() {
      _isLoading = true;
      _hasCityName = true;
      errorMessage = null;
    });

    try {
      var cityWeather = await _factory.currentWeatherByCityName(cityName);
      var fivedayscityWeather =
          await _factory.fiveDayForecastByCityName(cityName);

      setState(() {
        _currentWeatherByCityName = cityWeather;
        _fiveDaysCurrentWeatherByCityName = fivedayscityWeather;
        mapOfLogicalDays =
            groupForecastsByLogicalDays(_fiveDaysCurrentWeatherByCityName!);
        //  print(groupForecastsByLogicalDays(_fiveDaysCurrentWeatherByCityName!));
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching weather data: $e';
        _currentWeatherByCityName = null;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var Size(:height, :width) = size;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Color.fromARGB(255, 50, 110, 138)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 1.0],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.08),
                    // TextFormField for City Input
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        controller: _cityController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter city name",
                          hintStyle: const TextStyle(color: Colors.white54),
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white24,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () {
                              if (_cityController.text.isNotEmpty) {
                                fetchWeatherData(_cityController.text);
                              }
                            },
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            fetchWeatherData(value);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    // Display error message if any
                    if (errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),

                    // Display instruction if no city is entered
                    if (!_hasCityName && !_isLoading)
                      const Text(
                        'Enter a city to get the weather info',
                        style: TextStyle(color: Colors.white),
                      ),

                    // Loading spinner
                    if (_isLoading) const CircularProgressIndicator(),

                    // Show weather data if available
                    if (_currentWeatherByCityName != null && !_isLoading) ...[
                      SizedBox(height: height * 0.02),

                      // 1. City and Country
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_currentWeatherByCityName!.areaName}, ${_currentWeatherByCityName!.country}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _currentWeatherByCityName!.date != null
                                      ? DateFormat('yyyy-MM-dd hh:mm a').format(
                                          _currentWeatherByCityName!.date!
                                              .toLocal()
                                          // .add(const Duration(hours: -12)
                                          // )
                                          )
                                      : "Unknown Date",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // 2. Weather Icon and Temp Info
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.network(
                          "http://openweathermap.org/img/w/${_currentWeatherByCityName!.weatherIcon}.png",
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error, color: Colors.red);
                          },
                        ),
                      ),
                      Text(
                        convertTemperature(
                            _currentWeatherByCityName!.temperature.toString()),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.arrow_drop_up,
                                  color: Colors.red),
                              Text(
                                convertTemperature(_currentWeatherByCityName!
                                    .tempMax
                                    .toString()),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
                              Text(
                                convertTemperature(_currentWeatherByCityName!
                                    .tempMin
                                    .toString()),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "Feels like ${_currentWeatherByCityName!.tempFeelsLike}°C",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        "${_currentWeatherByCityName!.weatherDescription}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      //6
                      ExpandableContainer(
                        snow: _currentWeatherByCityName!.snowLast3Hours ?? 0.0,
                        humidity: _currentWeatherByCityName!.humidity ?? 0.0,
                        wind: _currentWeatherByCityName!.windSpeed ?? 0.0,
                        windDegree:
                            _currentWeatherByCityName!.windDegree ?? 0.0,
                        windGust: _currentWeatherByCityName!.windGust ?? 0.0,
                        cloudiness:
                            _currentWeatherByCityName!.cloudiness ?? 0.0,
                      ),
                      //7
                      const Center(
                          child: Text(
                        "Five Day Forcast",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                      //8
                      ListviewOfSmallForcastContainers(
                        day: "Day 1",
                        logicalDayForcast: mapOfLogicalDays,
                      ),
                      //9
                      ListviewOfSmallForcastContainers(
                        day: "Day 2",
                        logicalDayForcast: mapOfLogicalDays,
                      ),
                      //10
                      ListviewOfSmallForcastContainers(
                          day: "Day 3", logicalDayForcast: mapOfLogicalDays),
                      //11
                      ListviewOfSmallForcastContainers(
                          day: "Day 4", logicalDayForcast: mapOfLogicalDays),
                      //12
                      ListviewOfSmallForcastContainers(
                          day: "Day 5", logicalDayForcast: mapOfLogicalDays),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
