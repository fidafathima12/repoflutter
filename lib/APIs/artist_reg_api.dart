// ignore_for_file: avoid_print
import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';

int? reg_res;

Future<void> registerUser(Map<String, dynamic> data) async {
  try {
    final response = await Dio().post(
      '$baseUrl/artistregistrationapi',
      data:FormData.fromMap({
        'name': data['name'],
        'age' : data['age'],
        'gender' : data['gender'],
        'address': data['address'],
        'contactno': data['phonenumber'],
        'experience':data['experience'],
        'username': data['username'],
        'email': data['username'],
        'password': data['password'],
        'Type':"artist"
      })
    );
    print(response.data);
    reg_res = response.statusCode;
    print('**********');
    print(reg_res);
    print('**********//////////////');
    if (reg_res == 201) {
      print('Registration Successful');
    } else {
      print('Registration failed');
    }
  } catch (e) {
    print(e);
  }
}
