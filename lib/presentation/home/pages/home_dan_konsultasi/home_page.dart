import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medhub/data/datasource/doctor_remote_datasource.dart';
import 'package:medhub/models/doctor.dart';
import 'package:medhub/data/model/response/doctor_response_model.dart' as response_model;
import 'package:medhub/presentation/home/bloc/doctor/doctor_bloc.dart';
import 'package:medhub/presentation/home/pages/agenda_kesehatan/layanan_kesehatan_page.dart';
import 'package:medhub/presentation/home/pages/edukasi/education_page.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/notification_page.dart';
import 'package:medhub/presentation/home/pages/obat/obat_page.dart';
import 'package:medhub/presentation/home/widgets/janji_dokter_card_page.dart';
import 'package:medhub/presentation/home/pages/tombol_darurat/perizinan_call_page.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/cari_dokter_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/model/response/auth_response_model.dart';

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

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  User? _user;
  late Timer _sliderTimer;

  // List<Doctor> doctors = [
  //   Doctor(name: 'Dr Raihan Ramzi', imagePath: 'assets/images/dokter1rb.png'),
  //   Doctor(name: 'Dr Nisa Kamila', imagePath: 'assets/images/dokter2rb.png'),
  //   Doctor(name: 'Dr Budi Santoso', imagePath: 'assets/images/dokter3rb.png'),
  // ];

  @override
  void initState() {
    super.initState();
    _loadUser();
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
    final authData = await AuthLocalDatasource().getAuthData();
    setState(() {
      _user = authData.user;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _sliderTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingHeader(
              userName: _user?.name ?? '-',
              userImageUrl: _user?.image,
              // profileImageWidget: Container(
              //   width: 60,
              //   height: 60,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(30),
              //     image: const DecorationImage(
              //       image: AssetImage('assets/images/profile/profilegr.png'),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              onNotificationPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationPage()),
                );
              },
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: 130,
                    child: PageView(
                      controller: _pageController,
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
                            dotColor: const Color(0xFF3A506B).withOpacity(0.5),
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
                          MaterialPageRoute(builder: (_) => const ObatPage()),
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
            if (widget.hasJanji && widget.janjiDokter != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: JanjiDokterCard(
                  title: 'Konsultasi Online',
                  doctorName: widget.janjiDokter!.name,
                  time: '10 April, 08.00 - 08.30 WIB',
                  imagePath: widget.janjiDokter!.imagePath,
                ),
              ),
            const SizedBox(height: 0),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    child: const Text(
                      'Lihat semua',
                      style: TextStyle(color: Color(0xFF00A99D)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 240,
              child: BlocProvider(
                create:
                    (_) =>
                        DoctorBloc(DoctorRemoteDatasource())
                          ..add(const DoctorEvent.fetchTopDoctors()),
                child: BlocBuilder<DoctorBloc, DoctorState>(
                  builder: (context, state) {
                    if (state is DoctorInitial || state is DoctorLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DoctorLoaded) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        itemCount: state.doctors.length,
                        itemBuilder: (context, index) {
                          return DoctorCard(doctor: state.doctors[index]);
                        },
                      );
                    } else if (state is DoctorError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
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
