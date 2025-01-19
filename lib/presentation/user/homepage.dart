import 'package:bridal_hub/login/loginpage.dart';
import 'package:bridal_hub/presentation/user/ThreeDmodelview.dart';
import 'package:bridal_hub/presentation/user/add_complaints.dart';
import 'package:bridal_hub/presentation/user/add_review.dart';
import 'package:bridal_hub/presentation/user/book_artist.dart';
import 'package:bridal_hub/presentation/user/notification.dart';
import 'package:bridal_hub/presentation/user/profilescreen.dart';
import 'package:bridal_hub/presentation/user/search_artist.dart';
import 'package:bridal_hub/presentation/user/view_bookingstatus.dart';
import 'package:bridal_hub/services/artist/manageprofike.dart';
import 'package:bridal_hub/services/artist/viewnotifications.dart';
import 'package:bridal_hub/services/artist/viewreview.dart';
import 'package:bridal_hub/services/user/manageprofile.dart';
import 'package:bridal_hub/services/user/searchartist.dart';
import 'package:bridal_hub/services/user/viewbookingstatus.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class BridalEleganceHome extends StatefulWidget {
  @override
  State<BridalEleganceHome> createState() => _BridalEleganceHomeState();
}

class _BridalEleganceHomeState extends State<BridalEleganceHome> {
  @override
  void initState() {
    getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        title: Text(
          'Bridal Elegance',
          style: TextStyle(
            fontFamily: 'Cursive',
            fontSize: 24,
            color: Colors.white70,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () async {
              List<Map<String, dynamic>> notifications =
                  await viewNotificationApi();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Not()),
              );
            },
          ),
          // IconButton(
          //   icon: Icon(
          //     Icons.logout, // Change icon to logout for clarity
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: Text("Logout"),
          //           content: Text("Are you sure you want to log out?"),
          //           actions: [
          //             TextButton(
          //               child: Text("Cancel"),
          //               onPressed: () {
          //                 Navigator.of(context).pop(); // Close the dialog
          //               },
          //             ),
          //             TextButton(
          //               child: Text("Logout"),
          //               onPressed: () {
          //                 // Navigator.of(context).pop(); // Close the dialog
          //                 // Perform the logout action here
          //                 Navigator.pushReplacement(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => LoginPage()),
          //                 ); // Example logout action
          //               },
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //   },
          // ),
          IconButton(
            icon: Icon(
              Icons.rotate_right,
              color: Colors.white,
            ), // Or use rotate_left
            onPressed: () {
              // Navigate to 3D model page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DressUploadScreen(), // Replace with your 3D model page
                ),
              );
            },
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[900],
              ),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      profiledata['name'] ??
                          "", // Replace with actual user's name
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      profiledata["email"] ??
                          "", // Replace with actual email or user info
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Profile Button
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                getUserProfile();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserProfileEditScreen(
                          profile:
                              profiledata)), // Create ProfileScreen as per your requirements
                );
              },
            ),
            // Review Button
            // ListTile(
            //   leading: Icon(Icons.star),
            //   title: Text('Review'),
            //   onTap: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => AddReviewScreen()),
            //     // );
            //   },
            // ),
            // Logout Button
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure you want to log out?"),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          child: Text("Logout"),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            ); // Example logout action
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner with Image Carousel
            ScrollableImageCarousel(),
            SizedBox(height: 20),
            // Feature Buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureButton(
                    context,
                    'Search for Artist',
                    Icons.search,
                    Colors.teal,
                    () async {
                      List<Map<String, dynamic>> artistes =
                          await getArtistesApi();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchArtistScreen()),
                      );
                    },
                  ),
                  _buildFeatureButton(
                    context,
                    'Booking Status',
                    Icons.calendar_today,
                    Colors.purple,
                    () async {
                      List<Map<String, dynamic>> booking =
                          await userViewbookingsApi();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingStatusScreen()),
                      );
                    },
                  ),
                  _buildFeatureButton(
                    context,
                    'Profille',
                    Icons.star,
                    Colors.amber,
                    () async {
                      // List<Map<String, dynamic>>reviews=await viewReviewApi();
                      getUserProfile();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfileEditScreen(
                                profile:
                                    profiledata)), // Create ProfileScreen as per your requirements
                      );
                    },
                  ),
                  _buildFeatureButton(
                    context,
                    'Add Complaint',
                    Icons.warning,
                    Colors.redAccent,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ComplaintScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton(BuildContext context, String label, IconData icon,
      Color color, destinationScreen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.all(16),
      ),
      onPressed: destinationScreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: Colors.white),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}

class ScrollableImageCarousel extends StatefulWidget {
  @override
  _ScrollableImageCarouselState createState() =>
      _ScrollableImageCarouselState();
}

class _ScrollableImageCarouselState extends State<ScrollableImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Decorated image carousel
        Container(
          height: 200,
          margin: EdgeInsets.symmetric(vertical: 10.0), // Add some spacing
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black26, // Shadow color
                blurRadius: 8, // Softness of the shadow
                offset: Offset(0, 4), // Shadow position
              ),
            ],
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Same rounded corners
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                Image.asset(
                  'assets/bridef.jpg',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/makeupf.jpg',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/mehandif.jpg',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/photographyf.jpg',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
              width: _currentPage == index ? 12.0 : 8.0,
              height: _currentPage == index ? 12.0 : 8.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? Colors.green : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}
