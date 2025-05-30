import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:medhub/presentation/auth/pages/onboard_akses.dart';
import 'package:medhub/presentation/auth/pages/signup_page.dart';
import 'package:medhub/presentation/home/widgets/onboard_template.dart';

class OnboardLayanan extends StatelessWidget {
  const OnboardLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardTemplate(
      imagePath: 'assets/images/onboarding2.svg',
      title: 'Layanan Kesehatan\nAda di Genggaman!',
      description:
          'Konsultasi dengan dokter, cek jadwal\nvaksinasi, donor darah, dan layanan\nkesehatan lainnya… cukup dari HP Anda!',
      onSkip: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpPage()),
        );
      },
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OnboardAkses()),
        );
      },
    );
  }
}
