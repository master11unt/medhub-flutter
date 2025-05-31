import 'package:flutter/material.dart';
import 'package:medhub/data/model/response/doctor_response_model.dart';
import '../pages/home_dan_konsultasi/doctor_detail_page.dart';

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
          children: [
            CircleAvatar(
              backgroundImage: doctor.user?.image != null
                  ? NetworkImage(doctor.user!.image!)
                  : const AssetImage('assets/images/default_doctor.png') as ImageProvider,
              radius: 40,
            ),
            const SizedBox(height: 8),
            Text(doctor.user?.name ?? '-', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(doctor.specialization ?? 'Dokter'),
          ],
        ),
      ),
    );
  }
}