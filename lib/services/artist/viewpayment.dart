import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';


  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> viewPaymnetApi() async {
    try {
      // Sending GET request
      Response response = await _dio.get('$baseUrl/ArtistPaymentStatus/$loginId');
      print(response);

      // Checking if the request was successful
      if (response.statusCode == 200) {
      
        List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response.data);
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while making GET request');
    }
  }

