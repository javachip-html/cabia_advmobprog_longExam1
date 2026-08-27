import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comment.dart';

class CommentService {
  static const _baseUrl = 'https://dummyjson.com';

  Future<List<Comment>> fetchComments(int postId) async {
    // Fallback ID 0 or out-of-range IDs to 1 to prevent 404 exceptions on DummyJSON
    final int validId = (postId <= 0 || postId > 150) ? 1 : postId;

    final response = await http.get(Uri.parse('$_baseUrl/comments/post/$validId'));
    if (response.statusCode != 200) throw Exception('Unable to load comments.');
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return (data['comments'] as List<dynamic>)
        .map((item) => Comment.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Comment> addComment({required int postId, required int userId, required String body}) async {
    final int validId = (postId <= 0 || postId > 150) ? 1 : postId;

    final response = await http.post(
      Uri.parse('$_baseUrl/comments/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'body': body, 'postId': validId, 'userId': userId}),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Unable to add comment.');
    }
    return Comment.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}