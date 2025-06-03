import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/presentation/home/pages/riwayat_jadwal_dan_konsultasi/riwayat_card_page.dart';

class RiwayatKonsultasiPage extends StatelessWidget {
  const RiwayatKonsultasiPage({super.key});

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
          "Riwayat Konsultasi",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: primaryColor, // ✅ warna primary
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: const [
          RiwayatPage(),
          RiwayatPage(),
        ],
      ),
    );
  }
}
