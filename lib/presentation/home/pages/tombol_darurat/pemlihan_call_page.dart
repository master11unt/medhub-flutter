import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'panggilan_ambulan_page.dart';
import 'panggilan_kecelakaan_page.dart';

class EmergencyPopup extends StatelessWidget {
  const EmergencyPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFFDFDFD),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280, maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              EmergencyButton(text: 'Hubungi Ambulan'),
              SizedBox(height: 16),
              EmergencyButton(text: 'Laporkan Kecelakaan'),
            ],
          ),
        ),
      ),
    );
  }
}

class EmergencyButton extends StatelessWidget {
  final String text;
  const EmergencyButton({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();

        if (text == 'Hubungi Ambulan') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AmbulanceCallScreen()),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AccidentReportScreen()),
          );
        }
      },
      child: Container(
        width: double.infinity,
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFF44336)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/call.svg',
              width: 20,
              height: 20,
              color: const Color(0xFFF44336),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
