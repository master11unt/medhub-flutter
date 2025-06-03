import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/konsultasi_page.dart';

class JanjiDokterCard extends StatelessWidget {
  final String title;
  final String doctorName;
  final String time;
  final String imagePath;
  final int? doctorId;
  final String? doctorSpecialty;
  final bool isOnline;

  const JanjiDokterCard({
    super.key,
    required this.title,
    required this.doctorName,
    required this.time,
    required this.imagePath,
    this.doctorId,
    this.doctorSpecialty = 'Dokter Umum',
    this.isOnline = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman konsultasi dengan data dokter
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ConsultationChatPage(
              doctorId: doctorId ?? 0,
              doctorName: doctorName,
              doctorSpecialty: doctorSpecialty ?? 'Dokter Umum',
              doctorImage: imagePath,
            ),
          ),
        );
      },
      child: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black.withOpacity(0.10)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(40, 41, 61, 0.04),
                blurRadius: 1,
                offset: Offset(0, 0),
              ),
              BoxShadow(
                color: Color.fromRGBO(96, 97, 112, 0.16),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Garis Vertikal Kiri
              Container(
                width: 4,
                height: 91,
                decoration: BoxDecoration(
                  color: const Color(0xFFF25F24),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 12),
              // Konten
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isOnline ? const Color(0xFFE5F8F6) : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            isOnline ? 'Online' : 'Offline',
                            style: TextStyle(
                              fontSize: 10,
                              color: isOnline ? const Color(0xFF00A89E) : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _buildDoctorImage(),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctorName,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                doctorSpecialty ?? 'Dokter Umum',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
        ),
      ),
    );
  }

  // Widget untuk menampilkan gambar dokter (mendukung URL dan asset lokal)
  Widget _buildDoctorImage() {
    // Cek apakah path adalah URL atau asset lokal
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/dokter1.png',
            width: 36,
            height: 36,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        imagePath,
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 36,
            height: 36,
            color: Colors.grey.shade300,
            child: const Icon(Icons.person, size: 24, color: Colors.grey),
          );
        },
      );
    }
  }
}