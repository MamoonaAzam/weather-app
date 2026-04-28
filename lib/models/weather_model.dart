class Weather {

  final double temp;
  final int humidity;
  final String condition;
  final int sunrise;
  final int sunset;

  Weather({
    required this.temp,
    required this.humidity,
    required this.condition,
    required this.sunrise,
    required this.sunset
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(

      temp: json['main']['temp'].toDouble(),

      humidity: json['main']['humidity'],

      // weather condition (Clouds, Rain, Clear)
      condition: json['weather'][0]['main'],

      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
    );
  }
}