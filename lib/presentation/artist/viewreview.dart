import 'package:flutter/material.dart';

class ViewReviewsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;  // Accept reviews as a parameter

  // Constructor to initialize reviews data
  ViewReviewsScreen({required this.reviews});

  // Method to build rating stars
  Widget _buildRatingStars(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(
            Icons.star,
            color: Colors.orange,
            size: 18,
          );
        } else if (index == fullStars && hasHalfStar) {
          return Icon(
            Icons.star_half,
            color: Colors.orange,
            size: 18,
          );
        } else {
          return Icon(
            Icons.star_border,
            color: Colors.grey,
            size: 18,
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Reviews",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 18, 175, 196),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey[200]!],
          ),
        ),
        child: ListView.separated(
          itemCount: reviews.length,
          separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
          itemBuilder: (context, index) {
            final review = reviews[index];
            // Safely parse the rating (assuming it's a string)
            double rating = double.tryParse(review["rating"].toString()) ?? 0.0;

            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Info and Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          review["userid_name"], // Displaying user's name
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        _buildRatingStars(rating), // Displaying rating stars
                      ],
                    ),
                    SizedBox(height: 10),
                    // Review Text
                    Text(
                      review["review"], // Displaying review text
                      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
