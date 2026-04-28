import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import 'package:lottie/lottie.dart';
import 'package:geocoding/geocoding.dart';

class WeatherPageByLocation extends StatefulWidget {
  final double lat;
  final double lon;

  const WeatherPageByLocation({
    super.key,
    required this.lat,
    required this.lon,
  });

  @override
  State<WeatherPageByLocation> createState() =>
      _WeatherPageByLocationState();
}

class _WeatherPageByLocationState
    extends State<WeatherPageByLocation> {
  Weather? weather;
  bool loading = true;

  String locationName = "Detecting location...";

  @override
  void initState() {
    super.initState();
    fetchWeather();
    getLocationName();
  }

  void getLocationName() async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(
        widget.lat,
        widget.lon,
      );

      Placemark place = placeMarks[0];

      setState(() {
        locationName =
            "${place.locality ?? ""}, ${place.country ?? ""}";
      });
    } catch (e) {
      setState(() {
        locationName = "Unknown Location";
      });
    }
  }

  void fetchWeather() async {
    try {
      weather = await WeatherService.getWeatherByLocation(
        widget.lat,
        widget.lon,
      );

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading weather")),
      );
    }
  }

  // 🌙 DAY / NIGHT CHECK
  bool isDayTime() {
    if (weather == null) return true;

    int currentTime =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return currentTime >= weather!.sunrise &&
        currentTime < weather!.sunset;
  }

  // 🎨 ANIMATION LOGIC
  String getAnimation(String condition) {
    bool isDay = isDayTime();

    if (condition == "Clear") {
      return isDay ? "assets/sunny.json" : "assets/night.json";
    } else if (condition == "Clouds") {
      return "assets/cloudy.json";
    } else if (condition == "Rain" ||
        condition == "Drizzle") {
      return "assets/rain.json";
    } else if (condition == "Thunderstorm") {
      return "assets/storm.json";
    } else if (condition == "Snow") {
      return "assets/snow.json";
    } else {
      return isDay
          ? "assets/sunny.json"
          : "assets/night.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDay = weather != null ? isDayTime() : true;

    return Scaffold(
      backgroundColor:
          isDay ? Color(0xFFF5F5F5) : Color(0xFF1C1C1C),

      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
        backgroundColor:
            isDay ? Color(0xFFF5F5F5) : Color(0xFF1C1C1C),
        iconTheme: IconThemeData(
          color: isDay ? Colors.black : Colors.white,
        ),
      ),

      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Column(
                  children: [
                    Text(
                      "YOUR LOCATION",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDay
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      locationName,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDay
                            ? Colors.black54
                            : Colors.white70,
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50),
                      child: Lottie.asset(
                        getAnimation(
                            weather?.condition ?? "Clear"),
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      "${weather?.temp ?? 0} °C",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: isDay
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      weather?.condition ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        color: isDay
                            ? Colors.black54
                            : Colors.white70,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Humidity: ${weather?.humidity ?? 0}%",
                      style: TextStyle(
                        fontSize: 18,
                        color: isDay
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),

                    Text(
                      "Condition: ${weather?.condition ?? ""}",
                      style: TextStyle(
                        fontSize: 18,
                        color: isDay
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}