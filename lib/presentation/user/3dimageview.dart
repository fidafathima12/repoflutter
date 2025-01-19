// import 'dart:io';
// import 'package:flutter/material.dart';

// class ResponseScreen extends StatelessWidget {
//   final File resultImage; // The image that you want to display

//   // Constructor to accept the result image
//   ResponseScreen({required this.resultImage});

//   @override
//   Widget build(BuildContext context) {
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
//             // Display the result image
//             Image.file(
//               resultImage,  // Use the result image directly from the File object
//               height: 300,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Image uploaded successfully!",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context); // Navigate back to the previous screen
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
