import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/data/datasource/doctor_remote_datasource.dart';
import 'package:medhub/data/datasource/obat_remote_datasource.dart';
import 'package:medhub/data/model/response/doctor_response_model.dart';
import 'package:medhub/presentation/home/bloc/doctor/doctor_bloc.dart';
import 'package:medhub/presentation/home/bloc/doctor/doctor_event.dart';
import 'package:medhub/presentation/home/bloc/doctor/doctor_state.dart';
import 'package:medhub/presentation/home/bloc/obat/obat_bloc.dart';
import 'package:medhub/presentation/home/pages/agenda_kesehatan/layanan_kesehatan_page.dart';
import 'package:medhub/presentation/home/pages/edukasi/education_page.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/notification_page.dart';
import 'package:medhub/presentation/home/pages/obat/obat_page.dart';
import 'package:medhub/presentation/home/widgets/janji_dokter_card_page.dart';
import 'package:medhub/presentation/home/pages/tombol_darurat/perizinan_call_page.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/cari_dokter_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/model/response/auth_response_model.dart'
    as auth_model;

import '../../widgets/greeting_header.dart';
import '../../widgets/feature_button.dart';
import '../../widgets/doctor_card.dart';

class HomePage extends StatefulWidget {
  final bool hasJanji;
  final Doctor? janjiDokter;

  const HomePage({super.key, this.hasJanji = false, this.janjiDokter});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  auth_model.User? _user;
  late Timer _sliderTimer;
  bool _isLoading = true;
  String _errorMessage = '';
  List<Doctor> _doctors = []; // Menggunakan Doctor dari API tanpa alias

  @override
  bool get wantKeepAlive => true; // Keep state when switching tabs

  @override
  void initState() {
    super.initState();
    _loadUser();
    _fetchDoctors();
    _setupSliderTimer();
  }

  void _setupSliderTimer() {
    _sliderTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % 3;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _loadUser() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      if (mounted) {
        setState(() {
          // Cast User ke auth_model.User karena keduanya struktur datanya sama
          _user = authData.user;
        });
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }

  Future<void> _fetchDoctors() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final doctorRemoteDatasource = DoctorRemoteDatasource();
      final result = await doctorRemoteDatasource.getDoctors();

      result.fold(
        (error) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _errorMessage = error;
            });
          }
        },
        (doctors) {
          if (mounted) {
            // Sort by rating to get top doctors
            final sortedDoctors = List<Doctor>.from(doctors)..sort((a, b) {
              // Handle both string and numeric format for averageRating
              final aRating =
                  a.averageRating is String
                      ? double.tryParse(a.averageRating ?? '0.0') ?? 0.0
                      : (a.averageRating ?? 0.0).toDouble();

              final bRating =
                  b.averageRating is String
                      ? double.tryParse(b.averageRating ?? '0.0') ?? 0.0
                      : (b.averageRating ?? 0.0).toDouble();

              return bRating.compareTo(aRating);
            });

            setState(() {
              _isLoading = false;
              _doctors = sortedDoctors.take(5).toList(); // Get top 5 doctors
            });
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _sliderTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          await _loadUser();
          await _fetchDoctors();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingHeader(
                userName: _user?.name ?? '-',
                userImageUrl: _user?.image,
                onNotificationPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NotificationPage()),
                  );
                },
              ),
              const SizedBox(height: 32),
              // Image Slider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 130,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: [
                          _buildSliderImage('assets/images/slide1.png'),
                          _buildSliderImage('assets/images/slide2.png'),
                          _buildSliderImage('assets/images/slide3.png'),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: 3,
                            effect: ExpandingDotsEffect(
                              activeDotColor: const Color(0xFF3A506B),
                              dotColor: const Color(
                                0xFF3A506B,
                              ).withOpacity(0.5),
                              dotHeight: 6,
                              dotWidth: 6,
                              expansionFactor: 2,
                              spacing: 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Feature Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CariDokterPage(),
                            ),
                          );
                        },
                        child: const FeatureButton(
                          label: 'Konsultasi\nOnline',
                          iconPath: 'assets/images/fitur1.svg',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BlocProvider(
                                    create:
                                        (context) =>
                                            ObatBloc(ObatRemoteDatasource()),
                                    child: const ObatPage(),
                                  ),
                            ),
                          );
                        },
                        child: const FeatureButton(
                          label: 'Beli Obat',
                          iconPath: 'assets/images/fitur2.svg',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EducationPage(),
                            ),
                          );
                        },
                        child: const FeatureButton(
                          label: 'Edukasi\nPengendara',
                          iconPath: 'assets/images/fitur3.svg',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LayananKesehatanPage(),
                            ),
                          );
                        },
                        child: const FeatureButton(
                          label: 'Agenda\nKesehatan',
                          iconPath: 'assets/images/fitur4.svg',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Appointment Card (if any)
              if (widget.hasJanji && widget.janjiDokter != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: JanjiDokterCard(
                    title: 'Konsultasi Online',
                    doctorName:
                        widget.janjiDokter!.user?.name ??
                        'Dokter', // Diubah untuk menggunakan data dari API
                    time: '10 April, 08.00 - 08.30 WIB',
                    imagePath:
                        widget.janjiDokter!.user?.image ??
                        'assets/images/dokter1.png', // Diubah untuk menggunakan data dari API
                  ),
                ),
              // Doctors Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Dokter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CariDokterPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Lihat semua',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF00A99D),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Doctors List
              SizedBox(
                height: 240,
                child:
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _errorMessage.isNotEmpty
                        ? Center(child: Text(_errorMessage))
                        : _doctors.isEmpty
                        ? const Center(child: Text('Tidak ada dokter tersedia'))
                        : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: _doctors.length,
                          itemBuilder: (context, index) {
                            return DoctorCard(doctor: _doctors[index]);
                          },
                        ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffD81305),
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.black54,
            builder: (context) => const PermissionPopup(),
          );
        },
        child: const Icon(Icons.phone_rounded, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildSliderImage(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(path, fit: BoxFit.cover, width: double.infinity),
    );
  }
}
