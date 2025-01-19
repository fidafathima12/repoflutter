// import 'dart:io';
// import 'dart:typed_data';
// import 'package:bridal_hub/presentation/user/show_image.dart';
// import 'package:bridal_hub/services/loginApi.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';

// class DressUploadScreen extends StatefulWidget {
//   @override
//   _DressUploadScreenState createState() => _DressUploadScreenState();
// }

// class _DressUploadScreenState extends State<DressUploadScreen> {
//   XFile? _modelImage;
//   final _picker = ImagePicker();

//   final List<String> _dressAssets = [
//     "assets/la5.png",
//     "assets/la1.png",
//     "assets/la4.png",
//     "assets/la3.png"
//   ];

//   String? _selectedDress;

//   Future<void> _pickModelImage() async {
//     final pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     setState(() {
//       _modelImage = pickedFile;
//     });
//   }

//   // Function to get the file path in a writable directory
//   Future<String> _getImageSavePath() async {
//     final directory =
//         await getApplicationDocumentsDirectory(); // Get the app's document directory
//     return '${directory.path}/result.png'; // Save the image as result.png
//   }

// Future<void> uploadImages(File modelImage, String dressAssetPath) async {
//   final dio = Dio();
//   final String url = '$baseUrl/DressProcessor';

//   try {
//     // Load the dress image asset as bytes
//     ByteData data = await rootBundle.load(dressAssetPath);
//     Uint8List dressImageBytes = data.buffer.asUint8List();

//     FormData formData = FormData.fromMap({
//       'modelpath': await MultipartFile.fromFile(modelImage.path, filename: 'model.jpg'),
//       'dresspath': MultipartFile.fromBytes(dressImageBytes, filename: 'dress.png'),
//     });

//     Response response = await dio.post(url, data: formData);
//     print("Response: ${response.data}");

//     // Check if the response is successful
//     if (response.statusCode == 200) {
//       if (response.data is Map<String, dynamic>) {
//         var responseData = response.data as Map<String, dynamic>;
//         String? outputImageUrl = responseData['image'];

//         // Check if the output image URL is valid
//         if (outputImageUrl != null && outputImageUrl.isNotEmpty) {
//           // Navigate to the Response Screen with the image URL
//           Navigator.pushReplacement( // Use pushReplacement instead of push to ensure the screen is rebuilt
//             context,
//             MaterialPageRoute(
//               builder: (context) => ResponseScreen(imageUrl: outputImageUrl),
//             ),
//           );
//           _clearSelections();  // Clear selections after successful upload
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Failed to generate the image")),
//           );
//         }
//       }
//     } else {
//       print('Failed to process image: ${response.statusCode}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to process the image")),
//       );
//     }
//   } catch (e) {
//     print('Error uploading images: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Error uploading images")),
//     );
//   }
// }


// void _clearSelections() {
//   setState(() {
//     _modelImage = null;
//     _selectedDress = null;
//   });
// }
// // Future<void> uploadImages(File modelImage, File dressImage) async {
//   //   final dio = Dio();
//   //   final String url = 'http://192.168.32.98:5000//DressProcessor';

//   //   try {
//   //     FormData formData = FormData.fromMap({
//   //       'modelpath': await MultipartFile.fromFile(modelImage.path, filename: 'model.jpg'),
//   //       'dresspath': await MultipartFile.fromFile(dressImage.path, filename: 'dress.png'),
//   //     });

//   //     Response response = await dio.post(
//   //       url,
//   //       data: formData,

//   //     );
//   //     if (response.statusCode == 200) {
//   //       // Check if the server returned binary data (image)
//   //       if (response.data is List<int>) {
//   //         List<int> bytes = response.data;
//   //         String resultImagePath = await _getImageSavePath();

//   //         // Save the image to the app's document directory
//   //         File resultImage = File(resultImagePath);
//   //         await resultImage.writeAsBytes(bytes);
//   //         print("ressssssssss$resultImage");

//   //         // Navigate to the Response Screen with the result image
//   //         Navigator.push(
//   //           context,
//   //           MaterialPageRoute(
//   //             builder: (context) => ResponseScreen(resultImage: resultImage),
//   //           ),
//   //         );
//   //       } else if (response.data is String) {
//   //         // If the response is a URL string
//   //         String resultImageUrl = response.data;
//   //         print("resppppppp$resultImageUrl");

//   //         Navigator.push(
//   //           context,
//   //           MaterialPageRoute(
//   //             builder: (context) => ResponseScreen(imageUrl: resultImageUrl),
//   //           ),
//   //         );
//   //       }
//   //     } else {
//   //       print('Failed to process image: ${response.statusCode}');
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text("Failed to process the image")),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     print('Error uploading images: $e');
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text("Error uploading images")),
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Dress Upload',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.blue[900],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Select Dress Image Section
//               Text("Select Dress Image",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 10),
//               Container(
//                 height: 180,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: _dressAssets.length,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedDress = _dressAssets[index];
//                         });
//                       },
//                       child: Container(
//                         margin: EdgeInsets.only(right: 10),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: _selectedDress == _dressAssets[index]
//                                 ? Colors.blue
//                                 : Colors.grey,
//                             width: 3,
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Image.asset(
//                           _dressAssets[index],
//                           width: 120,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),

//               // Display selected model image
//               _modelImage != null
//                   ? Image.file(
//                       File(_modelImage!.path),
//                       height: 200,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     )
//                   : Container(
//                       color: Colors.grey[200],
//                       height: 200,
//                       width: double.infinity,
//                       child: Icon(Icons.image, size: 100, color: Colors.grey),
//                     ),
//               SizedBox(height: 20),

//               // Button to select model image
//               ElevatedButton.icon(
//                 icon: Icon(Icons.camera_alt),
//                 label: Text('Select Model Image',
//                     style: TextStyle(color: Colors.white)),
//                 onPressed: _pickModelImage,
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   backgroundColor: Colors.blue[900],
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),

