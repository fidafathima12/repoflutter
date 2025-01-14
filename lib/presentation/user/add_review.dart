import 'package:bridal_hub/services/artist/adddressmodels.dart';
import 'package:bridal_hub/services/artist/viewreview.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:bridal_hub/services/user/addfeedback.dart';
import 'package:flutter/material.dart';

class AddReviewScreen extends StatefulWidget {
  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  double _rating = 3.0;
  final _reviewController = TextEditingController();

  // Function to submit the review
void _submitReview() {
  if (_reviewController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please write a review before submitting!")),
    );
    return;
  }

 
  addReviewApi({
    'userid': loginId,
    'review': _reviewController.text,
    'rating': _rating, 
  }, context).then((response) {
  
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Review submitted successfully!")),
    );
    _reviewController.clear();
    setState(() {
      _rating = 3.0;
    });
  }).catchError((error) {
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error submitting review: $error")),
    );
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Review",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white60),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),

            // Rating Section
            Text(
              "Rate the Service:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star,
                    color: _rating >= 1 ? Colors.orange : Colors.grey),
                Icon(Icons.star,
                    color: _rating >= 2 ? Colors.orange : Colors.grey),
                Icon(Icons.star,
                    color: _rating >= 3 ? Colors.orange : Colors.grey),
                Icon(Icons.star,
                    color: _rating >= 4 ? Colors.orange : Colors.grey),
                Icon(Icons.star,
                    color: _rating == 5 ? Colors.orange : Colors.grey),
              ],
            ),
            Slider(
              value: _rating,
              min: 1.0,
              max: 5.0,
              divisions: 4,
              label: "$_rating Stars",
              activeColor: Colors.orange,
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
            ),

            
            SizedBox(height: 20),
            Text(
              "Write Your Review:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Write your experience here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent),
                ),
              ),
            ),

            // Submit Button
            SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: _submitReview, // Use the submit review function
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                label: Text(
                  "Submit Review",
                  style: TextStyle(color: Colors.white70),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
