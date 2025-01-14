import 'package:bridal_hub/presentation/artist/Homescreen.dart';
import 'package:bridal_hub/presentation/user/homepage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


  final Dio _dio = Dio();
   String baseUrl = 'http://192.168.1.161:5000';
   int? loginId;
   String? userType;

  Future<Map<String, dynamic>> loginFunction(String username, String password,context) async {
    try {
      // Replace with your API endpoint
     

      // Creating the request data
      var requestData = {
        'username': username,
        'password': password,
      };

      // Sending POST request
      Response response = await _dio.post('$baseUrl/loginapi', data: requestData);
      print(response.data);

      // Checking if the request was successful
      if (response.statusCode == 200&&response.data['message']=='success') {
        loginId=response.data['login_id'];
        userType=response.data['user_type'];
        
        if (userType=='user') {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BridalEleganceHome()));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        }

        // Return the response data as a map (you can customize it as per your API response)
        return response.data; 
      } else {
        print("failed");
      }
    }
    catch(e){
      print(e);
      return {};
    }
    return {};
  }

