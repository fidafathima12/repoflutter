// import 'package:flutter/material.dart';

// class ViewFeedbacksScreen extends StatelessWidget {
//   // Dummy feedback data
//   final List<Map<String, String>> feedbacks = [
//     {
//       "name": "Alice Johnson",
//       "rating": "5",
//       "feedback": "Amazing service! Highly recommended."
//     },
//     {
//       "name": "Bob Smith",
//       "rating": "4",
//       "feedback": "Good experience, but could improve timing."
//     },
//     {
//       "name": "Clara Lee",
//       "rating": "5",
//       "feedback": "Absolutely loved the attention to detail!"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('View Feedbacks'),
//         backgroundColor: const Color.fromARGB(255, 18, 175, 196),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: feedbacks.length,
//           itemBuilder: (context, index) {
//             final feedback = feedbacks[index];
//             return Card(
//               elevation: 5,
//               margin: const EdgeInsets.only(bottom: 16.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Name: ${feedback["name"]}",
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 5),
//                     Text("Rating: ${feedback["rating"]}/5"),
//                     const SizedBox(height: 5),
//                     Text("Feedback: ${feedback["feedback"]}"),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
