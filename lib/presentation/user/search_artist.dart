// import 'package:bridal_hub/presentation/user/book_artist.dart';
// import 'package:flutter/material.dart';

// class SearchArtistScreen extends StatefulWidget {
//    final  List<Map<String, dynamic>> artiste;

//   const SearchArtistScreen({super.key, required this.artiste});
//   @override
//   _SearchArtistScreenState createState() => _SearchArtistScreenState();
// }

// class _SearchArtistScreenState extends State<SearchArtistScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = "";
//   String _selectedCategory = "All";

//   // Example list of artists with categories
//   final List<Map<String, dynamic>> _artists = [
//     {
//       "artistName": "Sophia Johnson",
//       "category": "Photographer",
//       "experience": "5 Years",
//       "rating": 4.8,
//       "contact": "+1 9876543210",
//       "email": "sophia.johnson@example.com",
//       "place": "New York, USA",
//       "previousWorks": [
//         "assets/bride1.jpg",
//         "assets/bride2.jpg",
//         "assets/bride3.jpg",
//       ],
//     },
//     {
//       "artistName": "John Smith",
//       "category": "Makeup Artist",
//       "experience": "8 Years",
//       "rating": 4.5,
//       "contact": "+1 8765432109",
//       "email": "john.smith@example.com",
//       "place": "Los Angeles, USA",
//       "previousWorks": [
//         "assets/bride3.jpg",
//         "assets/bride1.jpg",
//         "assets/bride2.jpg",
//       ],
//     },

//   ];

//   @override
//   Widget build(BuildContext context) {
//     // Filtered list of artists based on search query and selected category
//     final filteredArtists = _artists.where((artist) {
//       final matchesSearchQuery = artist["artistName"]
//           .toLowerCase()
//           .contains(_searchQuery.toLowerCase());
//       final matchesCategory = _selectedCategory == "All" ||
//           artist["category"] == _selectedCategory;

//       return matchesSearchQuery && matchesCategory;
//     }).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Bridal Hub",
//           style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'Cursive'),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.blue[900],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [

//               SizedBox(height: 16),

//               // Search TextField
//               TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   labelText: "Search by artist name",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   prefixIcon: Icon(Icons.search),
//                 ),
//                 onChanged: (query) {
//                   setState(() {
//                     _searchQuery = query; // Update search query
//                   });
//                 },
//               ),
//               SizedBox(height: 16),

//               // Display filtered artists
//               Column(
//                 children: filteredArtists.map((artist) {
//                   return ArtistCard(
//                     artistName: artist["artistName"],
//                     category: artist["category"],
//                     experience: artist["experience"],
//                     rating: artist["rating"],
//                     contact: artist["contact"],
//                     email: artist["email"],
//                     place: artist["place"],
//                     previousWorks: List<String>.from(artist["previousWorks"]),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ArtistCard extends StatelessWidget {
//   final String artistName;
//   final String category;
//   final String experience;
//   final double rating;
//   final String contact;
//   final String email;
//   final String place;
//   final List<String> previousWorks;

