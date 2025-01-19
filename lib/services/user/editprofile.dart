import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> updateUserProfileApi(String data) async {
  try {
    final Dio _dio = Dio();
    // Sending POST request
    Response response = await _dio.post('$baseUrl/userprofile', data: data);

    // Checking if the request was successful
    if (response.statusCode == 200) {
      // Return the response data as a map (customize based on your API's response)
      return response.data;
    } else {
      throw Exception('Failed to make POST request');
    }
  } catch (e) {
    print("Error: $e");
    throw Exception('Error while making POST request');
  }
}
