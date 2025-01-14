import 'package:bridal_hub/services/artist/addpreviouswork.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PreviousWork extends StatefulWidget {
  const PreviousWork({super.key});

  @override
  _PreviousWorkState createState() => _PreviousWorkState();
}

class _PreviousWorkState extends State<PreviousWork> {
  final List<File> _images = []; // List to store selected images
  final ImagePicker _picker = ImagePicker();
  String? _selectedCategory; // To store selected category

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _captureImage() async {
    final XFile? capturedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (capturedFile != null) {
      setState(() {
        _images.add(File(capturedFile.path));
      });
    }
  }
  TextEditingController detailsController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ADD PREVIOUS WORK",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 18, 175, 196),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Showcase Your Work',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 18, 175, 196),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: detailsController,
                decoration: InputDecoration(
                  labelText: 'Work Details',
                  hintText: 'Describe your previous work',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
                value: _selectedCategory,
                hint: const Text('Select a category'),
                items: const [
                  DropdownMenuItem(
                    value: 'Photographer',
                    child: Text('Photographer'),
                  ),
                  DropdownMenuItem(
                    value: 'Beautician',
                    child: Text('Beautician'),
                  ),
                  DropdownMenuItem(
                    value: 'Mehendi Designer',
                    child: Text('Mehendi Designer'),
                  ),
                  DropdownMenuItem(
                    value: 'Personal Assistant',
                    child: Text('Personal Assistant'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color.fromARGB(255, 0, 33, 197),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                ),
                onPressed: _pickImage,
                icon: const Icon(Icons.photo_library),
                label: const Text('Add Photo from Gallery',style: TextStyle(color: Colors.white),),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color.fromARGB(255, 0, 33, 197),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                ),
                onPressed: _captureImage,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Capture Photo using Camera',style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
              if (_images.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _images.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _images.removeAt(index);
                              });
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 33, 197),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async{
                  if (_selectedCategory != null) {
                  
              await    addPreviousWorkApi({
                    'description':detailsController.text,
                    'category':_selectedCategory,
                  },_images[0],context);


                    // print('Category: $_selectedCategory');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a category'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
