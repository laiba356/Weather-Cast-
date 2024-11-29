import 'package:flutter/material.dart';

class StartingScreen extends StatefulWidget {
  @override
  State<StartingScreen> createState() => _LoadingWeatherDataState();
}

class _LoadingWeatherDataState extends State<StartingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 2), 
      vsync: this,
    )..repeat(reverse: true); 

   
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
   
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Container(
      height: height,
      width: width,
      color: Colors.black,
      child: Center(
        
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: const Text(
            'Loading weather data',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 50, 110, 138)),
          ),
        ),
      ),
    );
  }
}
