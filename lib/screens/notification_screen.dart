import 'package:facebook_replication/models.dart';
import 'package:facebook_replication/widgets/notification.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  // Activity 2 - General Enhancement: 10-20 notifications
  List<NotificationModel> _sampleNotifications() {
    final now = DateTime.now();
    final names = [
      'Nash Cabia',
      'The Rock',
      'LeBron James',
      'Manny Pacquiao',
      'Jose Rizal',
      'Wakanda4ever',
      'Thanos',
      'Michael Jackson',
      'Andres Bonifacio',
      'Flow G',
      'Arthur McArthur',
      'Dingdong Dantes',
      'Bea Alonzo',
      'Abraham Lincoln',
    ];
    final actions = [
      'liked your post',
      'commented on your photo',
      'mentioned you in a comment',
      'reacted to your comment',
      'mentioned you in a post',
      'liked your photo',
      'shared your post',
      'tagged you in a photo',
      'commented on your post',
      'liked your comment',
    ];

    return List.generate(names.length, (i) {
      return NotificationModel(
        name: names[i],
        post: 'Test! did it work?',
        description: '${names[i]} ${actions[i % actions.length]}',
        date: now.subtract(Duration(hours: i * 3)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifications = _sampleNotifications();
    return ListView.separated(
      itemCount: notifications.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return NotificationTile(notif: notifications[index]);
      },
    ); // ListView.separated
  }
}
