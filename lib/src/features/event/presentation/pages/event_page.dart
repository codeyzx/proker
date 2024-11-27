import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/core/config/themes/app_colors.dart';
import 'package:proker/src/core/utils/logger.dart';
import 'package:proker/src/features/event/domain/entities/event_entity.dart';
import 'package:proker/src/features/event/presentation/bloc/event/event_cubit.dart';

@RoutePage()
class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  String selectedValue = 'Program Kerja'; // Nilai Default Dropdown
  List<String> dropdownItems = ['Program Kerja', 'Pergerakan']; // Opsi Dropdown
  bool isNewSelected = true; // Filter New
  bool isUpcomingSelected = false; // Filter Upcoming
  bool isDoneSelected = false; // Filter Done
  List<String> selectedCategories = []; // Kategori yang dipilih
  TextEditingController searchController =
      TextEditingController(); // Controller untuk search
  String searchText = ''; // Teks yang diinputkan pada search

  @override
  void initState() {
    super.initState();
  }

  void toggleFilter(String label) {
    setState(() {
      if (selectedCategories.contains(label)) {
        selectedCategories.remove(label);
      } else {
        selectedCategories.add(label);
      }
      _filterEvents();
    });
  }

  void _filterEvents() {
    setState(() {
      context.read<EventCubit>().searchEvents(searchText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EventCubit>()..getAll(),
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              _buildBlueSection(),
              _buildWhiteSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlueSection() {
    return Container(
      color: AppColors.primary,
      height: 300.0, // Berikan tinggi eksplisit
      width: double.infinity,
      padding: EdgeInsets.only(top: context.i(40.0)),
      child: Column(
        children: [
          const Text(
            'Event Himakom',
            style: _titleTextStyle,
          ),
          _buildDropdownButton(),
          _buildSearchBar(),
          _buildFilterChips(),
        ],
      ),
    );
  }

  Widget _buildWhiteSection() {
    return Expanded(
      child: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is GetEventListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetEventListSuccessState) {
            final events = state.data;
            return events.isEmpty
                ? const Center(child: Text('No events available.'))
                : ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: context.h(8.0),
                            horizontal: context.w(16.0)),
                        child: EventCard(event: event),
                      );
                    },
                  );
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }

  Widget _buildDropdownButton() {
    return DropdownButton<String>(
      value: selectedValue,
      items: dropdownItems.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              color: selectedValue == item ? AppColors.primary : Colors.grey,
              fontSize: context.sp(16),
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
          _filterEvents();
        });
      },
      underline: const SizedBox
          .shrink(), // Menghilangkan underline (border) dari dropdown
      iconEnabledColor: Colors.white, // Mengubah warna segitiga menjadi putih
      dropdownColor: Colors.white, // Warna background dropdown
      selectedItemBuilder: (BuildContext context) {
        return dropdownItems.map((String item) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Text(
              item,
              style: TextStyle(
                color: Colors.white,
                fontSize: context.sp(16),
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList();
      },
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.w(16.0)),
      margin: EdgeInsets.symmetric(
          vertical: context.h(16.0), horizontal: context.w(24.0)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          context.r(8.0),
        ),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchText = value.toLowerCase();
            _filterEvents();
          });
        },
        decoration: InputDecoration(
          hintText: 'Cari Event Himakom...',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: context.sp(16),
            fontFamily: 'Urbanist',
          ),
          border: InputBorder.none,
          icon: const Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      margin: EdgeInsets.only(
          top: context.h(8.0), left: context.w(8.0), right: context.w(8.0)),
      child: Wrap(
        spacing: 8.0, // Jarak horizontal antar button
        children: [
          _buildFilterButton(),
          _buildFilterChip(
            label: 'New',
            isSelected: isNewSelected,
            onSelected: (bool selected) {
              setState(() {
                isNewSelected = true;
                isDoneSelected = false;
                isUpcomingSelected = false;
                _filterEvents();
              });
            },
          ),
          _buildFilterChip(
            label: 'Upcoming',
            isSelected: isUpcomingSelected,
            onSelected: (bool selected) {
              setState(() {
                isUpcomingSelected = true;
                isNewSelected = false;
                isDoneSelected = false;
                _filterEvents();
              });
            },
          ),
          _buildFilterChip(
            label: 'Done',
            isSelected: isDoneSelected,
            onSelected: (bool selected) {
              setState(() {
                isDoneSelected = true;
                isNewSelected = false;
                isUpcomingSelected = false;
                _filterEvents();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required ValueChanged<bool> onSelected,
  }) {
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primary : Colors.grey,
          fontSize: context.sp(16),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.bold,
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: Colors.white,
      selectedColor: Colors.white, // Tetap putih saat dipilih
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          context.r(8.0),
        ),
      ),
      showCheckmark: false, // Tidak menampilkan tanda centang
    );
  }

  Widget _buildCustomFilterChip({
    required String label,
    required bool isSelected,
    required ValueChanged<bool> onSelected,
  }) {
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey,
          fontSize: context.sp(16),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.bold,
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: isSelected ? AppColors.primary : Colors.white,
      selectedColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          context.r(8.0),
        ),
      ),
      showCheckmark: false,
    );
  }

  Widget _buildFilterButton() {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                context.r(50),
              ),
            ),
          ),
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: EdgeInsets.all(context.i(16.0)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 200,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                              context.r(2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.h(16),
                      ),
                      Center(
                        child: Text(
                          'Filtering',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: context.sp(32),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.h(24),
                      ),
                      Text(
                        'DBU',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: context.sp(18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: [
                          _buildCustomFilterChip(
                            label: 'Seni dan Olahraga',
                            isSelected: selectedCategories
                                .contains('Seni dan Olahraga'),
                            onSelected: (bool selected) {
                              setState(() {
                                toggleFilter('Seni dan Olahraga');
                              });
                            },
                          ),
                          _buildCustomFilterChip(
                            label: 'Luar Himpunan',
                            isSelected:
                                selectedCategories.contains('Luar Himpunan'),
                            onSelected: (bool selected) {
                              setState(() {
                                toggleFilter('Luar Himpunan');
                              });
                            },
                          ),
                          _buildCustomFilterChip(
                            label: 'PSDA',
                            isSelected: selectedCategories.contains('PSDA'),
                            onSelected: (bool selected) {
                              setState(() {
                                toggleFilter('PSDA');
                              });
                            },
                          ),
                          _buildCustomFilterChip(
                            label: 'Risetdikti',
                            isSelected:
                                selectedCategories.contains('Risetdikti'),
                            onSelected: (bool selected) {
                              setState(() {
                                toggleFilter('Risetdikti');
                              });
                            },
                          ),
                          _buildCustomFilterChip(
                            label: 'Rohani Islam',
                            isSelected:
                                selectedCategories.contains('Rohani Islam'),
                            onSelected: (bool selected) {
                              setState(() {
                                toggleFilter('Rohani Islam');
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: context.h(16),
                      ),
                      Text(
                        'Kategori',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: context.sp(18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: [
                          _buildCustomFilterChip(
                            label: 'Non Akademik',
                            isSelected:
                                selectedCategories.contains('Non Akademik'),
                            onSelected: (bool selected) {
                              setState(() {
                                toggleFilter('Non Akademik');
                              });
                            },
                          ),
                          _buildCustomFilterChip(
                            label: 'Akademik',
                            isSelected: selectedCategories.contains('Akademik'),
                            onSelected: (bool selected) {
                              setState(() {
                                toggleFilter('Akademik');
                              });
                            },
                          ),
                          _buildCustomFilterChip(
                            label: 'Kompetisi',
                            isSelected:
                                selectedCategories.contains('Kompetisi'),
                            onSelected: (bool selected) {
                              setState(() {
                                toggleFilter('Kompetisi');
                              });
                            },
                          ),
                          _buildCustomFilterChip(
                            label: 'Sosial',
                            isSelected: selectedCategories.contains('Sosial'),
                            onSelected: (bool selected) {
                              setState(() {
                                toggleFilter('Sosial');
                              });
                            },
                          ),
                          _buildCustomFilterChip(
                            label: 'Rohani',
                            isSelected: selectedCategories.contains('Rohani'),
                            onSelected: (bool selected) {
                              setState(() {
                                toggleFilter('Rohani');
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: context.h(24),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: context.w(16.0)),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            context.r(8.0),
          ),
        ),
      ),
      child: const Icon(
        Icons.filter_list,
        color: Color(0xFF04339B),
      ),
    );
  }

  static const TextStyle _titleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.bold,
  );
}

class EventCard extends StatelessWidget {
  final EventEntity event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner event
            Container(
              height: 100,
              width: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  event.bannerUrl ??
                      'https://via.placeholder.com/340x100', // Ganti dengan sumber gambar fallback
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Log error
                    logger.e('Error loading image: $error');
                    return Container(
                      color: Colors.grey,
                      child: const Center(
                        child: Text(
                          'Error loading image',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Elemen kategori event
            Wrap(
              spacing: 6.0,
              children:
                  (event.category?.split(', ') ?? []).map<Widget>((category) {
                return Chip(
                  label: Text(
                    category,
                    style: const TextStyle(
                      fontFamily: 'Urbanist Bold',
                      fontSize: 10.0, // Ubah ukuran teks
                      fontWeight: FontWeight.bold, // Ubah ketebalan teks
                      color: Colors.white, // Ubah warna teks
                    ),
                  ),
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Ubah border radius
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),

            // Judul event
            Text(
              event.title ?? 'No Title',
              style: const TextStyle(
                fontFamily: 'Urbanist Bold',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // Deskripsi event
            Text(
              event.description ?? 'No Description',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
