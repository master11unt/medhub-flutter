import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/data/model/response/doctor_response_model.dart';
import 'package:medhub/presentation/home/pages/riwayat_jadwal_dan_konsultasi/jadwal_page.dart';
import 'main_page.dart';

class AppointmentPage extends StatefulWidget {
  final Doctor doctor;

  const AppointmentPage({super.key, required this.doctor});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  int? selectedIndex = 0;

  // Ambil jadwal dari doctor.schedules
  List<Map<String, String>> get appointments {
    final schedules = widget.doctor.schedules ?? [];
    return schedules.map((s) {
      return {
        'date': '', // Isi jika ada tanggal spesifik
        'day': s.day ?? '-',
        'time': "${s.startTime ?? '-'} - ${s.endTime ?? '-'}",
      };
    }).toList();
  }

  void showLoadingThenSuccessDialog() async {
    // Tampilkan loading
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
              child: Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 13,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00C8AE)),
                    backgroundColor: const Color(0xFFB2F1EC),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    // Delay sebentar, lalu ganti ke dialog sukses
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context); // Tutup loading

    // Munculkan success dialog
    showSuccessDialog();
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00A99D),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Janji medis berhasil dibuat!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF00A99D),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Jangan lupa cek detail jadwalnya di\nmenu Riwayat Konsultasi. Sampai jumpa\ndi waktu yang sudah ditentukan',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                const SizedBox(height: 24),
                // Tombol Lihat Janji Medis
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Tutup dialog sukses
                      // Ganti push ke JadwalPage dengan pushReplacement supaya tidak menumpuk halaman
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const JadwalPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A99D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Lihat Janji Medis',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Tombol Selesai
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MainPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF00A99D),
                      side: const BorderSide(color: Color(0xFF00A99D)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Selesai',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: const Color(0xFF00A89E),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Buat Janji Medis',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Color(0xFF00A89E),
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: appointments.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFB2F1EC),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(24),
                      child: const Icon(
                        Icons.event_busy,
                        color: Color(0xFF00A99D),
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Jadwal Kosong',
                      style: TextStyle(
                        color: Color(0xFF00A99D),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Dokter belum memiliki jadwal konsultasi.\nSilakan cek kembali nanti.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: selectedIndex == index
                              ? const Color(0xFF00A99D)
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Show date if available, otherwise show day
                                Text(
                                  appointment['date']!.isNotEmpty 
                                      ? appointment['date']! 
                                      : appointment['day']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Show day if date is available
                                if (appointment['date']!.isNotEmpty)
                                  Text(
                                    appointment['day']!,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                Text(
                                  appointment['time']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Radio<int>(
                            activeColor: const Color(0xFF00A99D),
                            value: index,
                            groupValue: selectedIndex,
                            onChanged: (value) {
                              setState(() {
                                selectedIndex = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: appointments.isEmpty
            ? ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A99D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 4,
                  shadowColor: Colors.black.withOpacity(0.2),
                ),
                child: const Text(
                  'Kembali ke Beranda',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              )
            : ElevatedButton(
                onPressed: () {
                  showLoadingThenSuccessDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A99D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 4,
                  shadowColor: Colors.black.withOpacity(0.2),
                ),
                child: const Text(
                  'Selanjutnya',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}