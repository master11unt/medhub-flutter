import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailObatPage extends StatelessWidget {
  final String name;
  final String package;
  final String price;
  final String image;
  final String url;
  final String? warning;

  const DetailObatPage({
    super.key,
    required this.name,
    required this.package,
    required this.price,
    required this.image,
    required this.url,
    this.warning,
  });

  void _launchURL() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF00B894);

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
          '',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Share.share('Cek info obat $name di $url');
            },
            icon: SvgPicture.asset(
              'assets/icons/share.svg',
              width: 28,
              height: 28,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Center(
                child: Image.asset(
                  image,
                  width: 305,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 60),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xFFF5F5F5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF453E3E),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            package,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF888888),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        price,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF25F24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (warning != null && warning!.isNotEmpty)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF0ED),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Harus dengan resep dokter',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF25F24),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        warning!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFFF25F24),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              Text("Detail", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              _detailSection("Deskripsi:", """
Paratusin untuk apa? Paratusin adalah obat untuk meringankan gejala flu seperti demam, sakit kepala, hidung tersumbat dan bersin-bersin yang disertai batuk. Obat ini masuk dalam golongan obat bebas terbatas.
Setiap 1 tablet Paratusin mengandung:
1. Paracetamol (Acetaminophen) adalah zat aktif yang memiliki aktivitas sebagai penurun demam/antipiretik dan pereda nyeri/analgesik yang bisa diperoleh tanpa resep dokter.
2. Dexchlorpheniramine maleate (CTM) adalah zat aktif yang digunakan untuk mengobati gejala alergi seperti rhinitis dan urtikaria.
3. Pseudoephedrin adalah nasal dekongestan.
4. Guaifenesin adalah ekspektoran.
5. Noscapine adalah antitusif.

Kemasan lain:
• Paratusin Sirup 60ml
• Paratusin Tablet Los
"""),
              _detailSection("Komposisi:", "paracetamol 500mg, guaifenesin 50 mg, noscapine 10 mg, phenylpropanolamin hcl 15mg, ctm 2 mg"),
              _detailSection("Kemasan:", "1 Dos isi 20 Strip x 10 Tablet"),
              _detailSection("Indikasi / Manfaat / Kegunaan:", "untuk meringankan gejala flu seperti demam, sakit kepala, hidung tersumbat dan bersin bersin disertai batuk."),
              _detailSection("Kategori:", "Sistem Pernapasan"),
              _detailSection("Dosis:", "> 12 th : 3 x sehari 1 tablet, 6–12 th : 3 x sehari 1/2 tablet"),
              _detailSection("Penyajian:", "sesudah makan"),
              _detailSection("Cara Penyimpanan:", "simpan di tempat sejuk dan kering, terhindar dari paparan sinar matahari langsung"),
              _detailSection("Perhatian:", "penderita dengan gangguan fungsi hati yang berat , penderita yang hipersensitif terhadap komponen obat ini"),
              _detailSection("Efek Samping:", "mengantuk, gangguan pencernaan, insomnia, gelisah, eksitasi, tremor, takikardi, aritmia, mulut kering, sulit berkemih, penggunaan dosis besar dan jangka panjang menyebabkan kerusakan hati."),
              _detailSection("Nama Standar MIMS:", "PARATUSIN TAB 200S"),
              _detailSection("Nomor Izin Edar:", "DTL1604525010A1"),
              _detailSection("Golongan Obat:", "Obat Bebas Terbatas"),
              _detailSection("Keterangan:", "Terakhir diperbarui pada 22 April 2025"),
              _detailSection("Referensi:", """
Deskripsi Paratusin Tablet 1 Strip Isi 10 Tablet diambil dari:
• BPOM (2025)
• Medscape (2025)
• MIMS Indonesia (2025)
"""),
              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: _launchURL,
                  child: Container(
                    width: 335,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00A89E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Beli di K 24 Mart',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(
            content,
            style: GoogleFonts.poppins(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
