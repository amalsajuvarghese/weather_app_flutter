import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;
  String _errorMessage = '';

  Map<String, dynamic>? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weatherData = await WeatherService().fetchWeather(city);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
