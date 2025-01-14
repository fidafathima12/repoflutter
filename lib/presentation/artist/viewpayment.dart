// import 'package:flutter/material.dart';

// class PaymentDetailsScreen extends StatelessWidget {
//   final String artistName;
//   final String service;
//   final String selectedDate;
//   final String selectedTime;
//   final String paymentMethod;
//   final double totalCost;

//   PaymentDetailsScreen({
//     required this.artistName,
//     required this.service,
//     required this.selectedDate,
//     required this.selectedTime,
//     required this.paymentMethod,
//     this.totalCost = 5000.0, // Default cost
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue[900],
//         title: const Text(
//           "Payment Details",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Section Header
//             const Text(
//               "Payment Summary",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             // Payment Details Card
//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildInfoRow("Artist Name", artistName),
//                     _buildInfoRow("Service", service),
//                     _buildInfoRow("Date", selectedDate),
//                     _buildInfoRow("Time", selectedTime),
//                     _buildInfoRow("Payment Method", paymentMethod),
//                     const SizedBox(height: 10),
//                     Text(
//                       "Total Cost: ₹${totalCost.toStringAsFixed(2)}",
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: Colors.green),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             // Decorative Icon and Thank You Message
      
//             const SizedBox(height: 30),
//             // Navigation Button
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue[900],
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text(
//                   "Go Back",
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper method for building rows of information
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "$label:",
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:bridal_hub/services/artist/viewpayment.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';  // You can use Dio to make HTTP requests.

class PaymentDetailsScreen extends StatefulWidget {
  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  // This will store the list of payments.
  List<Map<String, dynamic>> payments = [];

  // This will manage the loading state of the API request.
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPayments();
  }

  // Function to fetch payments
  Future<void> fetchPayments() async {
    try {
      final Dio _dio = Dio();
      // Replace with your actual API endpoint
     Response response = await _dio.get('$baseUrl/ArtistPaymentStatus/$loginId');

      if (response.statusCode == 200) {
        setState(() {
          payments = List<Map<String, dynamic>>.from(response.data);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load payments');
      }
    } catch (e) {
      print('Error fetching payments: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text(
          "Payment Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment Summary",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Display loading indicator if data is still being fetched
            if (isLoading)
              const Center(child: CircularProgressIndicator()),

            // Show payments list if data is fetched
            if (!isLoading && payments.isNotEmpty) 
              ListView.builder(
                shrinkWrap: true,
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  final payment = payments[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow("Artist Name", payment['user_name'] ?? 'N/A'),
                          _buildInfoRow("Service", payment['service']),
                          _buildInfoRow("Date", payment['date']),
                          _buildInfoRow("Time", payment['booking_date']),
                          _buildInfoRow("Payment Method", payment['paymentmethod']),
                          const SizedBox(height: 10),
                          Text(
                            "Total Cost: ₹${payment['amount'].toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

            // Show message if no payments found
            if (!isLoading && payments.isEmpty)
              const Center(child: Text('No payments found.')),
            
            const SizedBox(height: 30),

            // Navigation Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Go Back",
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
    );
  }

  // Helper method for building rows of information
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
