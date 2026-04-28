# Weather App (Flutter)

A modern, clean and responsive Weather Application built using Flutter.  
It provides real-time weather updates using the OpenWeather API with dynamic animations and GPS-based location detection.

---

## Features

- 🔍 Search weather by city name  
- 📍 Get weather using current GPS location  
- 🌤️ Dynamic Lottie animations (Sunny, Rain, Cloud, Snow, Night)  
- 🌡️ Temperature in Celsius  
- 💧 Humidity & weather conditions display  
- 🌙 Automatic Day & Night theme switching  
- ⚡ Clean, modern and responsive UI  

---

## Tech Stack

- Flutter (Dart)  
- OpenWeather API  
- Geolocator (GPS)  
- HTTP Package  
- Lottie Animations  

---

## Installation & Setup

Clone the repository:

git clone https://github.com/MamoonaAzam/weather-app.git

Go to project folder:

cd weather-app

Install dependencies:

flutter pub get

Run the app:

flutter run

---

## Environment Variables (API Key Setup)

This project uses OpenWeather API.

Create a `.env` file in the root directory:

API_KEY=your_openweather_api_key_here

Load it using `flutter_dotenv` in your Flutter project.

---

## Project Structure

lib/
 ├── main.dart
 ├── models/
 ├── pages/
 ├── services/
 └── widgets/

---

## Support

If you like this project, please give it a ⭐ on GitHub.

---

## License

This project is for educational purposes only.