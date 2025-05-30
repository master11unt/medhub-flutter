import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  final Color primaryColor = const Color(0xFF00A89E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          color: primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0, // ✅ Geser judul lebih dekat ke back icon
        title: Text(
          'Pusat Bantuan',
          style: GoogleFonts.poppins(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: ListView(
          children: [
            _sectionTitle("1. Hubungi admin"),
            const SizedBox(height: 4),
            _paragraphText("Ada pertanyaan atau masalah?"),
            _paragraphText("Hubungi admin melalui:"),
            _paragraphText("0800-1234-5678"),
            _paragraphText("support@appmed.id"),
            _paragraphText("Jam Operasional: Senin–Jumat, 08.00–17.00 WIB"),

            const SizedBox(height: 20),
            _sectionTitle("2. FAQ (Pertanyaan Umum)"),
            const SizedBox(height: 8),
            _faqItem(
              "Bagaimana cara konsultasi dengan dokter?",
              "Klik tombol 'Konsultasi', pilih dokter, dan mulai chat.",
            ),
            _faqItem(
              "Bagaimana mengubah data pribadi?",
              "Masuk ke halaman 'Profil' dan klik ikon edit.",
            ),
            _faqItem(
              "Apakah data saya aman?",
              "Ya, kami menggunakan sistem keamanan standar industri (enkripsi end-to-end).",
            ),
            _faqItem(
              "Apakah bisa konsultasi gratis?",
              "Ada beberapa layanan gratis, namun beberapa dokter premium memiliki tarif konsultasi tertentu.",
            ),
            _faqItem(
              "Bagaimana cara menghapus akun?",
              "Silakan kirim permintaan ke admin atau pilih 'Keluar Akun' lalu 'Hapus Permanen'.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF1A1A1A),
      ),
    );
  }

  Widget _paragraphText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _faqItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Q: $question",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "A: $answer",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}
