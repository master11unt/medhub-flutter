import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/presentation/auth/bloc/register/register_bloc.dart';
import 'package:medhub/presentation/auth/pages/login_page.dart';
import 'package:medhub/presentation/auth/pages/medical_info_page.dart';
import 'syarat_ketentuan.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isChecked = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _selectedGender;

  final Color primaryColor = const Color(0xFF00A89E);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _ktpController = TextEditingController();

  Widget buildLabeledTextField(
    String label,
    String hint, {
    bool isPassword = false,
    bool isConfirm = false,
    TextEditingController? controller,
  }) {
    bool isObscured =
        isPassword
            ? (isConfirm ? !_isConfirmPasswordVisible : !_isPasswordVisible)
            : false;

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
          height: 50,
          child: TextField(
            controller: controller,
            obscureText: isObscured,
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
            cursorColor: Colors.grey.shade400,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontSize: 16,
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
              suffixIcon:
                  isPassword
                      ? IconButton(
                        icon: SvgPicture.asset(
                          isConfirm
                              ? (_isConfirmPasswordVisible
                                  ? 'assets/icons/showicon.svg'
                                  : 'assets/icons/hideicon.svg')
                              : (_isPasswordVisible
                                  ? 'assets/icons/showicon.svg'
                                  : 'assets/icons/hideicon.svg'),
                          width:
                              isConfirm
                                  ? (_isConfirmPasswordVisible ? 16 : 20)
                                  : (_isPasswordVisible ? 16 : 20),
                          height:
                              isConfirm
                                  ? (_isConfirmPasswordVisible ? 16 : 20)
                                  : (_isPasswordVisible ? 16 : 20),
                        ),
                        onPressed: () {
                          setState(() {
                            if (isConfirm) {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            } else {
                              _isPasswordVisible = !_isPasswordVisible;
                            }
                          });
                        },
                      )
                      : null,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) async {
          if (state is RegisterStateLoading) {
            showLoadingDialog(context);
          } else if (state is RegisterStateSuccess) {
            await AuthLocalDatasource().saveAuthData(state.authResponseModel);
            
            Navigator.of(context, rootNavigator: true).pop(); // tutup loading
            showSuccessDialog(context);
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context, rootNavigator: true).pop(); // tutup success
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MedicalInfoPage()),
              );
            });
          } else if (state is RegisterStateError) {
            Navigator.of(context, rootNavigator: true).pop(); // tutup loading
            showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    title: const Text('Registrasi Gagal'),
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),
                  const Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00A89E),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      "Daftar Akun Baru",
                      style: TextStyle(fontSize: 16, color: Color(0xFF00A89E)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),

                  buildLabeledTextField(
                    'Nama Lengkap',
                    'Nama Lengkap',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 13),
                  buildLabeledTextField(
                    'Email Aktif',
                    'Email Aktif',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 13),
                  buildLabeledTextField(
                    'No. HP',
                    'No. HP',
                    controller: _phoneController,
                  ),
                  const SizedBox(height: 13),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jenis Kelamin',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          value: _selectedGender,
                          items: const [
                            DropdownMenuItem(
                              value: 'L',
                              child: Text('Laki-laki'),
                            ),
                            DropdownMenuItem(
                              value: 'P',
                              child: Text('Perempuan'),
                            ),
                          ],
                          onChanged: (val) {
                            setState(() {
                              _selectedGender = val;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Pilih Jenis Kelamin',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 16,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  buildLabeledTextField(
                    'Kata Sandi',
                    'Kata Sandi',
                    isPassword: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 13),
                  buildLabeledTextField(
                    'Konfirmasi Kata Sandi',
                    'Konfirmasi Kata Sandi',
                    isPassword: true,
                    isConfirm: true,
                    controller: _confirmPasswordController,
                  ),
                  const SizedBox(height: 13),
                  buildLabeledTextField(
                    'No. KTP / KK / BPJS',
                    'No. KTP / KK / BPJS',
                    controller: _ktpController,
                  ),
                  const SizedBox(height: 10),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: Radio<bool>(
                          value: true,
                          groupValue: isChecked,
                          toggleable: true,
                          activeColor: primaryColor,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text(
                              "Saya menyetujui ",
                              style: TextStyle(fontSize: 12),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            const TermsConditionsPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Syarat & Ketentuan MedHub",
                                style: TextStyle(
                                  color: Color(0xFF00A89E),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (!isChecked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Anda harus menyetujui Syarat & Ketentuan",
                              ),
                            ),
                          );
                          return;
                        }

                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Konfirmasi password tidak sama"),
                            ),
                          );
                          return;
                        }

                        // Trigger register event ke Bloc
                        context.read<RegisterBloc>().add(
                          RegisterEvent.register(
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            password: _passwordController.text,
                            jenisKelamin: _selectedGender ?? '',
                            noKtp: _ktpController.text,
                          ),
                        );
                      },
                      child: const Text(
                        "Daftar",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: 'Sudah punya akun? ',
                          children: [
                            TextSpan(
                              text: 'Log in',
                              style: TextStyle(color: Color(0xFF00A89E)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Container(
              width: 300,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 13,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF00C8AE),
                    ),
                    backgroundColor: Color(0xFFB2F1EC),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Color(0xFF00C8AE), size: 80),
                const SizedBox(height: 24),
                const Text(
                  'Sign Up Berhasil!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Anda akan diarahkan ke form informasi medis.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
