import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  static const Color primaryColor = Color(0xFF00A89E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
          color: primaryColor,
        ),
        title: Text(
          'Syarat & Ketentuan',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: primaryColor,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Syarat & Ketentuan Penggunaan MedHub:',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Dengan mendaftar dan menggunakan aplikasi MedHub, Anda setuju untuk mematuhi ketentuan berikut:',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 16),
                _SectionTitle(title: '1. Akun Pengguna'),
                _BulletPoint(
                  text:
                      'Anda wajib memberikan informasi yang benar dan akurat saat melakukan pendaftaran.',
                ),
                _BulletPoint(
                  text:
                      'MedHub berhak menonaktifkan akun yang terbukti menggunakan data palsu atau melanggar kebijakan.',
                ),
                const SizedBox(height: 16),
                _SectionTitle(title: '2. Privasi & Keamanan Data'),
                _BulletPoint(
                  text:
                      'Data pribadi Anda seperti nama, nomor BPJS/KTP, dan informasi kesehatan akan dijaga kerahasiaannya.',
                ),
                _BulletPoint(
                  text:
                      'Kami tidak membagikan data Anda kepada pihak ketiga tanpa persetujuan Anda.',
                ),
                const SizedBox(height: 16),
                _SectionTitle(
                  title: '3. Layanan Konsultasi & Informasi Kesehatan',
                ),
                _BulletPoint(
                  text:
                      'MedHub menyediakan layanan konsultasi dokter, edukasi kesehatan, dan informasi layanan kesehatan.',
                ),
                _BulletPoint(
                  text:
                      'Layanan ini bukan pengganti diagnosis medis langsung — selalu konsultasikan kondisi serius ke fasilitas terdekat.',
                ),
                const SizedBox(height: 16),
                _SectionTitle(title: '4. Penggunaan yang Diperbolehkan'),
                _BulletPoint(
                  text:
                      'Dilarang menggunakan aplikasi untuk tindakan yang merugikan pengguna lain, tenaga medis, atau pihak pengelola MedHub.',
                ),
                _BulletPoint(
                  text:
                      'Dilarang menyebarluaskan informasi palsu, provokatif, atau berbahaya melalui aplikasi ini.',
                ),
                const SizedBox(height: 16),
                _SectionTitle(title: '5. Perubahan Ketentuan'),
                _BulletPoint(
                  text:
                      'MedHub berhak memperbarui Syarat & Ketentuan sewaktu-waktu. Kami akan menginformasikan melalui aplikasi jika ada perubahan besar.',
                ),
                const SizedBox(height: 24),
                Text(
                  'Dengan mencentang kotak persetujuan, Anda menyatakan telah membaca dan menyetujui seluruh isi Syarat & Ketentuan ini.',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: const Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF1A1A1A),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "•  ",
            style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
