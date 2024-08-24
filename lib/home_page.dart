import 'package:bloc_explorer/Fetch_data.dart';
import 'package:bloc_explorer/details_page.dart';
import 'package:bloc_explorer/fav_blog.dart';
import 'package:bloc_explorer/fav_page.dart';
import 'package:bloc_explorer/favorite_event.dart';
import 'package:bloc_explorer/favourite_state.dart';
import 'package:bloc_explorer/imagecontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 228, 213),
      appBar: AppBar(
        toolbarHeight: 70,
        iconTheme: const IconThemeData( // set the theme of entire icon to white
          color: Colors.white
        ),
        title: const Text(
          "Bloc Explorer",
          style: TextStyle(
            color: Color.fromARGB(255, 244, 242, 242),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromRGBO(2, 21, 38, 1), // color of the appbar
        shape: const RoundedRectangleBorder( // for adding that rounded effect to our appbar
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () { // when we click on it, it will refresh and build our entire app again
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () { // To view the favourite blogs added to the cart click here
              showModalBottomSheet(
                context: context,
                builder: (context) { 
                  return const fav_page(); // returning the fav blogs page
                },
                backgroundColor: Colors.transparent, 
                isScrollControlled: true, // make bottom sheet scrollable
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const Drawer(
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>( 
        future: fetch_Blogs(), // the function which fetches the data from the API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data ?? []; // so that if data is sometime NULL

          return ListView.builder( 
            itemCount: data.length,
            itemBuilder: (context, index) {
              final blog = data[index]; // storing the index'th data in the variable blog

              return GestureDetector( 
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) { // its building the Details page of each blog when clicked
                      return DetailsPage(blog: blog); // here, blog is required to initialize
                    }, 
                  )
                );
                },
                child: BlocBuilder<Blog_favourite, favorite_state>(
                  builder: (context, state) {
                    bool isFavorite = false; 
                    if (state is FavoriteUpdated) {
                      isFavorite = state.fav_ids.contains(blog['id']);
                    }

                    return ImageContainer( // these are required to initialize as we made them to do so in image container file
                      backgroundcolor:  const Color.fromARGB(255, 230, 238, 213),
                      image: blog['image_url'] as String,
                      title: blog['title'] as String,
                      isFavorite: isFavorite,
                      onFavoriteToggle: () {
                        context.read<Blog_favourite>().add(Togglefavourite_event(blog['id']));
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
