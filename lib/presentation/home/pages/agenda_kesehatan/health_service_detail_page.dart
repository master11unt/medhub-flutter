import 'package:flutter/material.dart';
import 'package:medhub/presentation/home/pages/agenda_kesehatan/pendaftaran_page.dart';
import '../../../../models/health_service.dart';

class HealthServiceDetailPage extends StatelessWidget {
  final HealthService service;

  const HealthServiceDetailPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          service.title,
          style: const TextStyle(
            color: Color(0xFF00A99D),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF00A99D),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(service.imagePath),
            ),
            const SizedBox(height: 24),
            Text(
              '${service.title} - Program Kesehatan Masyarakat',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Layanan vaksin gratis ini merupakan bagian dari program pemerintah dan instansi kesehatan untuk meningkatkan kekebalan tubuh masyarakat terhadap penyakit tertentu seperti influenza, hepatitis, dan lainnya. Vaksin tersedia untuk berbagai kelompok usia dan diberikan oleh tenaga medis terpercaya.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Text(
              'Lokasi Fasilitas',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(service.location),
            const SizedBox(height: 16),
            const Text(
              'Jadwal Layanan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(service.dateTime),
            const SizedBox(height: 16),
            const Text(
              'Syarat dan Ketentuan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('''
1. Usia minimal 12 tahun
2. Membawa kartu identitas (KTP/KIA/KK)
3. Dalam kondisi sehat (tidak sedang demam/batuk berat)
4. Belum menerima vaksin serupa dalam 6 bulan terakhir
5. Wajib memakai masker saat datang ke lokasi
'''),
            const SizedBox(height: 24),
            SafeArea(
              minimum: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A99D),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PendaftaranPage(service: service),
                      ),
                    );
                  },
                  child: const Text(
                    'Daftar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
