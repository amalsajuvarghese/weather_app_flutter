import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class WeatherService {
  static const _apiKey = '79db6fec8ffc3828ce1bbfe8f0fd25d0';
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http
        .get(Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric'));

    log('$_baseUrl?q=$city&appid=$_apiKey&units=metric');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
