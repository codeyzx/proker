import 'package:flutter/material.dart';

Color getStatusColor(String status) {
  switch (status) {
    case 'New':
      return Colors.orange.shade300; // Kuning ke orenan
    case 'Upcoming':
      return Colors.purple; // Ungu
    case 'Finished':
      return Colors.green; // Hijau
    default:
      return Colors.grey; // Default (jika status tidak dikenal)
  }
}
