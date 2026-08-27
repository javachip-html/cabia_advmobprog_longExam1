// Data models shared by NewsfeedScreen, NotificationScreen,
// ProfileScreen, and DetailScreen.

class PostModel {
  final String userName;
  final String postContent;
  final DateTime date;
  int likeCount; // mutable so DetailScreen can increment it (Lab Activity 4)
  final int commentCount;
  final int shareCount;
  final bool hasImage;

  /// Local Flutter asset path, for example: assets/images/holiday.jpg.
  final String imagePath;
  final String profileImageUrl;

  PostModel({
    required this.userName,
    required this.postContent,
    required this.date,
    this.likeCount = 0,
    this.commentCount = 0,
    this.shareCount = 0,
    this.hasImage = false,
    this.imagePath = '',
    this.profileImageUrl = '',
  });
}

class NotificationModel {
  final String name;
  final String post;
  final String description;
  final DateTime date;
  final String profileImageUrl;

  NotificationModel({
    required this.name,
    required this.post,
    required this.description,
    required this.date,
    this.profileImageUrl = '',
  });
}
