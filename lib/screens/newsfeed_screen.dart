import '../models/post.dart';
import '../services/post_service.dart';
import 'package:facebook_replication/widgets/post_card.dart';
import 'package:flutter/material.dart';

class NewsfeedScreen extends StatefulWidget {
  const NewsfeedScreen({super.key});
  @override
  State<NewsfeedScreen> createState() => _NewsfeedScreenState();
}

class _NewsfeedScreenState extends State<NewsfeedScreen> {
  late final Future<List<Post>> _posts = PostService().fetchPosts();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: _posts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError) return Center(child: Text('Unable to load feed: ${snapshot.error}'));
        final imagePaths = <String>[
          'assets/images/cute.jpg',
          'assets/images/jose.jpg',
          'assets/images/lbj.jpg',
          'assets/images/pacman.jpg',
          'assets/images/thanos.jpeg',
        ];
        final posts = (snapshot.data ?? [])
            .asMap()
            .entries
            .map((entry) => entry.value.copyWith(
                  imagePath: entry.value.imageUrl.isEmpty
                      ? imagePaths[entry.key % imagePaths.length]
                      : entry.value.imagePath,
                ))
            .toList();
        return ListView.builder(itemCount: posts.length, itemBuilder: (_, index) => PostCard(post: posts[index]));
      },
    );
  }
}
