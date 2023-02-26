import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../services/networking.dart';
import '../services/location.dart';

var weatherUrl = dotenv.env['WEATHER_URL'];
var apiAccesskey = dotenv.env['API_ACCESS_KEY'];

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    String url =
        '$weatherUrl$apiAccesskey&query=${location.latitude},${location.longitude}';

    var weatherData = await NetworkHelper(url: url).getData();
    print(weatherData);
    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    String url = '$weatherUrl$apiAccesskey&query=$cityName';
    var weatherData = await NetworkHelper(url: url).getData();
    print(weatherData);
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
