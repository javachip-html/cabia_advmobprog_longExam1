class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  final int followers;
  final int following;

  const User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    this.followers = 0,
    this.following = 0,
  });

  String get displayName => '$firstName $lastName'.trim();

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int? ?? 0,
        username: json['username'] as String? ?? '',
        firstName: json['firstName'] as String? ?? '',
        lastName: json['lastName'] as String? ?? '',
        email: json['email'] as String? ?? '',
        image: json['image'] as String? ?? '',
        followers: json['followers'] as int? ?? 0,
        following: json['following'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'image': image,
        'followers': followers,
        'following': following,
      };
}
