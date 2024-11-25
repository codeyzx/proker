import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:proker/src/core/config/router/app_router.dart';

@RoutePage()
class KelolaEventPage extends StatefulWidget {
  const KelolaEventPage({super.key});

  @override
  State<KelolaEventPage> createState() => _KelolaEventPageState();
}

class _KelolaEventPageState extends State<KelolaEventPage> {
  int _selectedIndex = 2; // Indeks halaman yang dipilih
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
      'image': 'assets/image/banner_proker_1.png',
      'jenis': 'Program Kerja',
      'status': 'New',
      'pengelola': 'Seni dan Olahraga',
    },
    {
      'title': 'Olahraga Rutinan',
      'description':
          'Olahraga Rutinan dalam ruang lingkup HIMAKOM guna meningkatkan kebugaran jasmani dan mempererat tali silaturahmi antar Mahasiswa/i HIMAKOM, baik dengan Mahasiswa/i lainnya maupun Alumni.',
      'categories': ['Non Akademik', 'Peminatan', 'Olahraga'],
      'image': 'assets/image/banner_pergerakan_2.png',
      'jenis': 'Pergerakan',
      'status': 'Upcoming',
      'pengelola': 'Seni dan Olahraga',
    },
    {
      'title': 'Himakom Musician',
      'description':
          'Himakom Musician dalam ruang lingkup HIMAKOM guna menyalurkan minat dan bakat Mahasiswa/i HIMAKOM dalam bermusik serta mempererat tali silaturahmi antar Mahasiswa/i, baik dengan Mahasiswa/i lainnya maupun Alumni.',
      'categories': ['Non Akademik', 'Peminatan'],
      'image': 'assets/image/banner_pergerakan_1.png',
      'jenis': 'Pergerakan',
      'status': 'Upcoming',
      'pengelola': 'Seni dan Olahraga',
    },
  ];

  // Daftar event yang difilter
  List<Map<String, dynamic>> filteredEvents = [];

  @override
  void initState() {
    super.initState();
    filteredEvents = events; // Inisialisasi dengan semua event
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _filterEvents() {
    setState(() {
      filteredEvents = events.where((event) {
        final matchesSearch = searchText.isEmpty ||
            event['title'].toLowerCase().contains(searchText) ||
            event['description'].toLowerCase().contains(searchText);
        return matchesSearch;
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Kelola Event',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(fontFamily: 'Urbanist'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Urbanist'),
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
      ),
    );
  }

  Widget _buildBlueSection() {
    return Container(
      color: const Color(0xFF04339B),
      height: 165.0, // Berikan tinggi eksplisit
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          const Text(
            'Event Yang Dikelola',
            style: _titleTextStyle,
          ),
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _buildWhiteSection() {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredEvents.length + 1, // Tambahkan satu item tambahan
        itemBuilder: (context, index) {
          if (index == filteredEvents.length) {
            // Tampilkan DottedBorderButton pada item terakhir
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: DottedBorderButton(),
            );
          } else {
            final event = filteredEvents[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: EventCard(event: event),
            );
          }
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchText = value.toLowerCase();
            _filterEvents();
          });
        },
        decoration: const InputDecoration(
          hintText: 'Cari Event Himakom...',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: 'Urbanist',
          ),
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
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

class DottedBorderButton extends StatelessWidget {
  const DottedBorderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(const AddEventRoute());
      },
      child: DottedBorder(
        color: const Color(0xFF04339B),
        borderType: BorderType.RRect,
        radius: const Radius.circular(20),
        dashPattern: const [4, 3],
        strokeWidth: 2,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_box_outlined, color: Color(0xFF04339B)),
                Text(
                  'Tambah Event Baru',
                  style: TextStyle(
                    color: Color(0xFF04339B),
                    fontFamily: 'Urbanist',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventCard({super.key, required this.event});

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
                image: DecorationImage(
                  image:
                      AssetImage(event['image']), // Ganti dengan sumber gambar
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Elemen status dan jenis event
            Wrap(
              spacing: 6.0,
              children: [
                Chip(
                  label: Text(
                    event['jenis'],
                    style: const TextStyle(
                      fontFamily: 'Urbanist Bold',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF04339B),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(
                      width: 2,
                      color: Color(0xFF04339B),
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    event['status'],
                    style: const TextStyle(
                      fontFamily: 'Urbanist Bold',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: _getStatusColor(event['status']),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            // Elemen kategori event
            Wrap(
              spacing: 6.0,
              children: event['categories'].map<Widget>((category) {
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
                  backgroundColor: const Color(0xFF04339B),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Ubah border radius
                  ),
                );
              }).toList(),
            ),

            // Judul event
            Text(
              event['title'],
              style: const TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // Deskripsi event
            Text(
              event['description'],
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
