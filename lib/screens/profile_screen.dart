import 'package:facebook_replication/constants.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../services/post_service.dart';
import '../services/user_service.dart';
import 'signin_screen.dart';
import 'settings_screen.dart';
import 'package:facebook_replication/widgets/custom_button.dart';
import 'package:facebook_replication/widgets/custom_font.dart';
import 'package:facebook_replication/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _userService = UserService();
  final _postService = PostService();
  late Future<User?> _user;
  Future<List<Post>>? _posts;

  Future<List<Post>> _loadProfilePosts(User user) async {
    final posts = await _postService.fetchPosts(userId: user.id);
    final profilePosts = posts
        .map((post) => post.copyWith(authorName: user.displayName))
        .toList();
    profilePosts.insert(
      0,
      Post(
        id: 10001,
        userId: user.id,
        title: 'Welcome to my CCITBook profile',
        body: 'Hello everyone! This is my first post on CCITBook.',
        likes: 0,
        comments: 0,
        views: 0,
        authorName: user.displayName,
        imagePath: 'assets/images/cute.jpg',
      ),
    );
    return profilePosts;
  }

  @override
  void initState() {
    super.initState();
    _user = _userService.currentUser();
  }

  Widget _aboutTab() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20), vertical: ScreenUtil().setHeight(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFont(
            text: 'About',
            fontSize: ScreenUtil().setSp(16),
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ), // CustomFont
          const Divider(),
          _aboutRow(Icons.info_outline, 'Web Developer | Flutter learner | Building CCITBook'),
          _aboutRow(Icons.school_outlined, 'Studying Web Development at CCIT'),
          _aboutRow(Icons.work_outline, 'Student Developer'),
          _aboutRow(Icons.location_on_outlined, 'Philippines'),
          _aboutRow(Icons.email_outlined, 'nashcabia@example.com'),
        ],
      ), // Column
    ); // Padding
  }

  Widget _aboutRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(6)),
      child: Row(
        children: [
          Icon(icon, size: ScreenUtil().setSp(18), color: APP_DARK_PRIMARY),
          SizedBox(width: ScreenUtil().setWidth(10)),
          Expanded(
            child: CustomFont(
              text: text,
              fontSize: ScreenUtil().setSp(13),
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ), // CustomFont
          ), // Expanded
        ],
      ), // Row
    ); // Padding
  }

  Widget _photosTab() {
    // Activity 3 - Enhancement 5: GridView class for the photos tab
    return GridView.builder(
      padding: EdgeInsets.all(ScreenUtil().setSp(5)),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ), // SliverGridDelegateWithFixedCrossAxisCount
      itemBuilder: (context, index) {
        return Container(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Icon(Icons.image_outlined, color: Theme.of(context).colorScheme.onSurfaceVariant),
        ); // Container
      },
    ); // GridView.builder
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(future: _user, builder: (context, userSnapshot) {
      final user = userSnapshot.data;
      if (userSnapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
      if (user == null) return const Center(child: Text('No signed-in user.'));
      _posts ??= _loadProfilePosts(user);
    return DefaultTabController(
      length: 3,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: ScreenUtil().setHeight(180),
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest),
                  ), // Container - cover photo placeholder
                  Positioned(
                    bottom: -ScreenUtil().setHeight(45),
                    left: ScreenUtil().setWidth(20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: ScreenUtil().setSp(45),
                          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                          child: Icon(Icons.person,
                              size: ScreenUtil().setSp(50), color: Theme.of(context).colorScheme.onSurfaceVariant),
                        ), // CircleAvatar
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: ScreenUtil().setSp(13),
                            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                            child: Icon(Icons.camera_alt,
                                size: ScreenUtil().setSp(14), color: Theme.of(context).colorScheme.onSurface),
                          ), // CircleAvatar
                        ), // Positioned
                      ],
                    ), // Stack
                  ), // Positioned
                ],
              ), // Stack
              SizedBox(height: ScreenUtil().setHeight(55)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Activity 3 - Enhancement 1: customize profile name
                    CustomFont(
                      text: user.displayName,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(20),
                      color: Theme.of(context).colorScheme.onSurface,
                    ), // CustomFont
                    SizedBox(height: ScreenUtil().setHeight(5)),
                    // Activity 3 - Enhancement 2: customize followers/following count
                    Row(
                      children: [
                        CustomFont(
                          text: '${user.followers}',
                          fontSize: ScreenUtil().setSp(15),
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ), // CustomFont
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        CustomFont(
                          text: 'followers',
                          fontSize: ScreenUtil().setSp(15),
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ), // CustomFont
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        Icon(Icons.circle, size: ScreenUtil().setSp(5), color: Theme.of(context).colorScheme.onSurfaceVariant),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        CustomFont(
                          text: '${user.following}',
                          fontSize: ScreenUtil().setSp(15),
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ), // CustomFont
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        CustomFont(
                          text: 'following',
                          fontSize: ScreenUtil().setSp(15),
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ), // CustomFont
                      ],
                    ), // Row
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Row(
                      children: [
                        CustomButton(buttonName: 'Follow', onPressed: () {}),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        CustomButton(
                          buttonName: 'Message',
                          buttonType: 'outlined',
                          onPressed: () {},
                        ), // CustomButton
                        IconButton(icon: const Icon(Icons.settings), onPressed: () => _showSettings(context)),
                        IconButton(icon: const Icon(Icons.logout), onPressed: () async { await _userService.signOut(); if (context.mounted) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const SignInScreen()), (_) => false); }),
                      ],
                    ), // Row
                  ],
                ), // Column
              ), // Padding
              SizedBox(height: ScreenUtil().setHeight(10)),
              TabBar(
                indicatorColor: APP_DARK_PRIMARY,
                labelColor: Theme.of(context).colorScheme.onSurface,
                tabs: [
                  Tab(
                    child: CustomFont(
                      text: 'Posts',
                      fontSize: ScreenUtil().setSp(15),
                      color: Theme.of(context).colorScheme.onSurface,
                    ), // CustomFont
                  ), // Tab
                  Tab(
                    child: CustomFont(
                      text: 'About',
                      fontSize: ScreenUtil().setSp(15),
                      color: Theme.of(context).colorScheme.onSurface,
                    ), // CustomFont
                  ), // Tab
                  Tab(
                    child: CustomFont(
                      text: 'Photos',
                      fontSize: ScreenUtil().setSp(15),
                      color: Theme.of(context).colorScheme.onSurface,
                    ), // CustomFont
                  ), // Tab
                ],
              ), // TabBar
              SizedBox(
                height: ScreenUtil().setHeight(2000),
                child: TabBarView(
                  children: [
                    // Enhancement 3: Wall posts (reuse PostCard)
                    FutureBuilder<List<Post>>(
                      future: _posts,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                        if (snapshot.hasError) return Text('Unable to load profile posts: ${snapshot.error}');
                        final posts = snapshot.data ?? [];
                        return ListView.builder(physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, itemCount: posts.length, itemBuilder: (_, index) => PostCard(post: posts[index]));
                      },
                    ),
                    _aboutTab(), // Enhancement 4
                    _photosTab(), // Enhancement 5
                  ],
                ), // TabBarView
              ), // SizedBox
            ],
          ), // Column
        ), // SingleChildScrollView
      ), // Container
    ); // DefaultTabController
    });
  }

  void _showSettings(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
  }
}
