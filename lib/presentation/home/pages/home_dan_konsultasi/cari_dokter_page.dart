import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/data/datasource/doctor_remote_datasource.dart';
import 'package:medhub/data/model/response/doctor_response_model.dart';
import 'package:medhub/presentation/home/bloc/doctor/doctor_bloc.dart';
import 'package:medhub/presentation/home/bloc/doctor/doctor_event.dart';
import 'package:medhub/presentation/home/bloc/doctor/doctor_state.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/doctor_detail_page.dart';

class CariDokterPage extends StatefulWidget {
  const CariDokterPage({super.key});

  @override
  State<CariDokterPage> createState() => _CariDokterPageState();
}

class _CariDokterPageState extends State<CariDokterPage> {
  final TextEditingController _searchController = TextEditingController();
  String keyword = '';
  bool _isInitialized = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              DoctorBloc(DoctorRemoteDatasource())..add(DoctorFetchAll()),
      child: Builder(
        builder: (context) {
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
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF00A99D),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Cari Dokter',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF00A99D),
                      fontSize: 20,
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
                  // Search Bar
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

                        // Debounce search to avoid too many API calls
                        Future.delayed(const Duration(milliseconds: 500), () {
                          if (keyword == value) {
                            if (keyword.isEmpty) {
                              BlocProvider.of<DoctorBloc>(
                                context,
                              ).add(DoctorFetchAll());
                            } else {
                              BlocProvider.of<DoctorBloc>(
                                context,
                              ).add(DoctorSearch(keyword));
                            }
                          }
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

                  // Doctor List
                  Expanded(
                    child: BlocBuilder<DoctorBloc, DoctorState>(
                      builder: (context, state) {
                        if (state is DoctorLoading && !_isInitialized) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF00A99D),
                            ),
                          );
                        } else if (state is DoctorError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 48,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Error: ${state.message}',
                                  style: const TextStyle(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<DoctorBloc>(
                                      context,
                                    ).add(DoctorFetchAll());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF00A99D),
                                  ),
                                  child: const Text('Coba Lagi'),
                                ),
                              ],
                            ),
                          );
                        } else if (state is DoctorLoaded) {
                          _isInitialized = true;
                          final doctors = state.doctors;

                          if (doctors.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/empty_state.png',
                                    height: 120,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Tidak ada dokter ditemukan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  if (keyword.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      'Coba kata kunci lain atau periksa koneksi internet Anda',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }

                          return ListView.separated(
                            itemCount: doctors.length,
                            separatorBuilder:
                                (_, __) => const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              return ApiDoctorCardItem(doctor: doctors[index]);
                            },
                          );
                        }

                        // Default state or subsequent loading
                        return state is DoctorLoading
                            ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF00A99D),
                              ),
                            )
                            : Container(); // Empty container for other states
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ApiDoctorCardItem extends StatelessWidget {
  final Doctor doctor;

  const ApiDoctorCardItem({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final bool isOnline = doctor.isOnline == 1;
    final bool isConsulting = doctor.isInConsultation == 1;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
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
            child:
                doctor.user?.image != null
                    ? Image.network(
                      _getFullImageUrl(
                        doctor.user!.image!,
                      ), // Use helper function
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => Image.asset(
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
                  doctor.user?.name ?? 'Dokter',
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
                        doctor.specialization ?? 'Dokter Umum',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
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
                    _buildInfoChip(
                      Icons.work,
                      doctor.schedules != null && doctor.schedules!.isNotEmpty
                          ? doctor.schedules![0].day ?? 'Tidak ada jadwal'
                          : 'Tidak ada jadwal',
                    ),
                    const SizedBox(width: 8),
                    _buildRatingChip(doctor.averageRating ?? '0'),
                  ],
                ),
                if (isConsulting) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3CD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: Color(0xFF856404),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Sedang Konsultasi',
                          style: TextStyle(
                            color: Color(0xFF856404),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
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
          Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildRatingChip(dynamic rating) {
    // Convert the rating to a string regardless of its original type
    final displayRating =
        rating != null
            ? (rating is String
                ? (rating.contains('%')
                    ? rating
                    : '${(double.tryParse(rating) ?? 0.0).toStringAsFixed(1)}')
                : rating is int
                ? rating.toString()
                : rating is double
                ? rating.toStringAsFixed(1)
                : '0.0')
            : '0.0';

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
            displayRating,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

String _getFullImageUrl(String imagePath) {
  // Remove 'file:///' prefix if present
  if (imagePath.startsWith('file:///')) {
    imagePath = imagePath.substring(8);
  }

  // If the path already starts with http:// or https://, return as is
  if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
    return imagePath;
  }

  // Otherwise, prepend your API base URL
  const String baseApiUrl = 'https://api-medhub.fproject.my.id';

  // Ensure path starts with a slash if needed
  if (!imagePath.startsWith('/')) {
    imagePath = '/$imagePath';
  }

  return '$baseApiUrl$imagePath';
}
