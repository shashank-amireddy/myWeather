
import 'dart:convert';
import 'package:http/http.dart' as http;

class Worker {
  late String location;
  late String temp;
  late String humidity;
  late String airSpeed="";
  late String description;
  late String main;
  late String icon;
  late String place;
  late String locat;

  Worker(this.location);

  Future<Map<String, dynamic>> getCoordinates() async {
    final apiKey = '6f8dfbdd15b123eb060896406ed0d9a7';
    final locationUri = Uri.parse('https://api.openweathermap.org/geo/1.0/direct?q=$location&limit=1&appid=$apiKey');

    final response = await http.get(locationUri);
    final data = json.decode(response.body);

    if (data != null && data.isNotEmpty) {
      final locationData = data[0];
      final latitude = locationData['lat']?.toString() ?? '';
      final longitude = locationData['lon']?.toString() ?? '';
      final place = locationData['name'] ?? '';

      return {'latitude': latitude, 'longitude': longitude, 'place' : place};
    } else {
      throw Exception('Location data not found');
    }
  }

  Future<void> fetchWeatherData(String latitude, String longitude, String place) async {
    try {
      final weatherData = await getWeatherData(latitude, longitude);
      temp = weatherData['temp'] ?? 'N/A';
      humidity = weatherData['humidity'] ?? 'N/A';
      airSpeed = weatherData['air_speed'] ?? 'N/A';
      description = weatherData['description'] ?? 'N/A';
      main = weatherData['main'] ?? 'N/A';
      icon = weatherData['icon'] ?? 'N/A';
      locat = place ?? 'N/A';
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Map<String, dynamic>> getWeatherData(String latitude, String longitude) async {
    final apiKey = '6f8dfbdd15b123eb060896406ed0d9a7';
    final weatherUri = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    final response = await http.get(weatherUri);
    Map data = jsonDecode(response.body);
    Map temp_data = data['main'];
    Map wind_data = data['wind'];
    final tempDouble = temp_data['temp']-273;
    final humidity1 = temp_data['humidity'];
    final airSpeedDouble = wind_data['speed']*3.6;
    final description = data['weather'][0]['description'];
    final main = data['weather'][0]['main'];
    final icon = data['weather'][0]['icon'];
    final temp = tempDouble.toStringAsFixed(1);
    final humidity = humidity1.toString();
    final airSpeed = airSpeedDouble.toStringAsFixed(1);

    return {'temp': temp, 'humidity': humidity, 'air_speed': airSpeed, 'description': description, 'main': main,'icon':icon};
  }

  Future<void> loadWeatherData() async {
    try {
      final coordinates = await getCoordinates();

      final latitudeStr = coordinates['latitude'];
      final longitudeStr = coordinates['longitude'];
      final place = coordinates['place'];

      if (latitudeStr.isNotEmpty && longitudeStr.isNotEmpty) {
        await fetchWeatherData(latitudeStr, longitudeStr, place);
        /*print('Temperature: $temp');
        print('Humidity: $humidity');
        print('Air Speed: $airSpeed');
        print('Description: $description');
        print('Description: $icon');*/
      } else {
        print('Latitude or longitude not available.');
      }
    } catch (e) {
      temp = 'N/A';
      humidity = 'N/A';
      airSpeed = 'N/A';
      description = 'N/A';
      main = 'N/A';
      icon = '03d';
      locat = 'N/A';
    }
  }
}
