import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medhub/presentation/auth/pages/onboard_selamat.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _checkSession();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _opacity = 1.0);
    });
  }

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    final token = await AuthLocalDatasource().getToken();

    if (token.isNotEmpty) {
      // Sudah login/daftar, langsung ke home
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/main');
    } else {
      // Belum login/daftar, tampilkan onboarding
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardSelamat()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 2),
          opacity: _opacity,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.8, end: 1.0),
            duration: const Duration(seconds: 2),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Transform.scale(scale: value, child: child);
            },
            child: SvgPicture.asset(
              'assets/images/splashScreen.svg',
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}