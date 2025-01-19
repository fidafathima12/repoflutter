import 'package:flutter/material.dart';
import 'package:bridal_hub/services/loginApi.dart';

class ImageDisplay extends StatefulWidget {
  final String? imageUrl;

  const ImageDisplay({super.key, this.imageUrl});

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Display Image Example"),
      ),
      body: Center(
        child: widget.imageUrl != null
            ? Image.network(
                "${baseUrl}${widget.imageUrl}",
                height: 500,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : CircularProgressIndicator(), // Display a loading indicator if imageUrl is null
      ),
    );
  }
}
