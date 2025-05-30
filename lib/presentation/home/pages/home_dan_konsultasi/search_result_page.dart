import 'package:flutter/material.dart';
import 'package:medhub/models/doctor.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/doctor_detail_page.dart';

class SearchResultPage extends StatelessWidget {
  final String keyword;

  const SearchResultPage({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> doctors = [
      {
        'name': 'dr. Rayan Ilham Nugraha',
        'specialty': 'Dokter Umum',
        'image': 'assets/images/img_dokter.png',
        'days': 'Senin, Rabu',
        'rating': '96%',
        'status': 'Online',
        'consulting': false,
      },
      {
        'name': 'dr. Raihana Nur Azizah',
        'specialty': 'Dokter Anak',
        'image': 'assets/images/img_dokter.png',
        'days': 'Senin, Rabu',
        'rating': '96%',
        'status': 'Online',
        'consulting': true,
      },
      {
        'name': 'dr. Reihan Putra Mahendra',
        'specialty': 'Dokter Saraf',
        'image': 'assets/images/img_dokter.png',
        'days': 'Senin, Rabu',
        'rating': '96%',
        'status': 'Online',
        'consulting': false,
      },
      {
        'name': 'dr. Rihana Ardelia',
        'specialty': 'Dokter Kandungan',
        'image': 'assets/images/img_dokter.png',
        'days': 'Senin, Rabu',
        'rating': '96%',
        'status': 'Online',
        'consulting': false,
      },
    ];

    // ✅ Filter berdasarkan keyword
    final lowerKeyword = keyword.toLowerCase();
    final filteredDoctors = doctors.where((doctor) {
      return doctor['name'].toLowerCase().contains(lowerKeyword) ||
             doctor['specialty'].toLowerCase().contains(lowerKeyword);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cari Dokter',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: filteredDoctors.isEmpty
            ? const Center(
                child: Text(
                  'Tidak ditemukan hasil untuk pencarianmu.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : ListView.separated(
                itemCount: filteredDoctors.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final doctor = filteredDoctors[index];
                  return DoctorCardItem(doctor: doctor);
                },
              ),
      ),
    );
  }
}

class DoctorCardItem extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorCardItem({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(doctor['image'], height: 100, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        doctor['specialty'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.circle, size: 8, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(
                      doctor['status'],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildInfoBadge(Icons.work, doctor['days']),
                    const SizedBox(width: 8),
                    _buildInfoBadge(Icons.thumb_up, doctor['rating']),
                  ],
                ),
                if (doctor['consulting']) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.circle, size: 8, color: Colors.orange),
                        SizedBox(width: 4),
                        Text(
                          'Sedang Konsultasi',
                          style: TextStyle(fontSize: 12, color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => DoctorDetailPage(
      doctor: Doctor(
        name: 'Dr. Dummy',
        imagePath: 'assets/images/dokter_dummy.png',
      ),
    ),
  ),
);

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A99D),
                      minimumSize: const Size(80, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    child: const Text(
                      'Pilih',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String text) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: Colors.orange),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
