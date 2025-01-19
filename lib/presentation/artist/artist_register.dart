import 'package:animate_do/animate_do.dart';
import 'package:bridal_hub/APIs/artist_reg_api.dart';
import 'package:bridal_hub/login/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
      if (reg_res == 201 || reg_res == 200) {
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
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Name Field
                  FadeInUp(
                    duration: Duration(milliseconds: 1200),
                    child: _buildTextField('Name', Icons.person, (value) {
                      _name = value;
                    }, 'Please enter your name'),
                  ),
                  const SizedBox(height: 20),
                  // Age Field
                  FadeInUp(
                    duration: Duration(milliseconds: 1400),
                    child: _buildTextField('Age', Icons.cake, (value) {
                      _age = int.tryParse(value!);
                    }, 'Please enter a valid age', isNumber: true),
                  ),
                  const SizedBox(height: 20),
                  // Experience Dropdown Field
                  FadeInUp(
                    duration: Duration(milliseconds: 1600),
                    child: _buildDropdownField('Experience (in years)', Icons.work),
                  ),
                  const SizedBox(height: 20),
                  // Gender Selection
                  FadeInUp(
                    duration: Duration(milliseconds: 1800),
                    child: _buildGenderSelection(),
                  ),
                  const SizedBox(height: 20),
                  // Phone Field
                  FadeInUp(
                    duration: Duration(milliseconds: 2000),
                    child: _buildPhoneField(),
                  ),
                  const SizedBox(height: 20),
                  // Address Field
                  FadeInUp(
                    duration: Duration(milliseconds: 2200),
                    child: _buildTextField('Address', Icons.home, (value) {
                      _address = value;
                    }, 'Please enter your address'),
                  ),
                  const SizedBox(height: 20),
                  // Email Field
                  FadeInUp(
                    duration: Duration(milliseconds: 2400),
                    child: _buildTextField('Email', Icons.email, (value) {
                      _email = value;
                    }, 'Please enter your email'),
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  FadeInUp(
                    duration: Duration(milliseconds: 2600),
                    child: _buildTextField('Password', Icons.lock, (value) {
                      _password = value;
                    }, 'Password must be at least 6 characters long', isPassword: true),
                  ),
                  const SizedBox(height: 20),
                  // Submit Button
                  FadeInUp(
                    duration: Duration(milliseconds: 2800),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: _submitForm,
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String labelText, IconData icon, Function(String?) onSaved, String validatorMessage,
      {bool isPassword = false, bool isNumber = false}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      obscureText: isPassword,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        if (labelText == 'Email' && !RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
          return 'Enter a valid email address';
        }
        if (labelText == 'Password' && value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(String labelText, IconData icon) {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      value: _experience,
      onChanged: (value) {
        setState(() {
          _experience = value;
        });
      },
      items: List.generate(15, (index) => index + 1).map((experience) {
        return DropdownMenuItem<int>(
          value: experience,
          child: Text(experience.toString()),
        );
      }).toList(),
      validator: (value) => value == null ? 'Please select your experience' : null,
    );
  }

  Widget _buildGenderSelection() {
    return Row(
      children: [
        const Text('Gender:', style: TextStyle(fontSize: 12)),
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
            title: const Text('Female',style: TextStyle(fontSize:12)),
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
    );
  }

  Widget _buildPhoneField() {
    return IntlPhoneField(
      decoration: InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      initialCountryCode: 'IN',
      onChanged: (phone) => _phone = phone.completeNumber,
    );
  }
}
