import 'package:bridal_hub/presentation/artist/Homescreen.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/material.dart'; // Import for File class

final Dio _dio = Dio();

Future<Map<String, dynamic>> addPreviousWorkApi(
  Map<String, dynamic> data,
  File pickedImage,
  BuildContext context, // Assuming pickedImage is a File
) async {
  try {
    print(pickedImage);
    print(data);
    // Prepare the form data (including the file)
    FormData formData = FormData.fromMap({
      ... data,
      'file': await MultipartFile.fromFile(
        pickedImage.path,
        filename: pickedImage.path.split('/').last, // Optional: you can provide a custom file name
      ),
    });

    // Sending POST request with file upload
    Response response = await _dio.post(
      '$baseUrl/add_previous_work/$loginId', 
      data: formData,
    );

    // Checking if the request was successful
    if (response.statusCode == 200|| response.statusCode==201) {
      // Show success snackbar
      snackbarWidget(context, 'Work added successfully!');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
      
      // Return the response data as a map (customize based on your API's response)
      return response.data;
    } else {
      // Handle unsuccessful responses
      snackbarWidget(context, 'Failed to add work. Please try again.');
      throw Exception('Failed to make POST request');
    }
  } catch (e) {
    print("Error: $e");
    snackbarWidget(context, 'Error while uploading: $e');
    throw Exception('Error while making POST request: $e');
  }
}

// SnackBar helper function
void snackbarWidget(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
