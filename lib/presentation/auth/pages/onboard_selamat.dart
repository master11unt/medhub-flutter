import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:medhub/presentation/auth/pages/onboard_layanan.dart';
import 'package:medhub/presentation/auth/pages/signup_page.dart';
import 'package:medhub/presentation/home/widgets/onboard_template.dart';

class OnboardSelamat extends StatelessWidget {
  const OnboardSelamat({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardTemplate(
      imagePath: 'assets/images/onboarding1.svg',
      title: 'Selamat Datang di\nMedHub!',
      description:
          'Aplikasi kesehatan terintegrasi untuk\nmembantu Anda mengakses layanan\nmedis lebih mudah dan cepat.', 
      onSkip: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpPage()),
        );
      },
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OnboardLayanan()),
        );
      },
    );
  }
}
