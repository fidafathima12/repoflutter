import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io'; // For file handling (if you want to upload an image)
import 'package:image_picker/image_picker.dart'; // For selecting image

class EditProfilePage extends StatefulWidget {
  final profile;

  const EditProfilePage({super.key, required this.profile});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phoneNumber = '';
  String email = '';
  String experience = '';
  bool isLoading = false;

  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  TextEditingController _experiencecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with current values (if available)
    _namecontroller.text = widget.profile['name'] ?? '';
    _phonecontroller.text = widget.profile['contactno'].toString() ?? '';
    _experiencecontroller.text = widget.profile['experience'] ?? '';
    _emailcontroller.text = widget.profile['email'] ?? '';
  }

  // Function to update the profile API
  Future<void> updateProfileApi(
    String name,
    String experience,
    String email,
    String phone,
  ) async {
    setState(() {
      isLoading = true;
    });

    try {
      Dio dio = Dio();

      // Prepare the data to be sent in the request
      FormData formData = FormData.fromMap({
        'name': name,
        'experience': experience,
        'email': email,
        'phone': phone,
      });

      // Send the request to update the profile (POST or PUT depending on your API)
      Response response = await dio.put(
        '$baseUrl/artistprofile/$loginId', // Replace with your API endpoint
        data: formData,
        options: Options(
          
        ),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile')),
        );
      }
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: const Color.fromARGB(255, 18, 175, 196),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Update Your Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _buildTextField(
                      controller: _namecontroller,
                      label: 'Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      controller: _experiencecontroller,
                      label: 'Experience',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your experience';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      controller: _phonecontroller,
                      label: 'Phone Number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      controller: _emailcontroller,
                      label: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    isLoading
                        ? CircularProgressIndicator() // Show loading indicator
                        : ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Call the API method to update profile
                                await updateProfileApi(
                                  _namecontroller.text,
                                  _experiencecontroller.text,
                                  _emailcontroller.text,
                                  _phonecontroller.text,
                                );
                              }
                            },
                            child: Text(
                              'Save Changes',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 18, 175, 196),
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required FormFieldValidator<String>? validator,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,  // Use the passed controller here
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
      ),
    );
  }
}
