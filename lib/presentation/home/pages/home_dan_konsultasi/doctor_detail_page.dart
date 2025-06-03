import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/data/datasource/doctor_remote_datasource.dart';
import 'package:medhub/data/model/response/doctor_response_model.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/appointment_page.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/konsultasi_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDetailPage extends StatefulWidget {
  final Doctor doctor;
  final bool fromSearch;

  const DoctorDetailPage({
    super.key,  
    required this.doctor,
    this.fromSearch = false,
  });

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  Doctor? _detailedDoctor;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadDetailedDoctor();
    _checkIfFavorite();
  }

  Future<void> _loadDetailedDoctor() async {
    // Only fetch detailed data if needed (e.g., from search results)
    if (widget.fromSearch || _needsDetailedInfo(widget.doctor)) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final result = await DoctorRemoteDatasource().getDoctorDetail(
          widget.doctor.id ?? 0,
        );

        result.fold(
          (error) {
            setState(() {
              _errorMessage = error;
              _isLoading = false;
            });
          },
          (doctor) {
            setState(() {
              _detailedDoctor = doctor;
              _isLoading = false;
            });
          },
        );
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _detailedDoctor = widget.doctor;
      });
    }
  }

  // Check if we need to fetch more detailed information
  bool _needsDetailedInfo(Doctor doctor) {
    return doctor.description == null ||
        doctor.education == null ||
        doctor.practicePlace == null ||
        doctor.licenseNumber == null;
  }

  Future<void> _checkIfFavorite() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> favorites =
          prefs.getStringList('favorite_doctors') ?? [];
      setState(() {
        _isFavorite = favorites.contains(widget.doctor.id.toString());
      });
    } catch (e) {
      debugPrint('Error checking favorite status: $e');
    }
  }

  Future<void> _toggleFavorite() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> favorites =
          prefs.getStringList('favorite_doctors') ?? [];

      setState(() {
        if (_isFavorite) {
          favorites.remove(widget.doctor.id.toString());
          _isFavorite = false;
        } else {
          favorites.add(widget.doctor.id.toString());
          _isFavorite = true;
        }
      });

      await prefs.setStringList('favorite_doctors', favorites);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isFavorite
                ? 'Dokter ditambahkan ke favorit'
                : 'Dokter dihapus dari favorit',
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: const Color(0xFF00A99D),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui favorit: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00A99D)),
        ),
      ),
    );
  }

  void _startConsultation() {
    showLoadingDialog(context);

    // Simulate connection process
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog

      // Check if doctor is still online before proceeding
      if (_detailedDoctor?.isOnline == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ConsultationChatPage(
                  doctorId: _detailedDoctor?.id ?? widget.doctor.id ?? 0,
                  doctorName:
                      _detailedDoctor?.user?.name ??
                      widget.doctor.user?.name ??
                      'Dokter',
                  doctorSpecialty:
                      _detailedDoctor?.specialization ??
                      widget.doctor.specialization ??
                      'Dokter Umum',
                  doctorImage:
                      _detailedDoctor?.user?.image ?? widget.doctor.user?.image,
                ),
          ),
        );
      } else {
        // Show error if doctor is offline
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dokter sedang offline. Silakan coba lagi nanti.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  void _navigateToAppointment() async {
    final Doctor doctorToUse = _detailedDoctor ?? widget.doctor;

    if (doctorToUse.id == null || doctorToUse.id == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data dokter tidak lengkap, tidak bisa membuat janji.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Tampilkan loading dialog
    showLoadingDialog(context);

    // Delay sedikit agar dialog muncul sebelum push
    await Future.delayed(const Duration(milliseconds: 400));

    // Navigasi ke AppointmentPage
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentPage(doctor: doctorToUse),
      ),
    );

    // Tutup loading dialog setelah kembali dari AppointmentPage
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use detailed doctor if available, otherwise use the original
    final doctor = _detailedDoctor ?? widget.doctor;
    final isInConsultation = doctor.isInConsultation == 1;
    final isOnline = doctor.isOnline == 1;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            onPressed: () => Navigator.pop(context),
            color: const Color(0xFF00A89E),
          ),
          title: Text(
            'Informasi Dokter',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: const Color(0xFF00A89E),
            ),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00A99D)),
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            onPressed: () => Navigator.pop(context),
            color: const Color(0xFF00A89E),
          ),
          title: Text(
            'Informasi Dokter',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: const Color(0xFF00A89E),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error: $_errorMessage',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loadDetailedDoctor,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A99D),
                ),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
          color: const Color(0xFF00A89E),
        ),
        title: Text(
          'Informasi Dokter',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: const Color(0xFF00A89E),
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       _isFavorite ? Icons.favorite : Icons.favorite_border,
        //       color: _isFavorite ? Colors.red : Colors.grey,
        //     ),
        //     onPressed: _toggleFavorite,
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.share, color: Colors.grey),
        //     onPressed: () {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(
        //           content: Text('Fitur berbagi sedang dikembangkan'),
        //           duration: Duration(seconds: 2),
        //         ),
        //       );
        //     },
        //   ),
        // ],
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:
                        doctor.user?.image != null
                            ? Image.network(
                              doctor.user!.image!,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/dokter1.png',
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.contain,
                                );
                              },
                            )
                            : Image.asset(
                              'assets/images/dokter1.png',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: isOnline ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isOnline ? 'Online' : 'Offline',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isInConsultation)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3CD),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 10,
                              color: Color(0xFF856404),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Sedang Konsultasi',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF856404),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              doctor.user?.name ?? '-',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              doctor.specialization ?? 'Dokter',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.lock_clock,
                        size: 16,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      // Text(
                      //   (doctor.schedules != null &&
                      //           doctor.schedules!.isNotEmpty
                      //       ? "${doctor.schedules![0].day}, ${doctor.schedules![0].startTime} - ${doctor.schedules![0].endTime}"
                      //       : 'Jadwal tidak tersedia'),
                      //   style: const TextStyle(
                      //     fontSize: 12,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      Text(
                        _getPracticeScheduleText(doctor),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.thumb_up,
                        size: 16,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${doctor.averageRating ?? '-'}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              doctor.description ?? 'Informasi dokter tidak tersedia',
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 24),
            const Text(
              'Pendidikan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              doctor.education ?? '-',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              'Praktik',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              doctor.practicePlace ?? '-',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nomor STR',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              doctor.licenseNumber ?? '-',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _navigateToAppointment,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF00A99D)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Buat Janji',
                  style: TextStyle(
                    color: Color(0xFF00A99D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed:
                    isInConsultation || !isOnline ? null : _startConsultation,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isInConsultation || !isOnline
                          ? Colors.grey
                          : const Color(0xFF00A99D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Konsultasi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        isInConsultation || !isOnline
                            ? Colors.white70
                            : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPracticeScheduleText(Doctor doctor) {
    if (doctor.schedules != null && doctor.schedules!.isNotEmpty) {
      return doctor.schedules!
          .map((s) => "${s.day ?? ''}, ${s.startTime ?? ''} - ${s.endTime ?? ''}")
          .join('\n');
    }
    return 'Jadwal tidak tersedia';
  }
}
