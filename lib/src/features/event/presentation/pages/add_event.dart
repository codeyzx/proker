import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/features/event/domain/usecases/create_event_usecase.dart';
import 'package:proker/src/features/event/presentation/bloc/event/event_cubit.dart';

@RoutePage()
class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _benefitController = TextEditingController();
  final _locationController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  List<String> selectedCategories = [];
  String? selectedType;
  File? _selectedImage;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _benefitController.dispose();
    _locationController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void toggleFilter(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
    });
  }

  void toggleType(String type) {
    setState(() {
      if (selectedType == type) {
        selectedType = null;
      } else {
        selectedType = type;
      }
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final PickedFile? pickedFile =
        await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Widget _buildCustomFilterChip({
    required String label,
    required bool isSelected,
    required ValueChanged<bool> onSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Margin vertikal
      child: FilterChip(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF04339B),
            fontSize: 16,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.bold,
          ),
        ),
        selected: isSelected,
        onSelected: onSelected,
        backgroundColor: isSelected ? const Color(0xFF04339B) : Colors.white,
        selectedColor: const Color(0xFF04339B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
          side: const BorderSide(
            color: Color(0xFF04339B),
          ),
        ),
        showCheckmark: false,
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('MMMM dd, yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventCubit>(
      create: (_) => getIt<EventCubit>(),
      child: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) => Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _buildBlueSection(),
                _buildWhiteSection(context),
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper), label: 'Feed'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
            currentIndex: 2,
            onTap: (index) {
              setState(() {
                // Handle navigation
              });
            },
            selectedLabelStyle: const TextStyle(fontFamily: 'Urbanist'),
            unselectedLabelStyle: const TextStyle(fontFamily: 'Urbanist'),
            selectedFontSize: 12.0,
            unselectedFontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildBlueSection() {
    return Container(
      color: const Color(0xFF04339B),
      height: 91.0, // Berikan tinggi eksplisit
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40.0),
      child: const Column(
        children: [
          Text(
            'Tambah Event Baru',
            style: _titleTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildWhiteSection(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildSectionTitle('Nama Event'),
                _buildTextField(
                  controller: _titleController,
                  hintText: 'Isi nama event baru...',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Nama event diperlukan'
                      : null,
                ),
                _buildSectionTitle('Jenis Event'),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8.0,
                    children: [
                      _buildCustomFilterChip(
                        label: 'Program Kerja',
                        isSelected: selectedType == 'Program Kerja',
                        onSelected: (bool selected) {
                          toggleType('Program Kerja');
                        },
                      ),
                      _buildCustomFilterChip(
                        label: 'Pergerakan',
                        isSelected: selectedType == 'Pergerakan',
                        onSelected: (bool selected) {
                          toggleType('Pergerakan');
                        },
                      ),
                    ],
                  ),
                ),
                _buildSectionTitle('Kategori Event'),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8.0,
                    children: [
                      _buildCustomFilterChip(
                        label: 'Akademik',
                        isSelected: selectedCategories.contains('Akademik'),
                        onSelected: (bool selected) {
                          toggleFilter('Akademik');
                        },
                      ),
                      _buildCustomFilterChip(
                        label: 'Non Akademik',
                        isSelected: selectedCategories.contains('Non Akademik'),
                        onSelected: (bool selected) {
                          toggleFilter('Non Akademik');
                        },
                      ),
                      _buildCustomFilterChip(
                        label: 'Sosial',
                        isSelected: selectedCategories.contains('Sosial'),
                        onSelected: (bool selected) {
                          toggleFilter('Sosial');
                        },
                      ),
                      _buildCustomFilterChip(
                        label: 'Edukasi',
                        isSelected: selectedCategories.contains('Edukasi'),
                        onSelected: (bool selected) {
                          toggleFilter('Edukasi');
                        },
                      ),
                      _buildCustomFilterChip(
                        label: 'Kompetisi',
                        isSelected: selectedCategories.contains('Kompetisi'),
                        onSelected: (bool selected) {
                          toggleFilter('Kompetisi');
                        },
                      ),
                      _buildCustomFilterChip(
                        label: 'Himpunan',
                        isSelected: selectedCategories.contains('Himpunan'),
                        onSelected: (bool selected) {
                          toggleFilter('Himpunan');
                        },
                      ),
                      _buildCustomFilterChip(
                        label: 'Rohani',
                        isSelected: selectedCategories.contains('Rohani'),
                        onSelected: (bool selected) {
                          toggleFilter('Rohani');
                        },
                      ),
                      _buildCustomFilterChip(
                        label: 'Pengabdian',
                        isSelected: selectedCategories.contains('Pengabdian'),
                        onSelected: (bool selected) {
                          toggleFilter('Pengabdian');
                        },
                      ),
                      _buildCustomFilterChip(
                        label: 'Peminatan',
                        isSelected: selectedCategories.contains('Peminatan'),
                        onSelected: (bool selected) {
                          toggleFilter('Peminatan');
                        },
                      ),
                    ],
                  ),
                ),
                _buildSectionTitle('Deskripsi Event'),
                _buildTextField(
                  controller: _descriptionController,
                  hintText: 'Isi deskripsi event baru...',
                  height: 175,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Deskripsi event diperlukan'
                      : null,
                ),
                _buildSectionTitle('Manfaat Event'),
                _buildTextField(
                  controller: _benefitController,
                  hintText: 'Isi manfaat event baru...',
                  height: 85,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Manfaat event diperlukan'
                      : null,
                ),
                _buildSectionTitle('Waktu dan Lokasi Event'),
                _buildDateField(
                  controller: _startDateController,
                  hintText: 'Pilih tanggal mulai...',
                  icon: Icons.calendar_today,
                  onTap: () => _selectDate(context, _startDateController),
                ),
                _buildDateField(
                  controller: _endDateController,
                  hintText: 'Pilih tanggal akhir...',
                  icon: Icons.calendar_today,
                  onTap: () => _selectDate(context, _endDateController),
                ),
                _buildTextField(
                  controller: _locationController,
                  hintText: 'Isi lokasi event baru...',
                  icon: Icons.map_outlined,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Lokasi event diperlukan'
                      : null,
                ),
                _buildSectionTitle('Banner Event'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorderButton(
                    onTap: _pickImage,
                    selectedImage: _selectedImage,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double
                      .infinity, // Membuat tombol membentang dari kiri ke kanan
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final DateFormat formatter =
                            DateFormat('MMMM dd, yyyy');
                        final DateTime startDate =
                            formatter.parse(_startDateController.text);
                        final DateTime endDate =
                            formatter.parse(_endDateController.text);

                        final params = Params(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          benefits: _benefitController.text,
                          location: _locationController.text,
                          startDate: startDate,
                          endDate: endDate,
                          category: selectedCategories.join(', '),
                          createdBy:
                              'currentUserId', // Replace with actual user ID
                          bannerUrl:
                              'https://ibb.co.com/LPW5vSt', // URL foto random
                          type: selectedType ?? 'Program Kerja',
                          status: 'Unpublished',
                        );

                        context.read<EventCubit>().create(params);
                        context.router.push(const KelolaEventRoute());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF04339B), // Warna tombol
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0), // Padding vertikal
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Radius border
                      ),
                    ),
                    child: const Text(
                      'Submit Event Baru',
                      style: TextStyle(
                        color: Colors.white, // Warna font
                        fontFamily: 'Urbanist', // Font family
                        fontWeight: FontWeight.bold, // Font weight
                        fontSize: 18, // Font size
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    double height = 50,
    IconData? icon,
    String? Function(String?)? validator,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: 'Urbanist',
          ),
          border: InputBorder.none,
          icon: icon != null ? Icon(icon) : null,
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: 'Urbanist',
          ),
          border: InputBorder.none,
          icon: Icon(icon),
        ),
        readOnly: true,
        onTap: onTap,
      ),
    );
  }

  static const TextStyle _titleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.bold,
  );
}

class DottedBorderButton extends StatelessWidget {
  final VoidCallback onTap;
  final File? selectedImage;

  const DottedBorderButton({
    super.key,
    required this.onTap,
    this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        color: const Color(0xFF04339B),
        borderType: BorderType.RRect,
        radius: const Radius.circular(20),
        dashPattern: const [4, 3],
        strokeWidth: 2,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: selectedImage != null
                ? DecorationImage(
                    image: FileImage(selectedImage!),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.7),
                      BlendMode.darken,
                    ),
                  )
                : null,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_box_outlined,
                  color: selectedImage == null
                      ? const Color(0xFF04339B)
                      : Colors.white,
                ),
                Text(
                  'Tambah Banner Event',
                  style: TextStyle(
                    color: selectedImage == null
                        ? const Color(0xFF04339B)
                        : Colors.white,
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
