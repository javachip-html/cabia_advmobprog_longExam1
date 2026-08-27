import 'package:facebook_replication/models.dart';
import 'package:facebook_replication/models/post.dart';
import 'package:facebook_replication/screens/detail_screen.dart';
import 'package:facebook_replication/widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.notif});

  final NotificationModel notif;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Lab Activity 4 - Enhancement 1: clickable, same behavior as PostCard
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              post: Post(
                id: 0,
                userId: 0,
                title: notif.post,
                body: notif.description,
                likes: 0,
                comments: 0,
                views: 0,
              ),
            ), // DetailScreen
          ), // MaterialPageRoute
        ); // Navigator.push
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(15)),
        child: Row(
          children: [
            // Lab Activity 4 - Enhancement 2: image if available, person icon if not
            CircleAvatar(
              radius: ScreenUtil().setSp(25),
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              backgroundImage: notif.profileImageUrl.isNotEmpty
                  ? NetworkImage(notif.profileImageUrl)
                  : null,
              child: notif.profileImageUrl.isEmpty
                  ? Icon(Icons.person, size: ScreenUtil().setSp(28), color: Theme.of(context).colorScheme.onSurfaceVariant)
                  : null,
            ), // CircleAvatar
            SizedBox(width: ScreenUtil().setWidth(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFont(
                    text: notif.name,
                    fontSize: ScreenUtil().setSp(15),
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w800,
                  ), // CustomFont
                  CustomFont(
                    text: 'Posted: ${notif.post}',
                    fontSize: ScreenUtil().setSp(13),
                    color: Theme.of(context).colorScheme.onSurface,
                  ), // CustomFont
                  CustomFont(
                    text: notif.description,
                    fontSize: ScreenUtil().setSp(12),
                    color: Theme.of(context).colorScheme.onSurface,
                    fontStyle: FontStyle.italic,
                  ), // CustomFont
                  SizedBox(height: ScreenUtil().setSp(5)),
                  CustomFont(
                    text: '${notif.date.month}/${notif.date.day}/${notif.date.year}',
                    fontSize: ScreenUtil().setSp(12),
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ), // CustomFont
                ],
              ), // Column
            ), // Expanded
            const Icon(Icons.more_horiz),
          ],
        ), // Row
      ), // Container
    ); // InkWell
  }
}
