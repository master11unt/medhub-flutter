import 'package:flutter/material.dart';

class CariObatPage extends StatelessWidget {
  const CariObatPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> kategori = [
      'Paratusin',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 8),
            const Text(
              'Cari Obat',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Field
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Obat',
                  hintStyle: const TextStyle(color: Colors.grey),// <-- warna abu-abu
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            // Pencarian Populer
            const Text(
              'Pencarian Terakhir',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey, // <-- warna abu-abu
              ),
            ),
            const SizedBox(height: 16),

            // Kategori
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: kategori.map((item) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    item,
                    style: const TextStyle(color: Colors.grey), // <-- warna abu-abu
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
