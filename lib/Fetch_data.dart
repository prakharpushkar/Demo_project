import 'dart:convert';
import 'package:bloc_explorer/API_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetch_Blogs() async {
  const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  // to ensure safety, the private key is stored in a separate file and accessed here.
  final String adminSecret = '$api_key';

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });

    if (response.statusCode == 200) {
      // API response is generally of dynamic type and it will be the list of dynamics
      final Map<String, dynamic> response_of_JSON = json.decode(response.body);
      // to convert each item in the list of dynamics to Map as JSON response is generally represented in Maps.
      final List<dynamic> result = response_of_JSON['blogs'];
      return result.cast<Map<String,dynamic>>();
    } 
    else {
      throw Exception(const Text("Unable to load the Data"));
    }
  } 
  catch (e) { 
    // Handle any errors that occurred during the request
    throw Exception('Error: $e');
  }
}
