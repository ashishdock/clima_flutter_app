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
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
