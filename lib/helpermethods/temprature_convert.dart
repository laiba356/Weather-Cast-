String convertTemperature(String temp) {
  
  double numericTemp = double.parse(temp.split(" ")[0]);
  int roundedTemp = numericTemp.round();
  return "$roundedTemp°C";
}

double _parseTemperature(dynamic temp) {
  if (temp is double) {
    return temp; 
  } else if (temp is String) {
    final parsed = double.tryParse(temp);
    return parsed ?? 0.0; 
  }
  return 0.0; 
}
