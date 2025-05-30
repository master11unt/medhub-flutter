import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/presentation/home/pages/tombol_darurat/pemlihan_call_page.dart';

class AmbulanceCallScreen extends StatefulWidget {
  const AmbulanceCallScreen({super.key});

  @override
  State<AmbulanceCallScreen> createState() => _AmbulanceCallScreenState();
}

class _AmbulanceCallScreenState extends State<AmbulanceCallScreen> {
  int seconds = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Mulai timer saat panggilan dianggap tersambung
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get formattedTime {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xFF00A89E)),
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) => const EmergencyPopup(),
            );
          },
        ),
        title: Text(
          'Ambulan',
          style: GoogleFonts.poppins(
            color: const Color(0xFF00A89E),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Icon dan waktu panggilan
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.call_outlined, size: 20),
                const SizedBox(width: 8),
                Text(
                  formattedTime,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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

            // Tombol volume dan tutup panggilan
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

  Widget _buildCircleButton(String assetPath, {Color color = const Color(0xFF2E2E33)}) {
    return Container(
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
    );
  }
}
