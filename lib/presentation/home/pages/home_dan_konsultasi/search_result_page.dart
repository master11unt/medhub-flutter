import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medhub/data/datasource/doctor_remote_datasource.dart';
import 'package:medhub/data/model/response/doctor_response_model.dart';
import 'package:medhub/presentation/home/bloc/doctor/doctor_bloc.dart';
import 'package:medhub/presentation/home/bloc/doctor/doctor_event.dart';
import 'package:medhub/presentation/home/bloc/doctor/doctor_state.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/doctor_detail_page.dart';

class SearchResultPage extends StatelessWidget {
  final String keyword;

  const SearchResultPage({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
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
      body: BlocProvider(
        create: (context) => DoctorBloc(DoctorRemoteDatasource())
          ..add(DoctorSearch(keyword)),
        child: BlocBuilder<DoctorBloc, DoctorState>(
          builder: (context, state) {
            if (state is DoctorLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DoctorLoaded) {
              final doctors = state.doctors;
              if (doctors.isEmpty) {
                return const Center(
                  child: Text(
                    'Tidak ditemukan hasil untuk pencarianmu.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
              
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemCount: doctors.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return DoctorCardItem(doctor: doctors[index]);
                  },
                ),
              );
            } else if (state is DoctorError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class DoctorCardItem extends StatelessWidget {
  final Doctor doctor;

  const DoctorCardItem({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final bool isOnline = doctor.isOnline == 1;
    final bool isConsulting = doctor.isInConsultation == 1;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: doctor.user?.image != null
              ? Image.network(
                  doctor.user!.image!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/images/dokter1.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  'assets/images/dokter1.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.user?.name ?? '-',
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
                        doctor.specialization ?? '-',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: isOnline ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isOnline ? 'Online' : 'Offline',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildInfoBadge(
                      Icons.work,
                      doctor.schedules != null && doctor.schedules!.isNotEmpty
                          ? doctor.schedules![0].day ?? '-'
                          : '-',
                    ),
                    const SizedBox(width: 8),
                    _buildInfoBadge(
                      Icons.thumb_up,
                      doctor.averageRating ?? '0.0',
                    ),
                  ],
                ),
                if (isConsulting) ...[
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
                          builder: (_) => DoctorDetailPage(doctor: doctor),
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