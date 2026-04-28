import 'package:flutter/material.dart';
import 'weather_page.dart';
import 'weather_page_by_location.dart';
import '../services/location_service.dart';
import 'package:geolocator/geolocator.dart';

class CityInputPage extends StatefulWidget {
  
  @override
  _CityInputPageState createState() => _CityInputPageState();
}

class _CityInputPageState extends State<CityInputPage> {
  TextEditingController cityController = TextEditingController();

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FC), // soft clean background

      appBar: AppBar(
        title: Text(
          "🌤 SkyCast",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFF7F9FC),
        foregroundColor: Colors.black,
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Check Weather",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 30),
              TextField(
                controller: cityController,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Enter city name",
                  prefixIcon: Icon(Icons.location_city),

                  filled: true,
                  fillColor: Colors.white,

                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 18,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    String city = cityController.text.trim();

                    if (city.isEmpty) {
                      showError("Please enter a city name");
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WeatherPage(city: city),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Get Weather",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12),

            
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  icon: Icon(Icons.my_location),
                  label: Text("Use My Location"),

                  onPressed: () async {
                    try {
                      Position position =
                          await LocationService.getCurrentLocation();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WeatherPageByLocation(
                            lat: position.latitude,
                            lon: position.longitude,
                          ),
                        ),
                      );
                    } catch (e) {
                      showError(e.toString());
                    }
                  },

                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}