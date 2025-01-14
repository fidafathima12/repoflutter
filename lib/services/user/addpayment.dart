import 'package:bridal_hub/presentation/user/paymentsucess.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


  final Dio _dio = Dio();

  Future<Map<String, dynamic>> addPaymentApi(
       data,context) async {
    try {
      // Sending POST request
      Response response = await _dio.post('$baseUrl/bookingpayment/', data: data);

      // Checking if the request was successful
      if (response.statusCode == 200) {
          Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentSuccessfulScreen()),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Payment Successful!"),
                        duration: Duration(seconds: 3),
                      ),
                    );
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

  

