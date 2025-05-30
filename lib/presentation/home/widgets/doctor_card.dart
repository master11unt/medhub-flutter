import 'package:flutter/material.dart';
import '../../../models/doctor.dart';
import '../pages/home_dan_konsultasi/doctor_detail_page.dart'; // Import page detail

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorDetailPage(doctor: doctor),
          ),
        );
      },
      child: Container(
        width: 125,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar dokter dengan border + radius
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(0, 0, 0, 0.10),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                doctor.imagePath,
                height: 125,
                width: 125,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 8),

            // Teks nama dokter
            Text(
              doctor.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Text(
              'Dokter Umum',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