//   const ArtistCard({
//     required this.artistName,
//     required this.category,
//     required this.experience,
//     required this.rating,
//     required this.contact,
//     required this.email,
//     required this.place,
//     required this.previousWorks,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 8.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Artist Name and Category
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundColor: const Color.fromARGB(255, 190, 194, 199),
//                   child: Text(
//                     artistName[0],
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue[900],
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         artistName,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       // Highlight the category
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.blue[100],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                         child: Text(
//                           category,
//                           style: TextStyle(
//                             color: Colors.blue[900],
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         "Experience: $experience",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Rating
//                 Row(
//                   children: [
//                     Icon(Icons.star, color: Colors.amber, size: 20),
//                     SizedBox(width: 4),
//                     Text(
//                       rating.toString(),
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Divider(color: Colors.grey[300], thickness: 1.0, height: 20),

//             // Contact Details
//             Row(
//               children: [
//                 Icon(Icons.phone, color: Colors.blue[900]),
//                 SizedBox(width: 8),
//                 Text(contact),
//               ],
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Icon(Icons.email, color: Colors.blue[900]),
//                 SizedBox(width: 8),
//                 Text(email),
//               ],
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Icon(Icons.location_on, color: Colors.blue[900]),
//                 SizedBox(width: 8),
//                 Text(place),
//               ],
//             ),

//             Divider(color: Colors.grey[300], thickness: 1.0, height: 20),

//             // Previous Works
//             Text(
//               "Previous Works",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             SizedBox(
//               height: 100,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: previousWorks.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.asset(
//                         previousWorks[index],
//                         width: 100,
//                         height: 100,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 16),

//             // Book Artist Button
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to booking functionality
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => BookArtistScreen()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue[900],
//                 padding: EdgeInsets.symmetric(vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   "Book $category",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:bridal_hub/presentation/user/modelsviewpage.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:bridal_hub/services/user/searchartist.dart';
import 'package:bridal_hub/services/user/viewmodel.dart';
import 'package:flutter/material.dart';
import 'book_artist.dart';

class SearchArtistScreen extends StatefulWidget {
  const SearchArtistScreen({super.key});

  @override
  _SearchArtistScreenState createState() => _SearchArtistScreenState();
}

class _SearchArtistScreenState extends State<SearchArtistScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _selectedCategory = "All";
  List<Map<String, dynamic>> _artists = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchArtists(); // Fetch artists data when screen is initialized
  }

  // Fetch data from API
  Future<void> _fetchArtists() async {
    try {
      List<Map<String, dynamic>> fetchedArtists = await getArtistesApi();
      print(fetchedArtists);
      setState(() {
        _artists = fetchedArtists;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching artists: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bridal Hub",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Cursive'),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 16),

              // Loading indicator while fetching data
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: _artists.map((artist) {
                        return ArtistCard(
                          artistid: artist["id"]?.toString() ?? "no id",
                          artistName: artist["name"] ?? "no name",
                          experience: artist["experience"] ?? "no exp",
                          rating: artist["rating"] != null
                              ? double.tryParse(artist["rating"].toString()) ??
                                  0.0
                              : 2.0,
                          contact:
                              artist["contactno"]?.toString() ?? "no contact",
                          email: artist["email"] ?? "no email",
                          place: artist["address"] ?? "no address",
                          previousWorks:
                              List<String>.from(artist["images"] ?? []),
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArtistCard extends StatelessWidget {
  final String artistid;
  final String artistName;
  final String experience;
  final double rating;
  final String contact;
  final String email;
  final String place;
  final List<String> previousWorks;

  const ArtistCard({
    required this.artistid,
    required this.artistName,
    required this.experience,
    required this.rating,
    required this.contact,
    required this.email,
    required this.place,
    required this.previousWorks,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Artist Name and Category
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color.fromARGB(255, 190, 194, 199),
                  child: Text(
                    artistName.isNotEmpty ? artistName[0] : '?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        artistName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Experience: $experience",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                // Rating
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey[300], thickness: 1.0, height: 20),

            // Contact Details
            Row(
              children: [
                Icon(Icons.phone, color: Colors.blue[900]),
                SizedBox(width: 8),
                Text(contact),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.email, color: Colors.blue[900]),
                SizedBox(width: 8),
                Text(email),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue[900]),
                SizedBox(width: 8),
                Container(width: 200, child: Text(place)),
              ],
            ),

            Divider(color: Colors.grey[300], thickness: 1.0, height: 20),

            // Previous Works
            Text(
              "Previous Works",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: previousWorks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(appBar: AppBar(),
                                body: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: Image.network(
                                    '$baseUrl/${previousWorks[index]}',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          '$baseUrl/${previousWorks[index]}',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),

            // Book Artist Button
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigate to booking functionality
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => BookArtistScreen(name: artistName, artistid: artistid,dressid: ,)),
            //     // );
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.blue[900],
            //     padding: EdgeInsets.symmetric(vertical: 12),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   child: Center(
            //     child: Text(
            //       "Book",
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),

            // Add a new button for the "View Dress Model" Screen
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Fetch the associated model images based on artistid
                try {
                  // You can make an API call with the artistid here
                  List<
                      Map<String,
                          dynamic>> modelImages = await fetchModelImages(
                      context,
                      artistid); // Define this function to fetch model images
                  // Pass the images to the next screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DressDetailsPage(
                          modelImages: modelImages,
                          artistname: artistName,
                          artistid:
                              artistid), // Pass images to DressDetailsPage
                    ),
                  );
                } catch (e) {
                  print("Error fetching model images: $e");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  "View Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
