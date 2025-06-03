import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medhub/data/datasource/appointment_remote_datasource.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/model/response/appointment_response_model.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/konsultasi_page.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  bool _isLoading = true;
  String? _errorMessage;
  String? _currentUserName;
  List<AppointmentData> _appointments = [];

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _fetchAppointments();
  }

  Future<void> _loadCurrentUser() async {
    final authData = await AuthLocalDatasource().getAuthData();
    setState(() {
      _currentUserName = authData.user?.name;
    });
  }

  Future<void> _fetchAppointments() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final appointmentDatasource = AppointmentRemoteDatasource();
      final result = await appointmentDatasource.getAppointments();

      result.fold(
        (error) {
          setState(() {
            _errorMessage = error;
            _isLoading = false;
          });
        },
        (appointments) {
          // Filter hanya appointment yang akan datang (berdasarkan schedule.date)
          final now = DateTime.now();
          final upcomingAppointments =
              appointments.where((appointment) {
                final date = appointment.schedule?.date;
                return date != null && date.isAfter(now);
              }).toList();

          // Urutkan berdasarkan tanggal terdekat
          upcomingAppointments.sort((a, b) {
            final aDate = a.schedule?.date ?? DateTime(2100);
            final bDate = b.schedule?.date ?? DateTime(2100);
            return aDate.compareTo(bDate);
          });

          setState(() {
            _appointments = upcomingAppointments;
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
  }

  String _formatAppointmentDate(
    DateTime? date,
    String? startTime,
    String? endTime,
  ) {
    if (date == null) return '';
    final dateStr = DateFormat('dd MMMM').format(date);

    String cleanTime(String? time) {
      if (time == null) return '';
      // Hilangkan ':00' di akhir jika ada (misal 08:00:00 -> 08:00)
      if (time.endsWith(':00')) {
        return time.substring(0, time.length - 3);
      }
      return time;
    }

    final start = cleanTime(startTime);
    final end = cleanTime(endTime);

    if (start.isNotEmpty && end.isNotEmpty) {
      return '$dateStr, $start - $end WIB';
    } else if (start.isNotEmpty) {
      return '$dateStr, $start WIB';
    }
    return dateStr;
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF00A89E);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 30,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new, size: 18),
        //   onPressed: () => Navigator.pop(context),
        //   color: primaryColor,
        // ),
        title: Text(
          "Jadwal",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: primaryColor,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00A89E)),
                ),
              )
              : _errorMessage != null
              ? Center(
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
              : _appointments.isEmpty
    ? Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Image.asset(
                'assets/images/medhublost.png',
                width: 200,
                height: 200,
              ),
              Text(
                'Belum ada\njadwal konsultasi',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade400,
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _appointments.length,
                itemBuilder: (context, index) {
                  final appointment = _appointments[index];
                  return _buildAppointmentCard(context, appointment);
                },
              ),
    );
  }

  Widget _buildAppointmentCard(
    BuildContext context,
    AppointmentData appointment,
  ) {
    final schedule = appointment.schedule;
    final doctor = appointment.doctor;
    final user = doctor?.user;

    // Generate ID format KD<day><month><year>
    final appointmentDate = schedule?.date;
    final appointmentId =
        appointmentDate != null
            ? 'KD${appointmentDate.day.toString().padLeft(2, '0')}${appointmentDate.month.toString().padLeft(2, '0')}${appointmentDate.year}'
            : 'KD';

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Jadwal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentUserName ?? '-',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Flexible(
                child: Text(
                  _formatAppointmentDate(
                    schedule?.date,
                    schedule?.startTime,
                    schedule?.endTime,
                  ),
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text("#$appointmentId", style: const TextStyle(color: Colors.grey)),
          const Divider(height: 24),

          // Info Dokter
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child:
                    user?.image != null
                        ? Image.network(
                          user!.image!,
                          width: 80,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (_, __, ___) => Image.asset(
                                'assets/images/dokter2rb.png',
                                width: 80,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                        )
                        : Image.asset(
                          'assets/images/dokter2rb.png',
                          width: 80,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor?.user?.name ?? '-',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          doctor?.specialization ?? 'Dokter Umum',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.circle,
                          size: 10,
                          color:
                              (doctor?.isOnline == 1)
                                  ? Colors.green
                                  : Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          (doctor?.isOnline == 1) ? 'Online' : 'Offline',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (schedule?.day != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  schedule!.day!,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(width: 8),
                        if (doctor?.averageRating != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.thumb_up,
                                  size: 14,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${doctor!.averageRating}%",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Tombol Konsultasi Sekarang
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showLoadingDialog(context);

                Future.delayed(const Duration(seconds: 2), () {
                  if (Navigator.canPop(context)) Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => ConsultationChatPage(
                            doctorId: appointment.doctorId ?? 0,
                            doctorName: user?.name ?? 'Dokter',
                            doctorSpecialty:
                                doctor?.specialization ?? 'Dokter Umum',
                            doctorImage: user?.image,
                          ),
                    ),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A89E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                "Konsultasi sekarang",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Container(
              width: 300,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: const Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 13,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF00C8AE),
                    ),
                    backgroundColor: Color(0xFFB2F1EC),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
