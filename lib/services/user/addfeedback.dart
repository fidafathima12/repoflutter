import 'package:bridal_hub/presentation/user/homepage.dart';
import 'package:bridal_hub/presentation/user/paymentsucess.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Create a Dio instance to handle requests
final Dio _dio = Dio();

Future<Map<String, dynamic>> addReviewApi(Map<String, dynamic> data, BuildContext context) async {
  try {
    // Send POST request to the API endpoint
    Response response = await _dio.post(
      '$baseUrl/addreviewapi/$loginId', // Replace with your actual API endpoint
      data: data,
    );

    // Check if the response status code is successful (200 OK)
    if (response.statusCode == 200|| response.statusCode==201) {
      // Show success message to the user
     

      // Optional: Navigate to another screen (e.g., PaymentSuccessfulScreen)
     await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BridalEleganceHome()),
      );

      // Return the API response data as a map (customize based on your API's response structure)
      return response.data;
    } else {
      // Throw an exception if the status code is not 200
      throw Exception('Failed to submit review. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle errors in the try block
    print("Error occurred while submitting review: $e");

    // Show an error message to the user if something went wrong
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error submitting review. Please try again."),
        duration: Duration(seconds: 3),
      ),
    );

    // Rethrow the exception for further handling if necessary
    throw Exception('Error while making POST request: $e');
  }
}
