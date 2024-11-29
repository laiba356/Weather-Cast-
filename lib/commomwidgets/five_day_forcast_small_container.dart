import 'package:flutter/material.dart';

class FiveDayForcastSmallContainer extends StatefulWidget {
  const FiveDayForcastSmallContainer({
    super.key,
    required this.date,
    required this.temperature,
    required this.weatherDescription,
  });
  
  final String date;
  final String temperature;
  final String weatherDescription;

  @override
  State<FiveDayForcastSmallContainer> createState() =>
      _FiveDayForcastSmallContainerState();
}

class _FiveDayForcastSmallContainerState
    extends State<FiveDayForcastSmallContainer> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var Size(:height, :width) = size;

    return Container(
      width: width * 0.35,
      padding:
          const EdgeInsets.all(16.0), 
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white, 
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0), 
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), 
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), 
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.date,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0), 
          Text(
            widget.temperature.toString(),
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.weatherDescription,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
