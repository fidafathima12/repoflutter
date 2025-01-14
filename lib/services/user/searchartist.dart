import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';


final Dio _dio = Dio();

Future<List<Map<String, dynamic>>> getArtistesApi() async {
  try {
    print('***************');
    // Sending GET request
    Response response = await _dio.get('$baseUrl/artist');

    // Checking if the request was successful
    if (response.statusCode == 200) {
      // Check if the response is already a list
      if (response.data is List) {
        // Convert each item to a Map<String, dynamic>
        List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response.data);
        // print('Artist response: $data');
        return data;
      } else {
        throw Exception('Expected a list of artists, but got something else');
      }
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print("Error: $e");
    throw Exception('Error while making GET request');
  }
}
