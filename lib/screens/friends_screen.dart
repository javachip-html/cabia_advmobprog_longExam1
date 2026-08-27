import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  static const _friendNames = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Friends')),
      body: ListView.separated(
        itemCount: _friendNames.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              _friendNames[index][0],
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          title: Text(_friendNames[index]),
          trailing: OutlinedButton(
            onPressed: () {},
            child: const Text('Follow'),
          ),
        ),
      ),
    );
  }
}