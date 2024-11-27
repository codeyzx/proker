import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/config/themes/app_colors.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> fetchDataFromFirestore() async {
    final firestore = FirebaseFirestore.instance;

    try {
      // Fetch primary color
      final warnaDoc =
          await firestore.collection('warna').doc('4gvrWZTj8O2dWd67CuDU').get();
      if (warnaDoc.exists) {
        final colorCode = warnaDoc.data()?['code'] ?? '000000';
        AppColors.primary = Color(int.parse('0xFF$colorCode'));
        emit(HomeColorUpdated(color: AppColors.primary));
      }

      // Fetch banners
      final bannersQuery = await firestore
          .collection('banners')
          .where('status', isEqualTo: 'publish')
          .get();
      final banners = bannersQuery.docs
          .map((doc) => doc.data()['gambar'] as String)
          .toList();

      emit(HomeLoaded(banners: banners));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
