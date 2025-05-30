import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medhub/presentation/home/pages/riwayat_jadwal_dan_konsultasi/lampiran_pdf_page.dart';

class DetailRiwayatPage extends StatelessWidget {
  const DetailRiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF00A89E);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
          color: primaryColor,
        ),
        title: Text(
          'Detail Riwayat Konsultasi',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // CARD DETAIL
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black.withOpacity(0.05)),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(40, 41, 61, 0.04),
                    blurRadius: 1,
                    offset: Offset(0, 0),
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(96, 97, 112, 0.08),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aulia Rahma Putri",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "#KDI2042025",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "19 April, 16:53 Wib",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _sectionTitle("Diagnosa / Keluhan"),
                  _sectionContent("Batuk\nPilek\nDemam (suhu tubuh 38,2ºC)\nBadan pegal"),
                  const SizedBox(height: 12),
                  _sectionTitle("Resep Obat / Terapi"),
                  _sectionContent("Paratusin – diminum 3 kali sehari setelah makan, selama 2–3 hari.\n(Jika tidak membaik, segera periksa ke fasilitas kesehatan)"),
                  const SizedBox(height: 12),
                  _sectionTitle("Hasil Pemeriksaan"),
                  _sectionContent("Suhu tubuh: 38,2ºC\nBelum ada pemeriksaan lanjutan"),
                  const SizedBox(height: 12),
                  _sectionTitle("Status Lanjutan"),
                  _sectionContent("Dalam pemantauan (disarankan periksa langsung jika tidak membaik)"),
                  const SizedBox(height: 16),
                  Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFECE5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundImage: AssetImage('assets/images/icondoctor.png'),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "dr. Rayan Ilham Nugraha",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Dokter Umum",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // PDF BOX
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PdfViewerPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(40, 41, 61, 0.04),
                      blurRadius: 1,
                      offset: Offset(0, 0),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(96, 97, 112, 0.16),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/pdf.png',
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.contain, // ✅ tidak nge-zoom
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/iconpdf.svg",
                          width: 28,
                          height: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hasil Pemeriksaan & Resep Obat",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Pdf 213 KB",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  Widget _sectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        content,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF333333),
        ),
      ),
    );
  }
}
