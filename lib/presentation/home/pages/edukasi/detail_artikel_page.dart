import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailArtikelPage extends StatelessWidget {
  final String image;
  final String tag;
  final String title;
  final String desc;

  const DetailArtikelPage({
    super.key,
    required this.image,
    required this.tag,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    final Color white = Colors.white;
    final Color primaryColor = const Color(0xFF00A89E);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          color: primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edukasi Pengendara',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Share.share('Baca artikel ini di MedHub!');
              },
              child: SvgPicture.asset(
                'assets/icons/share.svg',
                width: 28,
                height: 28,
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar dengan overlay info
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/detailartikel.png',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Keselamatan berkendara',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Intan Afika Nuur Azizah',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '12 February 2025 • 12.00 Wib',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Sumber
              Row(
                children: [
                  Image.asset(
                    'assets/images/okezone.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Okezone News',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Judul
              Text(
                'Catat! Ini 5 Tips Cegah Dehidrasi saat Mengemudi pada Perjalanan Mudik',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),

              // Isi artikel
              Text(
                'TIPS cegah dehidrasi saat mengemudi pada perjalanan mudik perlu Anda ketahui agar tetap segar dan bugar sampai kampung halaman. Dehidrasi terjadi saat tubuh kekurangan sejumlah cairan untuk menjalankan fungsinya dengan optimal.',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 12),
              _pointText(
                '1. Cukupi kebutuhan cairan tubuh',
                'Mulailah hari Anda dengan segelas air. Ini adalah cara yang bagus untuk memulai hidrasi harian Anda. Kemudian, lanjutkan minum air putih sepanjang hari, minimal sebanyak 7-8 gelas dalam sehari. Selain itu, bawa pula air minum dalam botol untuk dikonsumsi secara berkala sepanjang perjalanan. Minumlah sebelum rasa haus melanda, karena haus merupakan salah satu tanda awal terjadinya dehidrasi.',
              ),
              const SizedBox(height: 12),
              _pointText(
                '2. Bawa air minum dengan sedikit rasa',
                'Bawalah air minum dengan tambahan sedikit rasa, seperti infused water menggunakan irisan lemon atau jeruk nipis. Selain infused water, Anda juga bisa membawa kelapa muda atau minuman kemasan yang terbuat dari kelapa asli agar Anda tidak kehausan, serta dapat dikonsumsi dengan mudah di sela-sela perjalanan.',
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pointText(String title, String body) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
        children: [
          TextSpan(
            text: '$title\n',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: body),
        ],
      ),
    );
  }
}
