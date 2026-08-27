import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostService {
  static const _baseUrl = 'https://dummyjson.com';

  Future<List<Post>> fetchPosts({int? userId}) async {
    final uri = userId == null
        ? Uri.parse('$_baseUrl/posts')
        : Uri.parse('$_baseUrl/posts/user/$userId');
    final response = await http.get(uri);
    if (response.statusCode != 200) throw Exception('Unable to load posts.');
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return (data['posts'] as List<dynamic>)
        .map((item) => Post.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
