import 'package:cloud_firestore/cloud_firestore.dart';

class ApiUrl {
  const ApiUrl._();

  static const baseUrl = "https://....com/api/v1";

  static final users = FirebaseFirestore.instance.collection("users");
  static final events = FirebaseFirestore.instance.collection("events");
}
