import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/main_page.dart';
import 'package:medhub/presentation/home/pages/tombol_darurat/pemlihan_call_page.dart';

class AmbulanceCallScreen extends StatelessWidget {
  const AmbulanceCallScreen({super.key});

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
          color: const Color(0xFF00A89E),
          onPressed: () {
            Navigator.of(context).pop(); // Kembali
            showDialog(
              context: context,
              builder: (context) => const EmergencyPopup(),
            );
          },
        ),
        title: Text(
          'Ambulan',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF00A89E),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              'Panggilan darurat - Memanggil....',
              style: GoogleFonts.poppins(
                color: const Color(0xFFF44336),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '112',
              style: GoogleFonts.poppins(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Indonesia',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Center(
              child: Container(
                width: 250,
                height: 100,
                margin: const EdgeInsets.only(bottom: 32),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 168, 158, 0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCircleButton('assets/images/volume.png'),
                    const SizedBox(width: 48),
                    _buildCircleButton(
                      'assets/images/phone.png',
                      color: const Color(0xFFF44336),
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const MainPage()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton(
    String assetPath, {
    Color color = const Color(0xFF2E2E33),
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            width: 36,
            height: 36,
          ),
        ),
      ),
    );
  }
}
