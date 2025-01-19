import 'package:bridal_hub/services/artist/viewnotifications.dart';
import 'package:flutter/material.dart';
import 'package:bridal_hub/services/loginApi.dart'; // Import the API service

class Not extends StatelessWidget {
  const Not({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: viewNotificationApi(),  // Call the API function to fetch notifications
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading spinner while waiting for data
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle error if any
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Handle empty data
            return Center(child: Text('No notifications available.'));
          } else {
            // Display the notifications from the API response
            var notifications = snapshot.data!;
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                var notification = notifications[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      notification['notification'] ?? 'No Title',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(notification['notification'] ?? 'No Notification'),
                    trailing: Text(
                      notification['date'] ?? 'No Date',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onTap: () {
                      // Handle notification tap if needed
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
