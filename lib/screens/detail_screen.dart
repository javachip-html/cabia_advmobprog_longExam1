import 'package:facebook_replication/constants.dart';
import '../models/comment.dart';
import '../models/post.dart';
import '../services/comment_service.dart';
import '../services/user_service.dart';
import 'package:facebook_replication/widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  final Post post;

  const DetailScreen({super.key, required this.post});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late int _likeCount;
  late Future<List<Comment>> _comments;
  final _commentController = TextEditingController();
  final _commentService = CommentService();
  final _userService = UserService();
  List<Comment>? _loadedComments;
  bool _submittingComment = false;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.post.likes;
    _comments = _commentService.fetchComments(widget.post.id);
  }

  @override
  void dispose() { _commentController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomFont(
          text: 'Post #${post.id}',
          fontSize: ScreenUtil().setSp(20),
          color: Theme.of(context).colorScheme.onSurface,
        ), // CustomFont
      ), // AppBar
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: ScreenUtil().screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
                (post.hasImage)
                  ? SizedBox(
                      height: ScreenUtil().setHeight(220),
                      width: double.infinity,
                    child: post.imageUrl.isNotEmpty
                        ? Image.network(post.imageUrl, fit: BoxFit.cover)
                        : Image.asset(post.imagePath, fit: BoxFit.cover),
                    )
                  : SizedBox(height: ScreenUtil().setHeight(20)),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: ScreenUtil().setSp(25),
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                      backgroundImage: post.profileImageUrl.isNotEmpty
                          ? NetworkImage(post.profileImageUrl)
                          : null,
                      child: post.profileImageUrl.isEmpty
                          ? Icon(Icons.person, color: Theme.of(context).colorScheme.onSurfaceVariant)
                          : null,
                    ), // CircleAvatar
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFont(
                          text: post.authorName.isEmpty ? 'User ${post.userId}' : post.authorName,
                          fontSize: ScreenUtil().setSp(20),
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ), // CustomFont
                        CustomFont(
                          text: 'Likes: $_likeCount',
                          fontSize: ScreenUtil().setSp(15),
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ), // CustomFont
                      ],
                    ), // Column
                  ],
                ), // Row
              ), // Container
              SizedBox(height: ScreenUtil().setHeight(15)),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                alignment: Alignment.centerLeft,
                child: CustomFont(
                  text: '${post.title}\n\n${post.body}',
                  fontSize: ScreenUtil().setSp(16),
                  color: Theme.of(context).colorScheme.onSurface,
                ), // CustomFont
              ), // Container
              SizedBox(height: ScreenUtil().setHeight(20)),
              const Divider(),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Lab Activity 4 - Enhancement 3: like count increments on click
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _likeCount++;
                        });
                      },
                      icon: const Icon(Icons.thumb_up, color: APP_DARK_PRIMARY),
                      label: CustomFont(
                        text: '$_likeCount',
                        fontSize: ScreenUtil().setSp(12),
                        color: APP_DARK_PRIMARY,
                      ), // CustomFont
                    ), // TextButton.icon
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.comment, color: APP_DARK_PRIMARY),
                      label: CustomFont(
                        text: 'Comment',
                        fontSize: ScreenUtil().setSp(12),
                        color: APP_DARK_PRIMARY,
                      ), // CustomFont
                    ), // TextButton.icon
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share, color: APP_DARK_PRIMARY),
                      label: CustomFont(
                        text: 'Share',
                        fontSize: ScreenUtil().setSp(12),
                        color: APP_DARK_PRIMARY,
                      ), // CustomFont
                    ), // TextButton.icon
                  ],
                ), // Row
              ), // Container
              FutureBuilder<List<Comment>>(
                future: _comments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) return const Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator());
                  if (snapshot.hasError) return Text('Unable to load comments: ${snapshot.error}');
                  _loadedComments ??= snapshot.data ?? [];
                  return Column(children: [
                    ..._loadedComments!.map((comment) => ListTile(title: Text(comment.user.username), subtitle: Text(comment.body), trailing: Text('${comment.likes}'))),
                    Padding(padding: const EdgeInsets.all(16), child: Row(children: [Expanded(child: TextField(controller: _commentController, decoration: const InputDecoration(hintText: 'Write a comment'))), IconButton(icon: _submittingComment ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.send), onPressed: _submittingComment ? null : () => _submitComment(post.id))])),
                  ]);
                },
              ),
            ],
          ), // Column
        ), // SingleChildScrollView
      ), // Container
    ); // Scaffold
  }

  Future<void> _submitComment(int postId) async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    setState(() => _submittingComment = true);
    try {
      final user = await _userService.currentUser();
      if (user == null) throw Exception('Please sign in again.');
      final comment = await _commentService.addComment(postId: postId, userId: user.id, body: text);
      if (!mounted) return;
      _commentController.clear();
      setState(() {
        _loadedComments!.add(comment);
        _submittingComment = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _submittingComment = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString().replaceFirst('Exception: ', ''))));
    }
  }
}
