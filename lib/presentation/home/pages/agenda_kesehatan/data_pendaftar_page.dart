import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/models/health_service.dart';
import 'package:medhub/presentation/home/pages/agenda_kesehatan/layanan_kesehatan_page.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/main_page.dart';

class DataPendaftarPage extends StatelessWidget {
  final HealthService service;
  final bool showSimpanButton;

  const DataPendaftarPage({
    super.key,
    required this.service,
    this.showSimpanButton = true,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF00A89E);
    const darkTextColor = Color(0xFF333333);
    const labelColor = Color(0xFF1A1A1A);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 18, color: primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Data Pendaftar',
          style: GoogleFonts.poppins(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Kartu Informasi
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black.withOpacity(0.1)),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(40, 41, 61, 0.04),
                    offset: Offset(0, 0),
                    blurRadius: 1,
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(96, 97, 112, 0.16),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    service.location, // Ganti sesuai data service
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'dr Raihan Ramzi',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pasien', style: GoogleFonts.poppins(fontSize: 12, color: labelColor)),
                        Text('Aulia Rahma Putri',
                            style: GoogleFonts.poppins(fontSize: 14, color: darkTextColor)),
                        const SizedBox(height: 16),
                        Text('Layanan', style: GoogleFonts.poppins(fontSize: 12, color: labelColor)),
                        Text(service.title,
                            style: GoogleFonts.poppins(fontSize: 14, color: darkTextColor)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text('Nomor antrean layanan',
                      style: GoogleFonts.poppins(fontSize: 13, color: Colors.black)),
                  const SizedBox(height: 8),
                  Text('V-04',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      )),
                  const SizedBox(height: 24),
                  Text('Estimasi Pelayanan ${service.dateTime}',
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.black)),
                ],
              ),
            ),
            const Spacer(),

            // Tombol Aksi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (showSimpanButton) ...[
                  SizedBox(
                    width: 165,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LayananKesehatanPage(initialIsLayananSelected: false),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Simpan',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  width: 165,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MainPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: FittedBox(
                      child: Text(
                        'Kembali ke beranda',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
