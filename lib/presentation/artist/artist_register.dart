import 'package:bridal_hub/APIs/artist_reg_api.dart';
import 'package:bridal_hub/login/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'dart:io';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _email, _phone, _password, _address;
  int? _age, _experience;
  String? _selectedGender;
  bool _isObscured = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }



  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      Map<String, dynamic> data = {
        'name': _name,
        'age': _age,
        'gender': _selectedGender,
        'address': _address,
        'phonenumber': _phone,
        'username': _email,
        'password': _password,
        'experience': _experience,
        
      };
      print('*************');
      print(data);
         print('*************');

      await registerUser(data);
      if (reg_res == 201|| reg_res==200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Registration successful"),
          backgroundColor: Colors.green,
        ));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Registration failed"),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter email and password"),
        backgroundColor: Colors.red,
      ));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
               
               
                const SizedBox(height: 20),
                // Name Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                  onSaved: (value) => _name = value,
                ),
                const SizedBox(height: 20),
                // Age Field
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    prefixIcon: Icon(Icons.cake),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age <= 0) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                  onSaved: (value) => _age = int.tryParse(value!),
                ),
                const SizedBox(height: 20),
                // Experience Dropdown Field
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: 'Experience (in years)',
                    prefixIcon: Icon(Icons.work),
                    border: OutlineInputBorder(),
                  ),
                  value: _experience,
                  onChanged: (value) {
                    setState(() {
                      _experience = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your experience';
                    }
                    return null;
                  },
                  items: List.generate(15, (index) => index + 1).map((experience) {
                    return DropdownMenuItem<int>(
                      value: experience,
                      child: Text(experience.toString()),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                // Gender Selection
                Row(
                  children: [
                    const Text('Gender:', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Male'),
                        value: 'Male',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Female'),
                        value: 'Female',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Phone Field
                IntlPhoneField(
                  decoration:
                      InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
                  initialCountryCode: 'IN',
                  onChanged:(phone) =>_phone=phone.completeNumber ,
                ),
                const SizedBox(height: 20),
                // Address Field
                TextFormField(
                  decoration:
                      InputDecoration(labelText:'Address', prefixIcon : Icon(Icons.home), border : OutlineInputBorder()),
                  validator:(value)=>value!.isEmpty?'Please enter your address':null ,
                  onSaved:(value)=>_address=value ,
                ),
                const SizedBox(height :20),
                // Email Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                  onSaved: (value) => _email = value,
                ),
                const SizedBox(height: 20),
                // Password Field
                TextFormField(
                  obscureText:_isObscured ,
                  decoration : InputDecoration (
                    labelText:'Password',
                    prefixIcon :const Icon(Icons.lock),
                    suffixIcon :IconButton (
                      icon :Icon(_isObscured?Icons.visibility :Icons.visibility_off),
                      onPressed:_togglePasswordVisibility ,
                    ),
                    border :OutlineInputBorder(),
                  ),
                  validator:(value)=>value!.length<6?'Password must be at least 6 characters long':null ,
                  onSaved:(value)=>_password=value ,
                ),
                const SizedBox(height :20),
                // Submit Button
                ElevatedButton (
                  style : ElevatedButton.styleFrom (
                    backgroundColor: Colors.blueAccent ,
                    shape :RoundedRectangleBorder (
                      borderRadius :BorderRadius.circular(30.0)
                    )
                  ),
                  onPressed :_submitForm ,
                  child :const Text ('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}