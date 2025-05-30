import 'package:flutter/material.dart';
import 'package:medhub/models/doctor.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/doctor_detail_page.dart';

class CariDokterPage extends StatefulWidget {
  const CariDokterPage({super.key});

  @override
  State<CariDokterPage> createState() => _CariDokterPageState();
}

class _CariDokterPageState extends State<CariDokterPage> {
  final TextEditingController _searchController = TextEditingController();
  String keyword = '';

  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'dr. Rayan Ilham Nugraha',
      'specialty': 'Dokter Umum',
      'image': 'assets/images/img_dokter.png',
      'days': 'Senin, Rabu',
      'rating': '96%',
      'status': 'Online',
       'inConsultation': false,
    },
    {
      'name': 'dr. Raihana Nur Azizah',
      'specialty': 'Dokter Umum',
      'image': 'assets/images/img_dokter.png',
      'days': 'Senin, Rabu',
      'rating': '96%',
      'status': 'Online',
      'inConsultation': true,
    },
    {
      'name': 'dr. Reihan Putra Mahendra',
      'specialty': 'Dokter Umum',
      'image': 'assets/images/img_dokter.png',
      'days': 'Senin, Rabu',
      'rating': '96%',
      'status': 'Online',
       'inConsultation': false,
    },
    {
      'name': 'dr. Rihana Ardelia',
      'specialty': 'Dokter Umum',
      'image': 'assets/images/img_dokter.png',
      'days': 'Senin, Rabu',
      'rating': '96%',
      'status': 'Online',
       'inConsultation': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredDoctors = doctors.where((doctor) {
      final lowerKeyword = keyword.toLowerCase();
      return doctor['name'].toLowerCase().contains(lowerKeyword) ||
          doctor['specialty'].toLowerCase().contains(lowerKeyword);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF00A99D)),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 4),
            const Text(
              'Cari Dokter',
              style: TextStyle(
                color: Color(0xFF00A99D),
                fontSize: 18,
                fontWeight: FontWeight.w600,
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
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    keyword = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Cari Dokter',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredDoctors.isEmpty
                  ? const Center(
                      child: Text(
                        'Tidak ada hasil ditemukan.',
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
          ],
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
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
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
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      'Dokter Umum',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(width: 8),
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
                    _buildInfoChip(Icons.work, doctor['days']),
                    const SizedBox(width: 8),
                    _buildRatingChip(doctor['rating']),
                  ],
                ),
                if (doctor['inConsultation'] == true)
  Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3CD),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Sedang Konsultasi',
        style: TextStyle(
          color: Color(0xFF856404),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ),

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
                              name: doctor['name'],
                              imagePath: doctor['image'],
                               inConsultation: doctor['inConsultation'] ?? false,
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

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.orange),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingChip(String rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.thumb_up, size: 12, color: Colors.orange),
          const SizedBox(width: 4),
          Text(
            rating,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
