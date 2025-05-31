import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/main_page.dart';
import 'package:medhub/presentation/auth/pages/signup_page.dart';
import 'package:medhub/presentation/auth/bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Color primaryColor = const Color(0xFF00A89E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is LoginStateLoading) {
            showLoadingDialog(context);
          } else if (state is LoginStateSuccess) {
            // Simpan data ke lokal
            await AuthLocalDatasource().saveAuthData(state.authResponseModel);
            Navigator.of(context, rootNavigator: true).pop(); // tutup loading
            showLoginSuccessDialog(context);
          } else if (state is LoginStateError) {
            Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Login Gagal'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Center(
                child: Text(
                  'Log in',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              buildLabeledTextField(
                label: 'Email / No HP',
                hint: 'Email / No HP',
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Kata Sandi',
                hint: 'Kata Sandi',
                controller: _passwordController,
                obscure: !_isPasswordVisible,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() => _isPasswordVisible = !_isPasswordVisible);
                  },
                  icon: SvgPicture.asset(
                    _isPasswordVisible
                        ? 'assets/icons/showicon.svg'
                        : 'assets/icons/hideicon.svg',
                    color: Colors.grey.shade600,
                    width: _isPasswordVisible ? 16 : 20,
                    height: _isPasswordVisible ? 16 : 20,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Tambahkan aksi lupa password
                  },
                  child: Text(
                    'Lupa Kata Sandi?',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Validasi input
                    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Email dan password wajib diisi!')),
                      );
                      return;
                    }
                    // Trigger login event
                    context.read<LoginBloc>().add(
                      LoginEvent.login(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Masuk',
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabeledTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 46,
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
            cursorColor: Colors.grey.shade400,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF757575),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 11,
              ),
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.15),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.15),
                  width: 1,
                ),
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: Container(
            width: 300,
            height: 210,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: const Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 13,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00C8AE)),
                  backgroundColor: Color(0xFFB2F1EC),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showLoginSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF00C8AE),
                child: Icon(
                  Icons.login_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Login Berhasil!',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );

    // Tutup dialog dan langsung navigasi ke MainPage setelah 1 detik
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context, rootNavigator: true).pop(); // tutup dialog sukses
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MainPage()));
    });
  }
}
