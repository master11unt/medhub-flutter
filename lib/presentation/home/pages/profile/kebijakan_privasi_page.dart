import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KebijakanPrivasiPage  extends StatelessWidget {
  const KebijakanPrivasiPage ({super.key});

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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(
          'Kebijakan Privasi',
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
            _policyItem("1. Jenis data yang kami kumpulkan", [
              "Nama lengkap, tanggal lahir, jenis kelamin",
              "Nomor telepon & alamat email",
              "Data kesehatan (riwayat medis, gejala, resep)",
            ]),
            _policyItem("2. Penggunaan data pribadi Anda", [
              "Keperluan konsultasi medis dan catatan riwayat",
              "Pengingat jadwal pengobatan",
              "Peningkatan layanan aplikasi",
              "Notifikasi penting & promosi (opsional)",
            ]),
            _policyItem("3. Pengungkapan data pribadi Anda", [
              "Kami menggunakan enkripsi dan sistem keamanan berlapis untuk memastikan data pengguna tidak diakses oleh pihak tidak berwenang.",
            ], isBullet: false),
            _policyItem("4. Hak pengguna", [
              "Melihat, mengubah, atau menghapus data pribadi",
              "Menolak penggunaan data untuk tujuan promosi",
              "Menonaktifkan akun kapan pun",
            ]),
            _policyItem("5. Pembaruan Kebijakan", [
              "Perubahan kebijakan akan diinformasikan melalui notifikasi aplikasi. Pengguna disarankan membaca ulang secara berkala.",
            ], isBullet: false),
          ],
        ),
      ),
    );
  }

  Widget _policyItem(
    String title,
    List<String> points, {
    bool isBullet = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 6),
          ...points.map(
            (text) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isBullet)
                    const Padding(
                      padding: EdgeInsets.only(top: 2, right: 6),
                      child: Text("•", style: TextStyle(fontSize: 14)),
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
            ),
          ),
        ],
      ),
    );
  }
}
