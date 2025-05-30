import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/presentation/home/pages/edukasi/detail_artikel_page.dart';
import 'package:medhub/presentation/home/pages/edukasi/video_page.dart';

class ArtikelPage extends StatefulWidget {
 final String selectedKategori;

const ArtikelPage({super.key, required this.selectedKategori});

  @override
  State<ArtikelPage> createState() => _ArtikelPageState();
}

class _ArtikelPageState extends State<ArtikelPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging && _tabController.index == 1) {
        Future.microtask(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VideoPage()),
          ).then((_) {
            _tabController.index = 0; // Kembali ke tab Artikel
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: artikelList.length,
                itemBuilder: (context, index) {
                  final item = artikelList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailArtikelPage(
                            image: item['image']!,
                            tag: item['tag']!,
                            title: item['title']!,
                            desc: item['desc']!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              item['image']!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEAF3FF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        item['icon']!,
                                        width: 14,
                                        height: 14,
                                        color: const Color(0xFF0C4CA6),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item['tag']!,
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF0C4CA6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item['title']!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['desc']!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final artikelList = [
    {
      'image': 'assets/images/artikel1.png',
      'tag': 'Keselamatan berkendara',
      'icon': 'assets/icons/keselamatan.svg',
      'title': 'Tips Mencegah Dehidrasi Saat Mengemudi',
      'desc': 'Mengemudi dalam waktu lama dapat menyebabkan dehidrasi, yang berisiko menurunkan konsentrasi',
    },
    {
      'image': 'assets/images/artikel2.png',
      'tag': 'Ergonomi',
      'icon': 'assets/icons/argonomi.svg',
      'title': 'Mengatur Posisi Duduk yang Benar untuk Mengemudi',
      'desc': 'Posisi duduk yang salah dapat menyebabkan nyeri punggung dan leher kaku. Pastikan kursi tidak terlalu dekat atau terlalu jauh.',
    },
    {
      'image': 'assets/images/artikel3.png',
      'tag': 'Tips sehat',
      'icon': 'assets/icons/sehat.svg',
      'title': 'Waspadai Gejala Hipoglikemia Saat Mengemudi',
      'desc': 'Mengemudi dalam waktu lama dapat menyebabkan dehidrasi, yang berisiko menurunkan konsentrasi',
    },
    {
      'image': 'assets/images/artikel4.png',
      'tag': 'Mengemudi nyaman',
      'icon': 'assets/icons/mengemudi.svg',
      'title': 'Senam Ringan di Mobil untuk Mengurangi Ketegangan',
      'desc': 'Melakukan gerakan peregangan ringan saat berhenti dapat membantu mengurangi pegal selama perjalanan.',
    },
    {
      'image': 'assets/images/artikel5.png',
      'tag': 'Tips sehat',
      'icon': 'assets/icons/sehat.svg',
      'title': 'Mengatasi Sakit Kepala Mendadak Saat Berkendara',
      'desc': 'Sakit kepala saat berkendara bisa disebabkan oleh berbagai faktor seperti ketegangan otot atau stres...',
    },
  ];
}
