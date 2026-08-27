import 'package:facebook_replication/models/post.dart';
import 'package:facebook_replication/screens/detail_screen.dart';
import 'package:facebook_replication/widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Formerly "NewsfeedCard" (Activity 1) -> renamed to "PostCard" (Activity 3)
class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int _likeCount;

  Post get post => widget.post;

  @override
  void initState() {
    super.initState();
    _likeCount = post.likes;
  }

  // Activity 1 - Enhancement 3: like/comment/share as reusable widget-based buttons
    Widget _actionButton(
      {required BuildContext context,
      required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Theme.of(context).colorScheme.primary),
      label: CustomFont(
        text: label,
        fontSize: ScreenUtil().setSp(12),
        color: Theme.of(context).colorScheme.onSurface,
      ), // CustomFont
    ); // TextButton.icon
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.all(ScreenUtil().setSp(10)),
      // Lab Activity 4 - Enhancement 1: PostCard is clickable (same as Notification)
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(post: post),
            ), // MaterialPageRoute
          ); // Navigator.push
        },
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setSp(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Activity 1 - Enhancement 2: avatar for user profile image
                  CircleAvatar(
                    radius: ScreenUtil().setSp(20),
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    backgroundImage: post.profileImageUrl.isNotEmpty
                        ? NetworkImage(post.profileImageUrl)
                        : null,
                    child: post.profileImageUrl.isEmpty
                        ? const Icon(Icons.person, color: Colors.white)
                        : null,
                  ), // CircleAvatar
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFont(
                        text: 'User ${post.userId}',
                        fontSize: ScreenUtil().setSp(15),
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ), // CustomFont
                      CustomFont(
                        text:
                            'Post #${post.id}',
                        fontSize: ScreenUtil().setSp(12),
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ), // CustomFont
                    ],
                  ), // Column
                ],
              ), // Row
              SizedBox(height: ScreenUtil().setSp(5)),
              CustomFont(
                text: post.title,
                fontSize: ScreenUtil().setSp(14),
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: ScreenUtil().setSp(4)),
              CustomFont(
                text: post.body,
                fontSize: ScreenUtil().setSp(12),
                color: Theme.of(context).colorScheme.onSurface,
              ), // CustomFont
              SizedBox(height: ScreenUtil().setSp(5)),
              // Activity 1 - Enhancement 1: placeholder/widget for the image area
                if (post.imageUrl.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(180),
                    child: Image.network(post.imageUrl, fit: BoxFit.cover),
                  ),
              SizedBox(height: ScreenUtil().setSp(5)),
              CustomFont(
                text: '$_likeCount Likes',
                fontSize: ScreenUtil().setSp(12),
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ), // CustomFont - Activity 1 Enhancement 3: disregard reaction, show like count only
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _actionButton(
                    context: context,
                    icon: Icons.thumb_up_outlined,
                    label: 'Like',
                    onPressed: () => setState(() => _likeCount++),
                  ),
                  _actionButton(
                    context: context,
                    icon: Icons.comment_outlined,
                    label: 'Comment',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailScreen(post: post)),
                    ),
                  ),
                  _actionButton(
                    context: context,
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onPressed: () {},
                  ),
                ],
              ), // Row
            ],
          ), // Column
        ), // Padding
      ), // InkWell
    ); // Card
  }
}
