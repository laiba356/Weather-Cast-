import 'package:flutter/material.dart';

class FiveDayForcastBigContainer extends StatelessWidget {
  final String date;
  final String temp;
  final String tempMax;
  final String tempMin;
  final String tempFeelsLike;
  final String weather;
  final String windSpeed;
  final String degree;
  final String gust;

  const FiveDayForcastBigContainer({
    super.key,
    required this.date,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.tempFeelsLike,
    required this.weather,
    required this.windSpeed,
    required this.degree,
    required this.gust,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
            color: Colors.white, strokeAlign: BorderSide.strokeAlignOutside),
        borderRadius: BorderRadius.circular(20.0),
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Date:',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              Text(
                date,
                style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
          const SizedBox(height: 8.0), // Space between rows

          // Temperature Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Temperature:',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              Text(
                temp,
                style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
          const SizedBox(height: 4.0),

          // Temp Min Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Temp (min):',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              Text(
                tempMin,
                style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
          const SizedBox(height: 4.0),

          // Temp Max Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Temp (max):',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              Text(
                tempMax,
                style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
          const SizedBox(height: 4.0),

          // Feels Like Temperature Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Feels Like:',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              Text(
                tempFeelsLike,
                style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Weather Condition Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Weather:',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              Text(
                weather,
                style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Wind Speed Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Wind Speed:',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              Text(
                windSpeed,
                style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
          const SizedBox(height: 4.0),

          // Wind Degree Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Wind Degree:',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              Text(
                degree,
                style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
          const SizedBox(height: 4.0),

          // Wind Gust Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Wind Gust:',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              Text(
                gust,
                style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
