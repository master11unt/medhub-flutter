import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchEdukasiPage extends StatefulWidget {
  const SearchEdukasiPage({super.key});

  @override
  State<SearchEdukasiPage> createState() => _SearchEdukasiPageState();
}

class _SearchEdukasiPageState extends State<SearchEdukasiPage> {
  final List<String> kategori = [
    'Keselamatan berkendara',
    'Ergonomi',
    'Tips sehat',
    'Mengemudi nyaman',
  ];

  final List<Map<String, String>> artikelList = [
    {
      'image': 'assets/images/artikel1.png',
      'tag': 'Keselamatan berkendara',
      'title': 'Tips Mencegah Dehidrasi Saat Mengemudi',
      'desc': 'Mengemudi dalam waktu lama dapat menyebabkan dehidrasi, yang berisiko menurunkan konsentrasi',
    },
    {
      'image': 'assets/images/artikel2.png',
      'tag': 'Ergonomi',
      'title': 'Mengatur Posisi Duduk yang Benar untuk Mengemudi',
      'desc': 'Posisi duduk yang salah dapat menyebabkan nyeri punggung dan leher kaku...',
    },
    {
      'image': 'assets/images/artikel3.png',
      'tag': 'Tips sehat',
      'title': 'Waspadai Gejala Hipoglikemia Saat Mengemudi',
      'desc': 'Mengemudi dalam waktu lama dapat menyebabkan dehidrasi...',
    },
    {
      'image': 'assets/images/artikel4.png',
      'tag': 'Mengemudi nyaman',
      'title': 'Senam Ringan di Mobil untuk Mengurangi Ketegangan',
      'desc': 'Melakukan gerakan peregangan ringan saat berhenti...',
    },
  ];

  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    final filteredArtikel = selectedCategory.isEmpty
        ? []
        : artikelList
            .where((item) => item['tag']!.toLowerCase() == selectedCategory.toLowerCase())
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, size: 18, color: Colors.teal),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edukasi Pengendara',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.teal,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Edukasi',
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Pilih Kategori',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),

            const SizedBox(height: 16),

            // Kategori List
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: kategori.map((item) {
                final isSelected = selectedCategory == item;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedCategory = item;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    constraints: const BoxConstraints(minWidth: 60, maxWidth: 160),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.teal.shade50 : Colors.grey.shade100,
                      border: Border.all(color: Colors.teal.shade300),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      item,
                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Artikel List sesuai Kategori
            if (selectedCategory.isNotEmpty)
              Expanded(
                child: filteredArtikel.isNotEmpty
                    ? ListView.builder(
                        itemCount: filteredArtikel.length,
                        itemBuilder: (context, index) {
                          final artikel = filteredArtikel[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    artikel['image']!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEAF3FF),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          artikel['tag']!,
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF0C4CA6),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        artikel['title']!,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        artikel['desc']!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'Belum ada artikel untuk kategori ini',
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                        ),
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
