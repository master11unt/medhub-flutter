import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medhub/models/doctor.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/home_page.dart';
import 'package:medhub/presentation/home/pages/profile/profile_page.dart';
import 'package:medhub/presentation/home/pages/riwayat_jadwal_dan_konsultasi/daftar_riwayat_page.dart';
import 'package:medhub/presentation/home/pages/riwayat_jadwal_dan_konsultasi/jadwal_page.dart';

class MainPage extends StatefulWidget {
  final bool hasJanji;
  final Doctor? janjiDokter;

  const MainPage({super.key, this.hasJanji = false, this.janjiDokter});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(hasJanji: widget.hasJanji, janjiDokter: widget.janjiDokter),
      const JadwalPage(),
      const RiwayatKonsultasiPage(),
      const ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget svgIcon(String path, {double size = 24}) {
    return SvgPicture.asset(path, width: size, height: size);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: svgIcon('assets/icons/icon_home.svg'),
                activeIcon: svgIcon('assets/icons/homeField.svg'),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: svgIcon('assets/icons/icon_jadwal.svg'),
                activeIcon: svgIcon('assets/icons/jadwalField.svg'),
                label: 'Jadwal',
              ),
              BottomNavigationBarItem(
                icon: svgIcon('assets/icons/icon_riwayat.svg'),
                activeIcon: svgIcon('assets/icons/icon_riwayatField.svg'),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: svgIcon('assets/icons/icon_profil.svg'),
                activeIcon: svgIcon('assets/icons/icon_profilField.svg'),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
