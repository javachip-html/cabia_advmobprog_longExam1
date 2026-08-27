class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  final int likes;
  final int comments;
  final int views;
  final String imageUrl;

  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.likes,
    required this.comments,
    required this.views,
    this.imageUrl = '',
  });

  String get profileImageUrl => '';
  String get imagePath => '';
  bool get hasImage => false;

  factory Post.fromJson(Map<String, dynamic> json) {
    final reactions = json['reactions'];
    final likes = reactions is Map<String, dynamic>
        ? reactions['likes'] as int? ?? 0
        : json['likes'] as int? ?? 0;
    return Post(
      id: json['id'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      likes: likes,
      comments: json['comments'] as int? ?? 0,
      views: json['views'] as int? ?? 0,
      imageUrl: json['image'] as String? ?? json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'title': title,
        'body': body,
        'reactions': {'likes': likes},
        'comments': comments,
        'views': views,
        'imageUrl': imageUrl,
      };
}
