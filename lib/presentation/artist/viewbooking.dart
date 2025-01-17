import 'package:bridal_hub/services/artist/managebooking.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AdminViewBookingsScreen extends StatelessWidget {
  // Function to fetch bookings from the API
  Future<List<Map<String, dynamic>>> artistviewBookingsApi() async {
    try {
      Response response = await Dio().get('$baseUrl/bookings/$loginId/');
      print(response);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response.data);
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while making GET request');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "View Bookings",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white60),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(  // Fetch data asynchronously
          future: artistviewBookingsApi(),
          builder: (context, snapshot) {
            // Show loading indicator while waiting for data
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Handle errors (like network failure, invalid response, etc.)
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            // If the data is fetched successfully
            if (snapshot.hasData) {
              List<Map<String, dynamic>> bookings = snapshot.data!;

              return ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];

                  // Check if booking is already accepted or rejected (You can add a status in the data structure)
                  bool isAccepted = booking["status"] == "accepted";
                  bool isRejected = booking["status"] == "rejected";

                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Booking: ${booking["service"]}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text("Date: ${booking["date"]}"),
                          Text("Location: ${booking["location"]}"),
                          Text("Paymentmethod:  ${booking["paymentmethod"]}"),
                          Text("Username:  ${booking["user_name"]}"),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Display Accept button only if booking is not accepted or rejected
                              if (!isAccepted && !isRejected) 
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Prepare the data for the accepted booking
                                    Map<String, dynamic> data = {
                                      'id': booking['id'], 
                                      // Sending bookingId
                                    };

                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Booking Accepted'),
                                        content: const Text(
                                            'You have successfully accepted the booking.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                    approverequestApi(data); 
                                  },
                                  icon: const Icon(Icons.check),
                                  label: const Text('Accept'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                  ),
                                ),
                              // Display Reject button only if booking is not accepted or rejected
                              if (!isAccepted && !isRejected)
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Prepare the data for the rejected booking
                                    Map<String, dynamic> data = {
                                      'id': booking['id'], // Sending bookingId
                                    };

                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Booking Rejected'),
                                        content: const Text(
                                            'You have rejected the booking.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                    rejectRequestApi(data);  // Call API to reject the booking
                                  },
                                  icon: const Icon(Icons.close),
                                  label: const Text('Reject'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            // If no data is available
            return const Center(child: Text('No bookings available.'));
          },
        ),
      ),
    );
  }
}
