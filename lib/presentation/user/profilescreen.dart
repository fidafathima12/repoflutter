import 'package:bridal_hub/services/artist/editprofile.dart';
import 'package:bridal_hub/services/artist/manageprofike.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:bridal_hub/services/user/editprofile.dart';
import 'package:bridal_hub/services/user/manageprofile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class UserProfileEditScreen extends StatefulWidget {
  final  profile;

  const UserProfileEditScreen({super.key, required this.profile});
  @override
  _UserProfileEditScreenState createState() => _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends State<UserProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool isLoading = false; // Track loading state

  // A mock function to simulate fetching user profile data from an API
  Future<void> _fetchUserProfile() async {
    

    // Mock user profile data (replace this with actual API data fetching logic)
    _nameController.text = widget.profile["name"];
    _emailController.text = widget.profile["email"];
    _phoneController.text = widget.profile["contactno"].toString();
    _addressController.text = widget.profile["address"];
  }

  @override
  void initState() {
    super.initState();
    _fetchUserProfile(); // Fetch user profile when the screen is loaded
  }

  // Function to update profile using the API
  Future<void> updateUserProfileApi(
    String name,
    String email,
    String phone,
    String address,
  ) async {
    setState(() {
      isLoading = true;
    });

    try {
      Dio dio = Dio();

      // Prepare the data to be sent in the request
      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
      });

      // Send the request to update the profile (PUT request in this case)
      Response response = await dio.post(
        '$baseUrl/userprofile/$loginId', // Replace with your API endpoint
        data: formData,
        options: Options(),
      );

      if (response.statusCode == 200) {
        getUserProfile();
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
        title: Text("Edit Profile"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 20),
              // Name field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Email field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Phone field
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Address field
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              // Submit button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Call the API function with the form values
                    updateUserProfileApi(
                      _nameController.text,
                      _emailController.text,
                      _phoneController.text,
                      _addressController.text,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Save Changes',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
