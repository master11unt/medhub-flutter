import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/datasource/health_record_remote_datasource.dart';
import 'package:medhub/data/model/response/auth_response_model.dart';
import 'package:medhub/data/model/response/health_record_response_model.dart';
import 'package:medhub/presentation/auth/bloc/logout/logout_bloc.dart';

class ProfilePage extends StatefulWidget {
  static const Color primaryColor = Color(0xFF00A89E);

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  Data? _healthRecord;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final token = await AuthLocalDatasource().getToken();
      Data? healthRecord;
      try {
        final healthRecordResponse = await HealthRecordRemoteDatasource()
            .getHealthRecord(token);
        healthRecord = healthRecordResponse.data;
      } catch (e) {
        healthRecord = null;
      }
      setState(() {
        _user = authData.user;
        _healthRecord = healthRecord;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal memuat data profil: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: ProfilePage.primaryColor,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Text(
          "Profil",
          style: GoogleFonts.poppins(
            color: ProfilePage.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar, nama, email
                    Row(
                      children: [
                        (_user?.image != null && _user!.image!.isNotEmpty)
                            ? Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: NetworkImage(_user!.image!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                            : Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 36,
                                color: Colors.white,
                              ),
                            ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _user?.name ?? "-",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              _user?.email ?? "-",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Edit Informasi Medis
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async {
                          // Parse birth date dengan benar
                          DateTime? birthDate;
                          if (_healthRecord?.birthDate != null) {
                            birthDate = _healthRecord!.birthDate;
                          }
                          
                          final result = await Navigator.pushNamed(
                            context,
                            '/editMedicalInfo',
                            arguments: {
                              'isEdit': true,
                              'recordId': _healthRecord?.id,
                              'initialData': {
                                'height': _healthRecord?.height,
                                'weight': _healthRecord?.weight,
                                'bloodType': _healthRecord?.bloodType,
                                'birthDate': birthDate?.toIso8601String().split('T').first, // Format YYYY-MM-DD
                                'age': _healthRecord?.age,
                                'allergies': _healthRecord?.allergies,
                                'currentMedications':
                                    _healthRecord?.currentMedications,
                                'currentConditions':
                                    _healthRecord?.currentConditions,
                                'medicalDocument':
                                    _healthRecord?.medicalDocument,
                              },
                            },
                          );
                          if (result == true) {
                            _loadProfile(); // reload data setelah edit
                          }
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              child: SvgPicture.asset(
                                'assets/icons/iconEdit.svg',
                                width: 20,
                                height: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Edit Informasi Medis",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Box tinggi, berat, gol darah
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _infoText(
                            "Tinggi",
                            _healthRecord?.height != null
                                ? "${_healthRecord!.height} cm"
                                : "-",
                          ),
                          _verticalDivider(),
                          _infoText(
                            "Berat",
                            _healthRecord?.weight != null
                                ? "${_healthRecord!.weight} kg"
                                : "-",
                          ),
                          _verticalDivider(),
                          _infoText(
                            "Gol Darah",
                            _healthRecord?.bloodType ?? "-",
                          ),
                        ],
                      ),
                    ),

                    // Box informasi profil
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Informasi profil",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _profileRow("Nama Lengkap", _user?.name ?? "-"),
                          _profileRow("Email Aktif", _user?.email ?? "-"),
                          _profileRow("Nomor Hp", _user?.phone ?? "-"),
                          _profileRow(
                            "Jenis Kelamin",
                            _user?.jenisKelamin == "L"
                                ? "Laki-laki"
                                : _user?.jenisKelamin == "P"
                                ? "Perempuan"
                                : "-",
                          ),
                          _profileRow(
                            "No. KTP / KK / BPJS",
                            _user?.noKtp ?? "-",
                          ),
                        ],
                      ),
                    ),

                    // Menu bawah profil
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _menuTile(
                            context,
                            icon: 'assets/icons/iconEdit.svg',
                            title: 'Edit Profil',
                            route: '/editProfile',
                          ),
                          _menuTile(
                            context,
                            icon: 'assets/icons/icon_pusatBantuan.svg',
                            title: 'Pusat Bantuan',
                            route: '/helpCenter',
                          ),
                          _menuTile(
                            context,
                            icon: 'assets/icons/iconPrivasi.svg',
                            title: 'Kebijakan Privasi',
                            route: '/privacyPolicy',
                          ),
                        ],
                      ),
                    ),

                    // Tombol logout
                    SafeArea(
                      child: Center(
                        child: BlocListener<LogoutBloc, LogoutState>(
                          listener: (context, state) {
                            if (state is LogoutStateSuccess) {
                              AuthLocalDatasource().removeAuthData();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/login',
                                (route) => false,
                              );
                            } else if (state is LogoutStateError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Logout gagal: ${state.message}',
                                  ),
                                ),
                              );
                            }
                          },
                          child: OutlinedButton(
                            onPressed: () {
                              context.read<LogoutBloc>().add(
                                const LogoutEvent.logout(),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFF44336)),
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Keluar Akun",
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFF44336),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
    );
  }

  Widget _infoText(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 32,
      width: 1,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _profileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required String icon,
    required String title,
    required String route,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        width: 20,
        height: 20,
        color: Colors.black87,
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
      onTap: () async {
        // Cek jika route edit profile, refresh setelah kembali
        if (route == '/editProfile') {
          final result = await Navigator.pushNamed(context, route);
          if (result == true) {
            _loadProfile(); // reload user & data medis dari local storage
          }
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
