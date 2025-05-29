import 'package:flutter/material.dart';

class AchievementTab extends StatelessWidget {
  final int savedCount;
  final int sharedCount;

  const AchievementTab({
    Key? key,
    required this.savedCount,
    required this.sharedCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> achievements = [
      {
        'title': 'First Save',
        'description': 'You saved your first product!',
        'achieved': savedCount >= 1,
      },
      {
        'title': 'Saver Pro',
        'description': 'Saved 5 products!',
        'achieved': savedCount >= 5,
      },
      {
        'title': 'Shared Something',
        'description': 'You shared a product!',
        'achieved': sharedCount >= 1,
      },
      {
        'title': 'Social Star',
        'description': 'Shared 5 products!',
        'achieved': sharedCount >= 5,
      },
    ];

    return ListView.builder(
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        return Card(
          color: achievement['achieved'] ? Colors.green.shade100 : Colors.grey.shade200,
          child: ListTile(
            leading: Icon(
              achievement['achieved'] ? Icons.emoji_events : Icons.lock_outline,
              color: achievement['achieved'] ? Colors.amber : Colors.grey,
            ),
            title: Text(achievement['title']),
            subtitle: Text(achievement['description']),
            trailing: Icon(
              achievement['achieved'] ? Icons.check_circle : Icons.hourglass_empty,
              color: achievement['achieved'] ? Colors.green : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
