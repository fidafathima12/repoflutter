import 'package:bridal_hub/services/artist/addpreviouswork.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';
import 'dart:io'; 

final Dio _dio = Dio();

Future<Map<String, dynamic>> addmodelApi(File selectedImage,context) async {
  try {
    
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(selectedImage.path, filename: 'model_image.jpg'), 
    });


    Response response = await _dio.post(
      '$baseUrl/ugh', 
      data: formData,
    );

    if (response.statusCode == 200) {
      
      return response.data;
    } else {
      throw Exception('Failed to make POST request');
    }
  } catch (e) {
    print("Error: $e");
    throw Exception('Error while making POST request');
  }
}
