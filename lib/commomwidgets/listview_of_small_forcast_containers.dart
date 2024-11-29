import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:weather/weather.dart';
import 'package:weather_app2/screens/forcast_detail_screen.dart';

import '../helpermethods/temprature_convert.dart';
import 'five_day_forcast_small_container.dart';


class ListviewOfSmallForcastContainers extends StatefulWidget {
  final String day;
  final Map? logicalDayForcast;

  const ListviewOfSmallForcastContainers({
    super.key,
    required this.day,
    required this.logicalDayForcast,
  });

  @override
  State<ListviewOfSmallForcastContainers> createState() {
    return _ListviewOfSmallForcastContainersState();
  }
}

class _ListviewOfSmallForcastContainersState
    extends State<ListviewOfSmallForcastContainers> {
  List<Weather>? list;

  @override
  void initState() {
    super.initState();
    list = widget.logicalDayForcast?[widget.day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    
  

    var size = MediaQuery.of(context).size;
    var height = size.height;

    return Column(
      children: [
        // Header Row
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.day,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return ForcastDetailScreen(
                        list: list!,
                        dayName: widget.day,
                      );
                    },
                  ));
                },
                child: const Text(
                  "Detail >>",
                  style: TextStyle(color: Colors.yellow),
                ),
              ),
            ],
          ),
        ),
        // Weather Data List
        SizedBox(
          height: height * 0.23,
          child: list!.isEmpty
              ? const Center(
                  child: Text(
                    "No data available",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: list!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final weather = list![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FiveDayForcastSmallContainer(
                        key: ValueKey(
                            weather.date),
                        date: weather.date != null
                            ? DateFormat('yyyy-MM-dd hh:mm a')
                                .format(weather.date!.toLocal()
                                    
                                    )
                            : "Unknown Date",

                       
                        temperature:
                            convertTemperature(weather.temperature.toString()),
                        weatherDescription:
                            weather.weatherDescription ?? "No Description",
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
