import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  // Daftar event
  final List<Map<String, dynamic>> events = [
    {
      'title': 'Himakom E-Sport Championship (HeSC)',
      'description':
          'Kompetisi dibidang e-Sport dalam ruang lingkup HIMAKOM guna menyalurkan minat dan bakat Mahasiswa/i dibidang e-Sport dan mempererat tali silaturahmi antar Mahasiswa/i baik dengan Mahasiswa/i lainnya maupun Alumni.',
      'categories': ['Kompetisi', 'Peminatan', 'Non Akademik'],
      'image': 'assets/images/banner_proker_1.png',
      'jenis': 'Program Kerja',
      'status': 'New',
      'pengelola': 'Seni dan Olahraga',
    },
    {
      'title': 'Speak Up Day',
      'description':
          'Workshop HIMAKOM dengan pembicara yang membahas teknologi baru dan Pekan Kreativitas Mahasiswa.',
      'categories': ['Non Akademik', 'Sosial'],
      'image': 'assets/images/banner_proker_2.png',
      'jenis': 'Program Kerja',
      'status': 'Upcoming',
      'pengelola': 'PSDA',
    },
    {
      'title': 'Kajian Islam Teknologi',
      'description':
          'Kajian tentang hubungan majunya teknologi dan dampaknya terhadap perkembangan agama Islam.',
      'categories': ['Non Akademik', 'Rohani'],
      'image': 'assets/images/banner_proker_3.png',
      'jenis': 'Program Kerja',
      'status': 'Done',
      'pengelola': 'Rohani Islam',
    },
  ];

  // Daftar event yang difilter
  List<Map<String, dynamic>> filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _filterEvents(); // Inisialisasi event yang difilter
    filteredEvents; // Inisialisasi dengan semua event
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
      filteredEvents = events.where((event) {
        final matchesJenis = event['jenis'] == selectedValue;
        final matchesStatus = (isNewSelected && event['status'] == 'New') ||
            (isUpcomingSelected && event['status'] == 'Upcoming') ||
            (isDoneSelected && event['status'] == 'Done');
        final matchesPengelola = selectedCategories.isEmpty ||
            selectedCategories.contains(event['pengelola']);
        final matchesSearch = searchText.isEmpty ||
            event['title'].toLowerCase().contains(searchText) ||
            event['description'].toLowerCase().contains(searchText);
        return matchesJenis &&
            matchesStatus &&
            matchesPengelola &&
            matchesSearch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildBlueSection(),
            _buildWhiteSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildBlueSection() {
    return Container(
      color: const Color(0xFF04339B),
      height: 260.0, // Berikan tinggi eksplisit
      width: double.infinity,
      padding: EdgeInsets.only(top: context.i(20.0)),
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
      child: ListView.builder(
        itemCount: filteredEvents.length, // Jumlah event yang difilter
        itemBuilder: (context, index) {
          final event = filteredEvents[index];
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.h(8.0), horizontal: context.w(16.0)),
            child: EventCard(event: event),
          );
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
              color:
                  selectedValue == item ? const Color(0xFF04339B) : Colors.grey,
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
          color: isSelected ? const Color(0xFF04339B) : Colors.grey,
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
      backgroundColor: isSelected ? const Color(0xFF04339B) : Colors.white,
      selectedColor: const Color(0xFF04339B),
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
                            color: const Color(0xFF04339B),
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
  final Map<String, dynamic> event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          context.r(12),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(context.i(16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner event
            Container(
              height: 100,
              width: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  context.r(12),
                ),
                image: DecorationImage(
                  image:
                      AssetImage(event['image']), // Ganti dengan sumber gambar
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: context.h(8),
            ),

            // Elemen kategori event
            Wrap(
              spacing: 6.0,
              children: event['categories'].map<Widget>((category) {
                return Chip(
                  label: Text(
                    category,
                    style: TextStyle(
                      fontFamily: 'Urbanist Bold',
                      fontSize: context.sp(10.0), // Ubah ukuran teks
                      fontWeight: FontWeight.bold, // Ubah ketebalan teks
                      color: Colors.white, // Ubah warna teks
                    ),
                  ),
                  backgroundColor: const Color(0xFF04339B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      context.r(20.0),
                    ), // Ubah border radius
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: context.h(8),
            ),

            // Judul event
            Text(
              event['title'],
              style: TextStyle(
                fontFamily: 'Urbanist Bold',
                fontSize: context.sp(16),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: context.h(4),
            ),

            // Deskripsi event
            Text(
              event['description'],
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: context.sp(12),
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
