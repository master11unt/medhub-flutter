import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  static const Color primaryColor = Color(0xFF00A89E);
  static const Color categoryBoxColor = Color(0xFFEAF3FF);
  static const Color categoryTextColor = Color(0xFF0C4CA6);

  // Fungsi untuk membuka YouTube URL
  void _launchYoutube(String url) async {
    final uri = Uri.parse(url);
    try {
      final result = await launchUrl(
        uri,
        mode: LaunchMode.platformDefault, // Bisa juga coba LaunchMode.externalApplication
      );

      if (!result) {
        print('Gagal membuka URL: $url');
      }
    } catch (e) {
      print('Error membuka URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final videos = [
      {
        "title": "Video Edukasi Keselamatan Berkendara",
        "tag": "Berkendara aman",
        "description":
            "Video ini membahas pentingnya keselamatan dalam berkendara, termasuk faktor-faktor yang mempengaruhi keselamatan di jalan.",
        "thumbnail": "assets/images/edukasi/video1.png",
        "url": "https://www.youtube.com/watch?v=Qek6M-iAN2I",
        "icon": "assets/icons/mengemudi.svg",
      },
      {
        "title": "Edukasi Safety Riding – Keselamatan Dalam Berkendara",
        "tag": "Safety riding",
        "description":
            "Video animasi yang menjelaskan prinsip-prinsip dasar keselamatan berkendara, cocok untuk semua...",
        "thumbnail": "assets/images/edukasi/video2.png",
        "url": "https://www.youtube.com/watch?v=YuBQjf9kVfc",
        "icon": "assets/icons/safety.svg",
      },
      {
        "title": "Safety Riding – Tutorial Mengendarai Motor",
        "tag": "Safety riding",
        "description":
            "Tutorial lengkap tentang cara mengendarai motor dengan aman, mulai dari persiapan hingga teknik berkendara",
        "thumbnail": "assets/images/edukasi/video3.png",
        "url": "https://www.youtube.com/watch?v=fXb4ReFz77A",
        "icon": "assets/icons/safety.svg",
      },
      {
        "title": "Video Edukasi Keselamatan Berkendara – Perilaku Tidak Aman",
        "tag": "Kesadaran berkendara",
        "description":
            "Video ini menyoroti perilaku tidak aman yang bisa menyebabkan kecelakaan fatal di jalan.",
        "thumbnail": "assets/images/edukasi/video4.png",
        "url": "https://www.youtube.com/watch?v=fHsqtfLpATk",
        "icon": "assets/icons/mengemudi.svg",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return GestureDetector(
                onTap: () => _launchYoutube(video["url"]!),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          video["thumbnail"]!,
                          width: 120,
                          height: 110,
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
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: categoryBoxColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    video["icon"]!,
                                    width: 12,
                                    height: 12,
                                    color: categoryTextColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    video["tag"]!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: categoryTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              video["title"]!,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              video["description"]!,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF333333),
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
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
      ),
    );
  }
}
