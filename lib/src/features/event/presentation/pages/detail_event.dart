import 'package:auto_route/auto_route.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:proker/src/features/event/domain/entities/event_entity.dart';

@RoutePage()
class DetailEventPage extends StatefulWidget {
  final EventEntity event;

  const DetailEventPage({super.key, required this.event});

  @override
  State<DetailEventPage> createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEventPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> forumComments = [];
  int selectedTabIndex = 0;
  bool isUpvoted = false;

  @override
  void initState() {
    super.initState();
    // _fetchForumComments(widget.event.id);
  }

  // Future<void> _fetchForumComments(String eventId) async {
  //   try {
  //     // Fetch forum comments related to the event from Firestore
  //     final forumSnapshot = await FirebaseFirestore.instance
  //         .collection('forums')
  //         .doc(eventId)
  //         .collection('comments')
  //         .orderBy('time', descending: true)
  //         .get();

  //     setState(() {
  //       forumComments = forumSnapshot.docs
  //           .map((doc) => doc.data() as Map<String, dynamic>)
  //           .toList();
  //     });
  //   } catch (e) {
  //     print('Error fetching forum comments: $e');
  //   }
  // }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Upcoming':
        return const Color(0xFF04339B);
      case 'New':
        return const Color(0xFFFFC333);
      case 'Done':
        return const Color(0xFF85B600);
      default:
        return Colors.grey;
    }
  }

  void _toggleUpvote() {
    //   setState(() {
    //     if (isUpvoted) {
    //       widget.event.upvoteCount -= 1;
    //     } else {
    //       widget.event.upvoteCount += 1;
    //     }
    //     isUpvoted = !isUpvoted;
    //   });
  }

  @override
  Widget build(BuildContext context) {
    List<String> benefitsList = widget.event.benefits?.split(', ') ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          // Banner
          Stack(
            children: [
              Image.network(
                widget.event.bannerUrl ?? '',
                height: 261,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
          ),

          // Heading Section
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6.0,
                  children: (widget.event.category?.split(', ') ?? [])
                      .map<Widget>((category) {
                    return Chip(
                      label: Text(
                        category,
                        style: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: const Color(0xFF04339B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.event.title ?? 'No Title',
                        style: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.thumb_up_off_alt_outlined,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${widget.event.upvoteCount} Upvote",
                      style: const TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Chip(
                  label: Text(
                    widget.event.status ?? 'No Status',
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 10.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: _getStatusColor(widget.event.status ?? ''),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ],
            ),
          ),

          // Tab Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTabIndex = 0),
                    child: Column(
                      children: [
                        Text(
                          'Tentang',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                            color: selectedTabIndex == 0
                                ? const Color(0xFF04339B)
                                : Colors.black,
                          ),
                        ),
                        Container(
                          height: 2,
                          color: selectedTabIndex == 0
                              ? const Color(0xFF04339B)
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTabIndex = 1),
                    child: Column(
                      children: [
                        Text(
                          'Galeri',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                            color: selectedTabIndex == 1
                                ? const Color(0xFF04339B)
                                : Colors.black,
                          ),
                        ),
                        Container(
                          height: 2,
                          color: selectedTabIndex == 1
                              ? const Color(0xFF04339B)
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTabIndex = 2),
                    child: Column(
                      children: [
                        Text(
                          'Forum',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                            color: selectedTabIndex == 2
                                ? const Color(0xFF04339B)
                                : Colors.black,
                          ),
                        ),
                        Container(
                          height: 2,
                          color: selectedTabIndex == 2
                              ? const Color(0xFF04339B)
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.grey, thickness: 5),

          // Body Section
          Expanded(
            child: IndexedStack(
              index: selectedTabIndex,
              children: [
                // Tentang
                ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      title: const Text(
                        'Dikelola oleh',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(50.0),
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/image/logo_himakom.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.event.createdBy ?? 'No Creator',
                              style: const TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey, thickness: 5),
                    ListTile(
                      title: const Text(
                        'Deskripsi',
                        style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        widget.event.description ?? 'No Description',
                        style: const TextStyle(fontFamily: 'Urbanist'),
                      ),
                    ),
                    const Divider(color: Colors.grey, thickness: 5),
                    ListTile(
                      title: const Text(
                        'Manfaat',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: BulletList(items: benefitsList),
                    ),
                    const Divider(color: Colors.grey, thickness: 5),
                    ListTile(
                      title: const Text(
                        'Lokasi dan Waktu',
                        style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16),
                              const SizedBox(width: 8),
                              Text(
                                widget.event.location ?? 'No Location',
                                style: const TextStyle(fontFamily: 'Urbanist'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 16),
                              const SizedBox(width: 8),
                              Text(
                                widget.event.startDate.toString(),
                                style: const TextStyle(fontFamily: 'Urbanist'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Galeri
                GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: 0,
                  itemBuilder: (context, index) => const SizedBox.shrink(),
                  // itemBuilder: (context, index) {
                  //   return GestureDetector(
                  //     onTap: () => _showFullImage(widget.event.gallery![index]),
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(12.0),
                  //       child: Image.network(
                  //         widget.event.gallery![index],
                  //         width: 160,
                  //         height: 160,
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   );
                  // },
                ),
                // Forum
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: forumComments.length,
                        itemBuilder: (context, index) {
                          final comment = forumComments[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(comment['profilePicture']),
                                  radius: 25,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            comment['name'],
                                            style: const TextStyle(
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            comment['time'],
                                            style: const TextStyle(
                                              fontFamily: 'Urbanist',
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        comment['comment'],
                                        style: const TextStyle(
                                            fontFamily: 'Urbanist'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.emoji_emotions_outlined),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return EmojiPicker(
                                    onEmojiSelected: (category, emoji) {
                                      _controller.text += emoji.emoji;
                                      _controller.selection =
                                          TextSelection.fromPosition(
                                        TextPosition(
                                            offset: _controller.text.length),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'Add a comment...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              // Implement send comment functionality
                              _controller.clear();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      // Footer
      bottomNavigationBar: selectedTabIndex == 0
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 8, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Pengumpulan Aspirasi',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Beri dukungan untuk program kerja ini dengan upvote!',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _toggleUpvote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isUpvoted ? const Color(0xFF04339B) : Colors.white,
                      side: const BorderSide(
                        color: Color(0xFF04339B),
                        width: 2,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      minimumSize: const Size(double.infinity, 0),
                    ),
                    child: Text(
                      isUpvoted ? 'Upvoted' : 'Upvote',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold,
                        color:
                            isUpvoted ? Colors.white : const Color(0xFF04339B),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "• ",
              style: TextStyle(fontSize: 20, fontFamily: 'Urbanist'),
            ),
            Expanded(
              child: Text(
                item,
                style: const TextStyle(fontFamily: 'Urbanist'),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
