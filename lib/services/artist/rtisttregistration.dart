import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


  final Dio _dio = Dio();

  Future<Map<String, dynamic>> artistregisterfun(data,context) async {
    try {
      // Replace with your API endpoint for registration
     

      // Creating the request data
    

      // Sending POST request
      Response response = await _dio.post('$baseUrl/uhbj', data: data);

      // Checking if the request was successful
      if (response.statusCode == 201) {
        Navigator.pop(context);
        // Return the response data as a map (you can customize it as per your API response)
        return response.data;
      } else {
        throw Exception('Registration failed. Please try again.');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while trying to register');
    }
  }

