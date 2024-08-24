import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String image;
  final String title;
  final Color backgroundcolor;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ImageContainer({
    super.key,
    required this.image,
    required this.title,
    required this.backgroundcolor,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundcolor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network( // we are fetching image from API thatswhy to take network
              image,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
