import 'user.dart';

class Comment {
  final int id;
  final int postId;
  final String body;
  final int likes;
  final User user;

  const Comment({
    required this.id,
    required this.postId,
    required this.body,
    required this.likes,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'] as int? ?? 0,
        postId: json['postId'] as int? ?? 0,
        body: json['body'] as String? ?? '',
        likes: json['likes'] as int? ?? 0,
        user: User.fromJson((json['user'] as Map<String, dynamic>?) ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'postId': postId,
        'body': body,
        'likes': likes,
        'user': user.toJson(),
      };
}
