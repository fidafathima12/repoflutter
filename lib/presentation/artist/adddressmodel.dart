import 'dart:io';

import 'package:bridal_hub/services/artist/adddressmodels.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this dependency to pick images

class AddDressModelScreen extends StatefulWidget {
  @override
  _AddDressModelScreenState createState() => _AddDressModelScreenState();
}

class _AddDressModelScreenState extends State<AddDressModelScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<File> _images = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Dress Model'),
        backgroundColor: const Color.fromARGB(255, 18, 175, 196),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title
              Center(
                child: Text(
                  'Add a New Dress Model',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),

              // Dress Name Field
              _buildTextField(
                controller: _nameController,
                labelText: 'Dress Name',
                hintText: 'Enter dress name',
              ),
              SizedBox(
                height: 10,
              ),

              // Description Field
              _buildTextField(
                controller: _descriptionController,
                labelText: 'Description',
                hintText: 'Enter dress description',
                maxLines: 3,
              ),
              SizedBox(
                height: 10,
              ),
              // Price Field
              _buildTextField(
                controller: _priceController,
                labelText: 'Price',
                hintText: 'Enter dress price',
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),

              // Size Field
              _buildTextField(
                controller: _sizeController,
                labelText: 'Size',
                hintText: 'Enter dress size (S, M, L, etc.)',
              ),
              SizedBox(
                height: 10,
              ),
              // Color Field
              _buildTextField(
                controller: _colorController,
                labelText: 'Color',
                hintText: 'Enter dress color',
              ),

              // Image Picker
              SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Pick Image'),
                  ),
                  SizedBox(width: 10),
                  if (_image != null)
                    Text(
                      'Image selected',
                      style: TextStyle(color: Colors.green),
                    ),
                ],
              ),

              // Submit Button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // if (_formKey.currentState?.validate() ?? false) {
                  addDressModelsApi({
                    // 'userid':loginId,
                    "dressname": _nameController.text,
                    "size": _sizeController.text,
                    "color": _colorController.text,
                    "price": _priceController.text,
                    "description": _descriptionController.text
                  }, File(_image!.path), context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Dress Model added successfully!'),
                  ));
                },
                child: Text('Add Dress Model'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build the text form field
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText is required';
        }
        return null;
      },
    );
  }
}
