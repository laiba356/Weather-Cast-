import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

import '../commomwidgets/fiva_day_forcast_big_container.dart';
import '../helpermethods/temprature_convert.dart';


class ForcastDetailScreen extends StatefulWidget {
  final List<Weather> list;
  final String dayName;

  const ForcastDetailScreen(
      {super.key, required this.list, required this.dayName});

  @override
  State<ForcastDetailScreen> createState() => _MyContainerListState();
}

class _MyContainerListState extends State<ForcastDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, 
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Day Name
                Text(
                  widget.dayName,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                // Go Back Button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); 
                  },
                  child: const Text("<< Go Back",
                      style: TextStyle(color: Colors.yellow)),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: ListView.builder(
          itemCount: 8, 
          scrollDirection: Axis.vertical, 
          itemBuilder: (context, index) {
            Weather weather = widget.list[index];
            return Container(
              color: Colors.black,
              child: FiveDayForcastBigContainer(
                date: weather.date != null
                    ? DateFormat('yyyy-MM-dd hh:mm a')
                        .format(weather.date!.toLocal())
                    : "Unknown Date",
                temp: convertTemperature(weather.temperature.toString()),
                tempMax: convertTemperature(weather.tempMax.toString()),
                tempMin: convertTemperature(weather.tempMin.toString()),
                tempFeelsLike:
                    convertTemperature(weather.tempFeelsLike.toString()),
                weather: weather.weatherDescription!,
                windSpeed: '${weather.windSpeed} m/s',
                gust: '${weather.windGust} m/s',
                degree: '${weather.windDegree}°',
              ),
            );
          },
        ),
      ),
    );
  }

  
}
