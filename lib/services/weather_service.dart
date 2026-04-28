import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
    static String apiKey = dotenv.env['API_KEY'] ?? "";

  static Future<Weather> getWeather(String city) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=${city.trim()}&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

   

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // API error check 
      if (data['cod'] != 200) {
        throw Exception(data['message']);
      }

      return Weather.fromJson(data);
    } else {
      throw Exception("Failed to load weather");
    }
  }

  //  LATITUDE / LONGITUDE BASED 
  static Future<Weather> getWeatherByLocation(
      double lat, double lon) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['cod'] != 200) {
        throw Exception(data['message']);
      }

      return Weather.fromJson(data);
    } else {
      throw Exception("Failed to load location weather");
    }
  }
}