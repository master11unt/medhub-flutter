import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/model/response/obat_response_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailObatPage extends StatelessWidget {
  final ObatRespon obat;

  const DetailObatPage({super.key, required this.obat});

  void _launchURL(String url) async {
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
          'Deskripsi Obat',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Share.share('Cek info obat ${obat.name} di ${obat.k24Url}');
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
                child: _buildDetailImage(obat),
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
                            obat.name ?? '-',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF453E3E),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            obat.packaging ?? '',
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
                        obat.price ?? '',
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
              if (obat.isPrescription == true)
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
                      if (obat.attention != null && obat.attention!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            obat.attention!,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFFF25F24),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                "Detail",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              _detailSection("Deskripsi:", obat.description),
              _detailSection("Komposisi:", obat.composition),
              _detailSection("Kemasan:", obat.packaging),
              _detailSection("Indikasi / Manfaat / Kegunaan:", obat.benefits),
              _detailSection("Kategori:", obat.category),
              _detailSection("Dosis:", obat.dose),
              _detailSection("Penyajian:", obat.presentation),
              _detailSection("Cara Penyimpanan:", obat.storage),
              _detailSection("Perhatian:", obat.attention),
              _detailSection("Efek Samping:", obat.sideEffects),
              _detailSection("Nama Standar MIMS:", obat.mimsStandardName),
              _detailSection("Nomor Izin Edar:", obat.registrationNumber),
              _detailSection("Golongan Obat:", obat.drugClass),
              _detailSection("Keterangan:", remarksValues.reverse[obat.remarks]),
              _detailSection("Referensi:", obat.reference),
              const SizedBox(height: 24),
              if (obat.k24Url != null && obat.k24Url!.isNotEmpty)
                Center(
                  child: GestureDetector(
                    onTap: () => _launchURL(obat.k24Url!),
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

  Widget _detailSection(String title, String? content) {
    if (content == null || content.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: GoogleFonts.poppins(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailImage(ObatRespon obat) {
    debugPrint('=== DETAIL IMAGE DEBUG ===');
    debugPrint('Obat: ${obat.name}');
    debugPrint('Raw image URL: "${obat.image}"');

    if (obat.image == null || obat.image!.isEmpty) {
      debugPrint('❌ Detail image is null or empty');
      return Container(
        width: 305,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.medication_outlined,
          size: 100,
          color: Colors.grey,
        ),
      );
    }

    String imageUrl = obat.image!.trim();

    if (!imageUrl.startsWith('http')) {
      if (imageUrl.startsWith('/')) {
        imageUrl = imageUrl.substring(1);
      }
      imageUrl = '${Variable.baseUrl}/$imageUrl';
    }

    debugPrint('✅ Final detail image URL: "$imageUrl"');

    return Image.network(
      imageUrl,
      width: 305,
      height: 150,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return Container(
          width: 305,
          height: 150,
          color: Colors.grey.shade50,
          child: const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF00B894),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint('❌ Detail image load failed: $imageUrl');
        debugPrint('❌ Error: $error');

        return Container(
          width: 305,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.medication_outlined,
            size: 100,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}