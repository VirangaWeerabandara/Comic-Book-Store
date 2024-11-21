import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCityPage extends StatelessWidget {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  AddCityPage({Key? key}) : super(key: key);

  Future<void> _addCity() async {
    final city = <String, String>{
      "name": "Los Angeles",
      "state": "CA",
      "country": "USA"
    };

    try {
      await db.collection("cities").doc("LA").set(city);
      print("Document added successfully!");
    } catch (e) {
      print("Error writing document: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add City to Firestore'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _addCity,
          child: const Text('Add City to Firestore'),
        ),
      ),
    );
  }
}
