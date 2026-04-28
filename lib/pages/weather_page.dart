import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  final String city;

  const WeatherPage({super.key, required this.city});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Weather? weather;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  bool isDayTime() {
    if (weather == null) return true;

    int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return currentTime >= weather!.sunrise &&
        currentTime < weather!.sunset;
  }

  // FETCH WEATHER WITH ERROR HANDLING
  void fetchWeather() async {
    try {
      setState(() {
        loading = true;
      });

      weather = await WeatherService.getWeather(widget.city);

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

  String getAnimation(String condition) {
    bool isDay = isDayTime();

    if (condition == "Clear") {
      return isDay ? "assets/sunny.json" : "assets/night.json";
    } else if (condition == "Clouds") {
      return "assets/cloudy.json";
    } else if (condition == "Rain" || condition == "Drizzle") {
      return "assets/rain.json";
    } else if (condition == "Thunderstorm") {
      return "assets/storm.json";
    } else if (condition == "Snow") {
      return "assets/snow.json";
    } else if (condition == "Mist" ||
        condition == "Smoke" ||
        condition == "Haze" ||
        condition == "Fog" ||
        condition == "Dust" ||
        condition == "Sand" ||
        condition == "Ash") {
      return "assets/cloudy.json";
    } else {
      return isDay ? "assets/sunny.json" : "assets/night.json";
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

                // CITY NAME
                Text(
                  widget.city.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDay ? Colors.black : Colors.white,
                  ),
                ),

                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Lottie.asset(
                        getAnimation(weather?.condition ?? "Clear"),
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      "${weather?.temp ?? 0} °C",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: isDay ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Humidity: ${weather?.humidity ?? 0}%",
                      style: TextStyle(
                        fontSize: 18,
                        color: isDay ? Colors.black : Colors.white,
                      ),
                    ),

                    Text(
                      "Condition: ${weather?.condition ?? ""}",
                      style: TextStyle(
                        fontSize: 18,
                        color: isDay ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}