//               // Upload Button
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _selectedDress != null && _modelImage != null
//                       ? () {
//                           uploadImages(
//                               File(_modelImage!.path), _selectedDress!);
//                         }
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     backgroundColor: Colors.blue[900],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: Text(
//                     "Upload Images",
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ResponseScreen extends StatelessWidget {
//   final String? imageUrl;

//   ResponseScreen({this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     print("Displaying image: $imageUrl");  // Debug: Print the image URL

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Upload Result", style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.blue[900],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Check if imageUrl is provided
//             if (imageUrl != null && imageUrl!.isNotEmpty)
//               Image.network(
//                 "${baseUrl}${imageUrl!}",
//                 height: 500,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             SizedBox(height: 20),
//             Text(
//               "Image uploaded successfully!",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);  // Go back to the upload screen
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                 backgroundColor: Colors.blue[900],
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               child: Text(
//                 "Back to Upload",
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:typed_data';
import 'package:bridal_hub/presentation/user/show_image.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class DressUploadScreen extends StatefulWidget {
  @override
  _DressUploadScreenState createState() => _DressUploadScreenState();
}

class _DressUploadScreenState extends State<DressUploadScreen> {
  XFile? _modelImage;
  final _picker = ImagePicker();

  final List<String> _dressAssets = [
    "assets/la5.png",
    "assets/la1.png",
    "assets/la4.png",
    "assets/la3.png"
  ];

  String? _selectedDress;

  Future<void> _pickModelImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _modelImage = pickedFile;
    });
  }

  // Function to get the file path in a writable directory
  Future<String> _getImageSavePath() async {
    final directory = await getApplicationDocumentsDirectory(); // Get the app's document directory
    return '${directory.path}/result.png'; // Save the image as result.png
  }

  Future<void> uploadImages(File modelImage, String dressAssetPath) async {
    final dio = Dio();
    final String url = '$baseUrl/DressProcessor';

    try {
      // Load the dress image asset as bytes
      ByteData data = await rootBundle.load(dressAssetPath);
      Uint8List dressImageBytes = data.buffer.asUint8List();

      FormData formData = FormData.fromMap({
        'modelpath': await MultipartFile.fromFile(modelImage.path, filename: 'model.jpg'),
        'dresspath': MultipartFile.fromBytes(dressImageBytes, filename: 'dress.png'),
      });

      Response response = await dio.post(url, data: formData);
      print("Response: ${response.data}");

      // Check if the response is successful
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          var responseData = response.data as Map<String, dynamic>;
          String? outputImageUrl = responseData['image'];

          // Check if the output image URL is valid
          if (outputImageUrl != null && outputImageUrl.isNotEmpty) {
            // Navigate to the Response Screen with the image URL
            Navigator.pushReplacement( // Use pushReplacement instead of push to ensure the screen is rebuilt
              context,
              MaterialPageRoute(
                builder: (context) => ResponseScreen(imageUrl: outputImageUrl),
              ),
            );
            _clearSelections();  // Clear selections after successful upload
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to generate the image")),
            );
          }
        }
      } else {
        print('Failed to process image: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to process the image")),
        );
      }
    } catch (e) {
      print('Error uploading images: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading images")),
      );
    }
  }

  void _clearSelections() {
    setState(() {
      _modelImage = null;
      _selectedDress = null;
    });
  }

  Future<void> _refresh() async {
    // Reset the form's state when pulling to refresh
    setState(() {
      _clearSelections();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dress Upload',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh, // Triggered on pull-to-refresh
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Select Dress Image Section
                Text("Select Dress Image",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Container(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _dressAssets.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDress = _dressAssets[index];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedDress == _dressAssets[index]
                                  ? Colors.blue
                                  : Colors.grey,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            _dressAssets[index],
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),

                // Display selected model image
                _modelImage != null
                    ? Image.file(
                        File(_modelImage!.path),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Colors.grey[200],
                        height: 200,
                        width: double.infinity,
                        child: Icon(Icons.image, size: 100, color: Colors.grey),
                      ),
                SizedBox(height: 20),

                // Button to select model image
                ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  label: Text('Select Model Image',
                      style: TextStyle(color: Colors.white)),
                  onPressed: _pickModelImage,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Upload Button
                Center(
                  child: ElevatedButton(
                    onPressed: _selectedDress != null && _modelImage != null
                        ? () {
                            uploadImages(
                                File(_modelImage!.path), _selectedDress!);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Upload Images",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResponseScreen extends StatelessWidget {
  final String? imageUrl;

  ResponseScreen({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    print("Displaying image: $imageUrl");  // Debug: Print the image URL

    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Result", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Check if imageUrl is provided
            if (imageUrl != null && imageUrl!.isNotEmpty)
              Image.network(
                "${baseUrl}${imageUrl!}",
                height: 500,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 20),
            Text(
              "Image uploaded successfully!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);  // Go back to the upload screen
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Colors.blue[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Back to Upload",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
