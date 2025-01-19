import 'package:bridal_hub/presentation/user/paymentsucess.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:bridal_hub/services/user/addpayment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  final String artisid;
  final String artisname;
  final String userid;
  final String service;
  final DateTime selectedDate;
  final String selectedTime;
  final String location;
    final int dressid;

  // Constructor to accept the selected details
  PaymentScreen({
    required this.artisid,
    required this.userid,
    required this.artisname,
    required this.service,
    required this.selectedDate,
    required this.selectedTime, required this.location, required this.dressid,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;

  // Format the selectedDate to display only the date in 'yyyy-MM-dd' format
  String formattedDate = "";

  @override
  void initState() {
    super.initState();
    // Formatting the selected date to show only the date part (no time)
    formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          "Payment",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Summary
            Text(
              "Booking Summary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Artist Name: ${widget.artisname}",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text("Service: ${widget.service}"),
                    SizedBox(height: 5),
                    Text("Date: $formattedDate"), // Display only the formatted date
                    SizedBox(height: 5),
                    // Text("Time: ${widget.selectedTime}"), // If you don't want time, you can remove this line
                    SizedBox(height: 5),
                    Text(
                      "Total Cost: ₹5000",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Payment Method
            Text(
              "Choose Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            PaymentMethodTile(
              title: "Credit/Debit Card",
              icon: Icons.credit_card,
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value;
                });
              },
            ),
            PaymentMethodTile(
              title: "UPI",
              icon: Icons.payment,
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value;
                });
              },
            ),
            PaymentMethodTile(
              title: "Wallet",
              icon: Icons.account_balance_wallet,
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value;
                });
              },
            ),
            PaymentMethodTile(
              title: "Net Banking",
              icon: Icons.language,
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value;
                });
              },
            ),
            SizedBox(height: 20),
            // Pay Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedPaymentMethod != null) {
                    addPaymentApi({
                      "paymentmethod": selectedPaymentMethod,
                      "amount": 1000,
                      
                       "userid":loginId,
                      "service": widget.service,
                      "booking_date": formattedDate,
                      "location":widget.location,
                      // "artistid":widget.artisid,
                      "dressid":widget.dressid,
                    }, context);

                    // Navigate to confirmation or bookings page
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please select a payment method!"),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Pay Now",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  PaymentMethodTile({
    required this.title,
    required this.icon,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.pinkAccent),
        title: Text(title),
        trailing: Radio<String>(
          value: title,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
