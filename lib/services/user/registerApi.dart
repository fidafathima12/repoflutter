import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final Dio _dio = Dio();

int? res;

Future<Map<String, dynamic>> userregisterfun(data, context) async {
  try {
    // Replace with your API endpoint for registration

    // Creating the request data

    // Sending POST request
    Response response = await _dio.post('$baseUrl/userregistrationapi', data: data);
print(response.data);
    res = response.statusCode;
    print(res);
    if (res == 201) {
      print('Registration Successful');
    } else {
      print('Registration failed');
    }
  } catch (e) {
    print(e);
  }
  return {};
}
