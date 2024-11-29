// Helper function to group forecasts by logical days
import 'package:weather/weather.dart';

Map<String, List<Weather>> groupForecastsByLogicalDays(
    List<Weather> forecasts) {
  Map<String, List<Weather>> groupedForecasts = {};

  DateTime now = DateTime.now();
  int currentDay = now.day;

  for (var forecast in forecasts) {
    Duration diff = forecast.date!.difference(now);
    int dayDifference = diff.inDays;

    String dayLabel = "Day ${dayDifference + 1}";

    if (groupedForecasts.containsKey(dayLabel)) {
      groupedForecasts[dayLabel]!.add(forecast);
    } else {
      groupedForecasts[dayLabel] = [forecast];
    }
  }

  return groupedForecasts;
}
