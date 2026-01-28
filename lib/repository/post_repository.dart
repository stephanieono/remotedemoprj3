import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:remote_demo/model/post.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
      headers: {'Accept': 'application/json', 'User-Agent': 'Mozilla/5.0'},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      // debugPrint(response.body);
      return body.map((dynamic item) => Post.fromJson(item)).toList();
    } else {
      // print("Status code: ${response.statusCode}");
      // print("Response body: ${response.body}");
      throw Exception("Failed to load posts");
    }
  }

  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      debugPrint(response.body);
      throw Exception("Failed to create post");
    }
  }
}
