import 'package:bridal_hub/services/artist/manageprofike.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:bridal_hub/services/user/registerApi.dart';
import 'package:dio/dio.dart';


  final Dio _dio = Dio();

  

  Future<Map<String, dynamic>> getUserProfile(
       ) async {
    try {
      // Sending POST request 
      // Response response = await _dio.post('$baseUrl/artistprofile/$loginId');
      Response response = await _dio.get('$baseUrl/userprofile/$loginId');
      print("eeeeeeeeeeeee$response");

      // Checking if the request was successful
      if (response.statusCode == 200) {
        profiledata=response.data;
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





