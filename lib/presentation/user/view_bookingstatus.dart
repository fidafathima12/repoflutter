import 'package:bridal_hub/presentation/user/add_review.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:bridal_hub/services/artist/viewreview.dart';
import 'package:bridal_hub/services/user/viewbookingstatus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final Dio _dio = Dio();

class BookingStatusScreen extends StatefulWidget {
  @override
  _BookingStatusScreenState createState() => _BookingStatusScreenState();
}

class _BookingStatusScreenState extends State<BookingStatusScreen> {
  List<Map<String, dynamic>> bookings = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    try {
      final response = await userViewbookingsApi();
      setState(() {
        bookings = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking Status",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator()) // Show loading indicator
            : hasError
                ? Center(child: Text("Error loading bookings."))
                : bookings.isEmpty
                    ? Center(child: Text("No bookings available."))
                    : ListView.builder(
                        itemCount: bookings.length,
                        itemBuilder: (context, index) {
                          final booking = bookings[index];
                          print("@@@@@@@@@@@@@$booking");
                          return BookingStatusCard(
                            artistName: booking['artist_name'] ?? 'Artist Name',
                            service: booking['service'] ?? 'Service Name',
                            date: booking['booking_date'] ?? 'Date',
                            status: booking['status'] ?? 'Status',
                            paymentMethod: booking['paymentmethod'] ?? 'no',
                            location: booking['location'] ?? 'Location',
                            amount: booking['amount'] ?? 0.0,
                            artistid: booking['artist_id'].toString()
                          );
                        },
                      ),
      ),
    );
  }
}

class BookingStatusCard extends StatelessWidget {
  final String artistName;
  final String service;
  final String date;
  final String status;
  final String paymentMethod;
  final String location;
  final double amount;
  final String artistid;

  const BookingStatusCard({
    required this.artistName,
    required this.service,
    required this.date,
    required this.status,
    required this.paymentMethod,
    required this.location,
    required this.amount,
    required this.artistid,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Artist Name
            Text(
              "Artist: $artistName",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            // Service
            Text(
              "Service: $service",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            // Date
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.pinkAccent),
                SizedBox(width: 8),
                Text(
                  "Date: $date",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Status
            Row(
              children: [
                Icon(Icons.info, color: Colors.pinkAccent),
                SizedBox(width: 8),
                Text(
                  "Status: $status",
                  style: TextStyle(
                    fontSize: 16,
                    color: status == "confirmed" ? Colors.green : Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Payment Method
            Row(
              children: [
                Icon(Icons.payment, color: Colors.pinkAccent),
                SizedBox(width: 8),
                Text(
                  "Payment Method: $paymentMethod",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Location
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.pinkAccent),
                SizedBox(width: 8),
                Text(
                  "Location: $location",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Amount
            Row(
              children: [
                Icon(Icons.attach_money, color: Colors.pinkAccent),
                SizedBox(width: 8),
                Text(
                  "Amount: ₹$amount",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
         ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddReviewScreen(id: artistid),
      ),
    );
  },
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Colors.blueAccent, // Text color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Button border radius
    ),
    elevation: 10, // Button shadow
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Padding
  ),
  child: Text(
    'Add Review',
    style: TextStyle(
      fontSize: 18, // Text size
      fontWeight: FontWeight.bold, // Text style
    ),
  ),
)

          ],
        ),
      ),
    );
  }
}
