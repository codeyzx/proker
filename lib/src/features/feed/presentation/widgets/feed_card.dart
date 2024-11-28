// lib/widgets/feed_card.dart

import 'package:flutter/material.dart';
import 'package:proker/src/core/utils/color.dart';
import 'package:proker/src/features/feed/domain/entities/feed_item.dart';

class FeedCard extends StatelessWidget {
  final FeedItem item;

  FeedCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 3.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(item.profileName[0]), // Inisial nama
            ),
            title: Text(item.profileName),
            subtitle: Text(item.time),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Fungsi report
              },
            ),
          ),
          // Body
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: getStatusColor(item.status),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    item.status,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  item.eventName,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(item.description),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          // Image Section
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                item.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
