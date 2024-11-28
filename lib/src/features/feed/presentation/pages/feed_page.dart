// lib/screens/himakom_feed_page.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:proker/src/features/feed/domain/entities/feed_item.dart';
import 'package:proker/src/features/feed/presentation/widgets/feed_card.dart';
import 'package:proker/src/features/feed/presentation/widgets/filter_bar.dart';

@RoutePage()
class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final List<String> filters = ['All', 'New', 'Upcoming', 'Finished'];
  String selectedFilter = 'All';

  final List<FeedItem> feedItems = [
    FeedItem(
      status: 'New',
      profileName: 'Departemen SenOr',
      time: '4m ago',
      eventName: 'Proker Himakomfest',
      description: 'Berikan dukunganmu untuk event ini dengan melakukan "Upvote"',
      image: 'https://www.gramedia.com/blog/content/images/2024/04/pexels-photo-2747450.jpg',
    ),
    FeedItem(
      status: 'Upcoming',
      profileName: 'Departemen RisetDikti',
      time: '41m ago',
      eventName: 'Tsigram 2024',
      description: 'Nantikan Tsigram 2024 yang akan diselenggarakan pada 24 Oktober. Jangan sampai ketinggalan!',
      image: 'https://geekhunter.co/wp-content/uploads/2023/01/manfaat-bootcamp-dibandingkan-kuliah-1024x576.jpg',
    ),
    FeedItem(
      status: 'Finished',
      profileName: 'Departemen Himakom',
      time: '2h ago',
      eventName: 'Diskusi Publik 2024',
      description: 'Kami ucapkan terimakasih sebesar-besarnya terhadap semua partisipan event ini. Berikan feedback agar event ini dapat semakin berkembang!',
      image: 'https://image.kemenpora.go.id/images/content/2024/03/28/4813/389Luncurkan-Diskusi-Publik--KlubBerkawan--Menpora-Dito-Harap-Bisa-Lahirkan-Habibie-Baru-untuk-Masa-Depan-Indonesia.jpg',
    ),
  ];

  List<FeedItem> get filteredFeedItems {
    if (selectedFilter == 'All') return feedItems;
    return feedItems.where((item) => item.status == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Himakom's Feed",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF04339B),
        elevation: 4.0,
        shadowColor: Colors.black,
      ),
      body: Column(
        children: [
          FilterBar(
            filters: filters,
            selectedFilter: selectedFilter,
            onFilterSelected: (filter) {
              setState(() {
                selectedFilter = filter;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFeedItems.length,
              itemBuilder: (context, index) {
                final item = filteredFeedItems[index];
                return FeedCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}
