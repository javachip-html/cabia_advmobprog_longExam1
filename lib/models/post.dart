class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  final int likes;
  final int comments;
  final int views;
  final String imageUrl;
  final String imagePath;
  final String authorName;

  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.likes,
    required this.comments,
    required this.views,
    this.imageUrl = '',
    this.imagePath = '',
    this.authorName = '',
  });

  String get profileImageUrl => '';
  bool get hasImage => imageUrl.isNotEmpty || imagePath.isNotEmpty;

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
      imagePath: json['imagePath'] as String? ?? '',
      authorName: json['authorName'] as String? ?? '',
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
        'imagePath': imagePath,
          'authorName': authorName,
      };

        Post copyWith({String? imagePath, String? authorName}) => Post(
        id: id,
        userId: userId,
        title: title,
        body: body,
        likes: likes,
        comments: comments,
        views: views,
        imageUrl: imageUrl,
        imagePath: imagePath ?? this.imagePath,
        authorName: authorName ?? this.authorName,
      );
}
