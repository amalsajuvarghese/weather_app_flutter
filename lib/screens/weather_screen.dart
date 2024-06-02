import 'package:flutter/material.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String city = ModalRoute.of(context)?.settings.arguments as String;

    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            'Weather in $city',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Consumer<WeatherProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            } else if (provider.errorMessage.isNotEmpty) {
              return Center(child: Text('Error: ${provider.errorMessage}'));
            } else if (provider.weatherData != null) {
              final weatherData = provider.weatherData!;
              return WeatherDetail(weatherData: weatherData);
            } else {
              provider.fetchWeather(city);
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherDetail({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final temp = weatherData['main']['temp'];
    final minTemp = weatherData['main']['temp_min'];
    final maxTemp = weatherData['main']['temp_max'];
    final condition = weatherData['weather'][0]['description'];
    final humidity = weatherData['main']['humidity'];
    final windSpeed = weatherData['wind']['speed'];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Temperature: $temp°C',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.orange),
                ),
                Text(
                  'Min Temp: $minTemp°C',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),
                Text(
                  'Max Temp: $maxTemp°C',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                ),
                Text(
                  'Condition: $condition',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.orange),
                ),
                Text(
                  'Humidity: $humidity%',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
                Text(
                  'Wind Speed: $windSpeed m/s',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
