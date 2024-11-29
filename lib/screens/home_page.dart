import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import '../commomwidgets/expandable_container.dart';
import '../commomwidgets/listview_of_small_forcast_containers.dart';
import '../constants/constants.dart';
import '../helpermethods/group_forcast_by_logical_days.dart';
import '../helpermethods/permission_check.dart';
import '../helpermethods/temprature_convert.dart';
import 'city_name_weather.dart';
import 'starting_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late String cityName = "Bahawalpur";
  final WeatherFactory _factory = WeatherFactory(apiKey);
  Weather? _currentWeatherByLocation;
  List<Weather>? _fiveDayWeatherByLocation;

  Map? mapofLogicalDays;
  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    Position position = await permissionCheck();
    double latitude = position.latitude;
    double longitude = position.longitude;

    var locationWeather =
        await _factory.currentWeatherByLocation(latitude, longitude);
    var locationForecast =
        await _factory.fiveDayForecastByLocation(latitude, longitude);

    setState(() {
      _currentWeatherByLocation = locationWeather;
      _fiveDayWeatherByLocation = locationForecast;
      mapofLogicalDays =
          groupForecastsByLogicalDays(_fiveDayWeatherByLocation!);
      print(_fiveDayWeatherByLocation);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black87, Color.fromARGB(255, 50, 110, 138)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 1.0])),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.08,
                    ),
                    // Check if _currentWeatherByCityName is null
                    if (_currentWeatherByLocation != null) ...[
                      // If not null, display weather info
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${_currentWeatherByLocation!.areaName}, ${_currentWeatherByLocation!.country}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _currentWeatherByLocation!.date != null
                                      ? DateFormat('yyyy-MM-dd hh:mm a').format(
                                          _currentWeatherByLocation!.date!
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
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) {
                                    return const CityNameWeather();
                                  },
                                ));
                              },
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(CupertinoPageRoute(
                                        builder: (context) {
                                          return const CityNameWeather();
                                        },
                                      ));
                                    },
                                    child: const Text(
                                      "Search By\nCity Name",
                                      style: TextStyle(color: Colors.amber),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.amber,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.network(
                          "http://openweathermap.org/img/w/${_currentWeatherByLocation!.weatherIcon}.png",
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error, color: Colors.red);
                          },
                        ),
                      ),
                      Text(
                        convertTemperature(
                            _currentWeatherByLocation!.temperature.toString()),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.arrow_drop_up,
                                color: Colors.red,
                              ),
                              Text(
                                convertTemperature(_currentWeatherByLocation!
                                    .tempMax
                                    .toString()),
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
                              Text(
                                convertTemperature(_currentWeatherByLocation!
                                    .tempMin
                                    .toString()),
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "Feels like ${convertTemperature(_currentWeatherByLocation!.tempFeelsLike.toString())}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        "${_currentWeatherByLocation!.weatherDescription}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      ExpandableContainer(
                        snow: _currentWeatherByLocation!.snowLast3Hours ?? 0.0,
                        humidity: _currentWeatherByLocation!.humidity ?? 0.0,
                        wind: _currentWeatherByLocation!.windSpeed ?? 0.0,
                        windDegree:
                            _currentWeatherByLocation!.windDegree ?? 0.0,
                        windGust: _currentWeatherByLocation!.windGust ?? 0.0,
                        cloudiness:
                            _currentWeatherByLocation!.cloudiness ?? 0.0,
                      ),

                      Center(
                          child: Column(
                        children: [
                          const Text(
                            "Five Day Forecast",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          const Text(
                            "The following forecast is shown at 3-hour intervals from the current time.",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.yellow,
                            ),
                          )
                        ],
                      )),

                      ListviewOfSmallForcastContainers(
                        day: "Day 1",
                        logicalDayForcast: mapofLogicalDays ?? {},
                      ),
                      ListviewOfSmallForcastContainers(
                        day: "Day 2",
                        logicalDayForcast: mapofLogicalDays ?? {},
                      ),
                      ListviewOfSmallForcastContainers(
                        day: "Day 3",
                        logicalDayForcast: mapofLogicalDays ?? {},
                      ),
                      ListviewOfSmallForcastContainers(
                        day: "Day 4",
                        logicalDayForcast: mapofLogicalDays ?? {},
                      ),
                      ListviewOfSmallForcastContainers(
                        day: "Day 5",
                        logicalDayForcast: mapofLogicalDays ?? {},
                      ),
                    ] else ...[
                      // If null, show starting screen
                      StartingScreen(),
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
