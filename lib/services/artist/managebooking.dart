import 'dart:math';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';

final Dio _dio = Dio();

Future<Map<String, dynamic>> approverequestApi(Map<String, dynamic> data) async {
  try {
    // Extract the bookingId from the data
    String bookingId = data['id'].toString();

    // Sending GET request to approve the booking, including bookingId in the URL
    Response response = await _dio.get(
      '$baseUrl/Acceptbooking/$bookingId',  // Appending bookingId to the URL
    );

    // Checking if the request was successful
    if (response.statusCode == 200) {
      // Return the response data as a map (customize based on your API's response)
      return response.data;
    } else {
      throw Exception('Failed to make GET request');
    }
  } catch (e) {
    print("Error: $e");
    throw Exception('Error while making GET request');
  }
}


// Function to reject a booking
Future<Map<String, dynamic>> rejectRequestApi(Map<String, dynamic> data) async {
  try {
    // Extract the bookingId from the data
    String bookingId = data['id'].toString();

    // Sending GET request to reject the booking, including bookingId in the URL
    Response response = await _dio.get(
      '$baseUrl/Rejectbooking/$bookingId',  // Appending bookingId to the URL
    );

    // Checking if the request was successful
    if (response.statusCode == 200) {
      // Return the response data as a map (customize based on your API's response)
      return response.data;
    } else {
      throw Exception('Failed to make GET request');
    }
  } catch (e) {
    print("Error: $e");
    throw Exception('Error while making GET request');
  }
}
