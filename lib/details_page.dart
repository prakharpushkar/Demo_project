import 'package:bloc_explorer/fav_blog.dart';
import 'package:bloc_explorer/favorite_event.dart';
import 'package:bloc_explorer/favourite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> blog;

  const DetailsPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    final title = blog['title'] ?? 'No Title';
    final imageUrl = blog['image_url'] ?? 'https://via.placeholder.com/150'; 
    final id = blog['id'] ?? 'No ID';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 228, 213),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(2, 21, 38, 1),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      body: Padding( // ensures proper spacing between each widget inside it.
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(imageUrl),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              id,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<Blog_favourite, favorite_state>(
        builder: (context, state) {
          bool isFavorite = false;
          if (state is FavoriteUpdated) {
            isFavorite = state.fav_ids.contains(blog['id']);
          }

          return FloatingActionButton(
            onPressed: () {
              context.read<Blog_favourite>().add(Togglefavourite_event(blog['id']));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavorite ? 'Removed from favorites' : 'Marked as favorite',
                  ),
                ),
              );
            },
            backgroundColor: const Color.fromARGB(255, 245, 201, 193),
            foregroundColor: Colors.red,
            child: Icon(isFavorite
                ? Icons.favorite
                : Icons.favorite_outline_outlined
            ),
          );
        },
      ),
    );
  }
}
