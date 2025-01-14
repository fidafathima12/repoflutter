import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';


  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchModelImages(context,artistid) async {
    try {
      // Sending GET request
    Response response = await _dio.get('$baseUrl/ViewModels/$artistid');


      // Checking if the request was successful
      if (response.statusCode == 200) {
        print('****************');
        print(response);
        print('****************');
        // Assuming the API returns a JSON array (list of objects)
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

