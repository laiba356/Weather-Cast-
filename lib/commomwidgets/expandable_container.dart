import 'package:flutter/material.dart';

class ExpandableContainer extends StatefulWidget {
  const ExpandableContainer(
      {super.key,
      required this.snow,
      required this.humidity,
      required this.wind,
      required this.windDegree,
      required this.windGust,
      required this.cloudiness});
  final double snow;
  final double humidity;
  final double wind;
  final double windDegree;
  final double windGust;
  final double cloudiness;

  @override
  State<ExpandableContainer> createState() => _ExpandableContainer();
}

class _ExpandableContainer extends State<ExpandableContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              // color: Colors.blueGrey[900],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Other Properties',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    )
                  ],
                ),
                // First Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: WeatherInfo(
                        title: 'Wind Degree',
                        value: '${widget.windDegree}°',
                      ),
                    ),
                    Expanded(
                      child: WeatherInfo(
                        title: 'Humidity',
                        value: '${widget.humidity}%',
                      ),
                    ),
                    Expanded(
                      child: WeatherInfo(
                        title: 'Wind',
                        value: '${widget.wind} m/s',
                      ),
                    )
                  ],
                ),
                // Second Row (conditionally visible)
                if (isExpanded)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: WeatherInfo(
                            title: 'Wind Gust',
                            value: '${widget.windGust} m/s',
                          ),
                        ),
                        Expanded(
                          child: WeatherInfo(
                            title: 'Snow',
                            value: '${widget.snow} mm',
                          ),
                        ),
                        Expanded(
                          child: WeatherInfo(
                            title: 'Cloudiness',
                            value: '${widget.cloudiness}%',
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final String title;
  final String value;

  const WeatherInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}
