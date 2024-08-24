import 'package:bloc_explorer/Fetch_data.dart';
import 'package:bloc_explorer/details_page.dart';
import 'package:bloc_explorer/fav_blog.dart';
import 'package:bloc_explorer/favourite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class fav_page extends StatelessWidget {
  const fav_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 228, 213),
      appBar: AppBar(
        title: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Favourites Blogs",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ],
          ),
        ),
        toolbarHeight: 150,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: const Color.fromRGBO(2, 21, 38, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: BlocBuilder<Blog_favourite, favorite_state>(
              builder: (context, state) {
                if (state is FavoriteUpdated) {
                  final favoriteBlogIds = state.fav_ids;
                  if (favoriteBlogIds.isEmpty) {
                    return const Center(
                      child: Text(
                        "No favorite blogs yet.",
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else {
                    return FutureBuilder<List<Map<String, dynamic>>>(
                      future: fetch_Blogs(), // Call your API fetch function
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(child: Text("Error loading blogs"));
                        } else if (snapshot.hasData) {
                          final blogs = snapshot.data!;
                          // Filter blogs that are in the favorite list
                          final favoriteBlogs = blogs.where((blog) => favoriteBlogIds.contains(blog['id'])).toList();
                          
                          return ListView.builder(
                            itemCount: favoriteBlogs.length,
                            itemBuilder: (context, index) {
                              final blog = favoriteBlogs[index];
                              return ListTile(
                                title: Text(blog['title']),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(blog['image_url']),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return DetailsPage(blog: blog);
                                    },
                                  ));
                                },
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text("No blogs found"));
                        }
                      },
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
