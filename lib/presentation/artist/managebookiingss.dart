import 'package:flutter/material.dart';

class ManageBookingPage extends StatelessWidget {
  const ManageBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data for the booking
    final imageUrl =
        'https://via.placeholder.com/150'; // Replace with your image URL
    final imageDescription =
        'A beautiful place for your next vacation. Enjoy the serenity and nature.';
    final userDetails = {
      'Name': 'John Doe',
      'Email': 'johndoe@example.com',
      'Phone': '+1234567890',
      'Booking Date': '2024-12-15',
      'Name': 'John Doe',
      'Email': 'johndoe@example.com',
      'Phone': '+1234567890',
      'Booking Date': '2024-12-15',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Booking'),
        backgroundColor: const Color.fromARGB(255, 18, 175, 196),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Center(
              child: Image.network(imageUrl),
            ),
            const SizedBox(height: 16.0),
            // Image description
            Text(
              imageDescription,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16.0),
            // User details section
            const Text(
              'Booking Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            ...userDetails.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '${entry.key}: ${entry.value}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // Accept / Reject buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle "Accept" action
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
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle "Reject" action
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Booking Rejected'),
                        content: const Text('You have rejected the booking.'),
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
  }
}
