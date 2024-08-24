import 'package:bloc_explorer/fav_blog.dart';
import 'package:bloc_explorer/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    // bloc state management initialized globally
    BlocProvider(
      create: (context) {
        return Blog_favourite();
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true), // using the material3 
      home:  const HomePage(), // returning the homepage i.e the front page of our app
    );
  }
}
