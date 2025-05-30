import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/datasource/auth_remote_datasource.dart';
import 'package:medhub/data/model/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

class MyEditProfilePage extends StatefulWidget {
  const MyEditProfilePage({super.key});

  @override
  State<MyEditProfilePage> createState() => _MyEditProfilePageState();
}

class _MyEditProfilePageState extends State<MyEditProfilePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ktpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _gender;

  final Color primaryColor = const Color(0xFF00A89E);
  final Color labelColor = const Color(0xFF074A58);
  final Color radioTextColor = const Color(0xFF667085);

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final auth = await AuthLocalDatasource().getAuthData();
    final user = auth.user;
    setState(() {
      _nameController.text = user?.name ?? '';
      _emailController.text = user?.email ?? '';
      _phoneController.text = user?.phone ?? '';
      _ktpController.text = user?.noKtp ?? '';
      // Mapping dari L/P ke value radio
      if (user?.jenisKelamin == 'L') {
        _gender = 'Laki-Laki';
      } else if (user?.jenisKelamin == 'P') {
        _gender = 'Perempuan';
      } else {
        _gender = null;
      }
    });
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);

    // Validasi password dan konfirmasi password
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Konfirmasi password tidak sama")),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      final auth = await AuthLocalDatasource().getAuthData();
      final token = auth.token ?? '';
      final jenisKelaminValue = _gender == 'Laki-Laki' ? 'L' : _gender == 'Perempuan' ? 'P' : '';
      final result = await AuthRemoteDatasource().updateUserProfile(
        token: token,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        jenisKelamin: jenisKelaminValue,
        noKtp: _ktpController.text,
        password: _passwordController.text.isNotEmpty ? _passwordController.text : null,
      );
      await AuthLocalDatasource().saveAuthData(result);
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal update profil: $e')));
    }
  }

  Future<void> updateProfile(User user, String token) async {
    final response = await http.put(
      Uri.parse('${Variable.baseUrl}/api/update-profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': user.name,
        'email': user.email,
        'phone': user.phone,
        'jenis_kelamin': user.jenisKelamin,
        'no_ktp': user.noKtp,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final updatedUser = User.fromMap(data['user']);
      // Simpan ke local storage
      await AuthLocalDatasource().saveAuthData(
        AuthResponseModel(user: updatedUser, token: token),
      );
    } else {
      throw Exception(
        jsonDecode(response.body)['message'] ?? 'Gagal update profil',
      );
    }
  }

  Widget buildLabeledField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 46,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
            cursorColor: Colors.grey.shade400,
            decoration: InputDecoration(
              hintText: label,
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
            ),
          ),
        ),
      ],
    );
  }

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
            color: labelColor,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 46,
          child: TextField(
            controller: controller,
            obscureText: isObscured,
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
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Edit Profil',
          style: GoogleFonts.poppins(
            color: primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          color: primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade300,
                      child:
                          (_gender != null && _gender!.isNotEmpty)
                              ? FutureBuilder(
                                future: AuthLocalDatasource().getAuthData(),
                                builder: (context, snapshot) {
                                  final user =
                                      snapshot.hasData
                                          ? snapshot.data?.user
                                          : null;
                                  if (user != null &&
                                      user.image != null &&
                                      user.image!.isNotEmpty) {
                                    return ClipOval(
                                      child: Image.network(
                                        user.image!,
                                        fit: BoxFit.cover,
                                        width: 75,
                                        height: 75,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                                  Icons.person,
                                                  size: 48,
                                                  color: Colors.white,
                                                ),
                                      ),
                                    );
                                  } else {
                                    return const Icon(
                                      Icons.person,
                                      size: 48,
                                      color: Colors.white,
                                    );
                                  }
                                },
                              )
                              : const Icon(
                                Icons.person,
                                size: 48,
                                color: Colors.white,
                              ),
                    ),
                    // ...existing code...
                    const SizedBox(height: 30),
                    buildLabeledField('Nama Lengkap', _nameController),
                    const SizedBox(height: 12),
                    buildLabeledField(
                      'Email',
                      _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    buildLabeledField(
                      'Nomor Kontak / WhatsApp Aktif',
                      _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Jenis Kelamin',
                      style: GoogleFonts.poppins(
                        color: labelColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(
                              'Laki-Laki',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: radioTextColor,
                              ),
                            ),
                            value: 'Laki-Laki',
                            groupValue: _gender,
                            activeColor: primaryColor,
                            onChanged: (val) {
                              setState(() => _gender = val);
                            },
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(
                              'Perempuan',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: radioTextColor,
                              ),
                            ),
                            value: 'Perempuan',
                            groupValue: _gender,
                            activeColor: primaryColor,
                            onChanged: (val) {
                              setState(() => _gender = val);
                            },
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    buildLabeledField(
                      'Nomor Identitas (BPJS/KTP/KK)',
                      _ktpController,
                    ),
                    const SizedBox(height: 20),
                    buildLabeledTextField(
                      'Password Baru',
                      'Password Baru',
                      isPassword: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 12),
                    buildLabeledTextField(
                      'Konfirmasi Password',
                      'Konfirmasi Password',
                      isPassword: true,
                      isConfirm: true,
                      controller: _confirmPasswordController,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Simpan',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
