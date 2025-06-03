import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/data/model/response/edukasi_response_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:medhub/constants/variable.dart';

class DetailArtikelPage extends StatelessWidget {
  final Edukasi artikel;

  const DetailArtikelPage({super.key, required this.artikel});

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
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Share.share('Baca artikel "${artikel.title}" di MedHub!');
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
              Stack(
                children: [
                  _buildHeaderImage(artikel),
                  if (artikel.category?.name != null)
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
                              artikel.category!.name!,
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
                                  artikel.authorName ?? '-',
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
                                _formatPublishedDate(artikel.publishedAt),
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

              if (artikel.source != null)
                Row(
                  children: [
                    artikel.institutionLogo != null
                        ? Image.network(
                          _getFullImageUrl(artikel.institutionLogo!),
                          width: 24,
                          height: 24,
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint(
                              "Error loading institution logo: $error",
                            );
                            return const Icon(Icons.public);
                          },
                        )
                        : const Icon(Icons.public),
                    const SizedBox(width: 8),
                    Text(
                      artikel.source!,
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
                artikel.title ?? '',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                _cleanHtmlContent(artikel.content ?? ''),
                style: GoogleFonts.poppins(fontSize: 14, height: 1.5),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage(Edukasi artikel) {
    if (artikel.thumbnail == null || artikel.thumbnail!.isEmpty) {
      return Container(
        height: 200,
        color: Colors.grey[200],
        child: const Icon(
          Icons.image_not_supported,
          size: 48,
          color: Colors.grey,
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: Variable.imageBaseUrl(artikel.thumbnail),
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder:
          (context, url) => Container(
            height: 200,
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator()),
          ),
      errorWidget: (context, url, error) {
        debugPrint(' Error loading detail image: $error, URL: $url');
        return Container(
          height: 200,
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
        );
      },
    );
  }

  String _formatPublishedDate(DateTime? date) {
    if (date == null) return '';

    try {
      return "${date.day} ${_monthName(date.month)} ${date.year} • ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} WIB";
    } catch (e) {
      return '';
    }
  }

  String _monthName(int month) {
    const List<String> months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month];
  }

  String _cleanHtmlContent(String htmlContent) {
    String content = htmlContent.replaceAll(RegExp(r'<br\s*\/?>'), '\n');
    content = content.replaceAll(RegExp(r'<[^>]*>'), '');
    content = content.replaceAll('&nbsp;', ' ');
    content = content.replaceAll('&amp;', '&');
    content = content.replaceAll('&lt;', '<');
    content = content.replaceAll('&gt;', '>');
    content = content.replaceAll('&quot;', '"');
    content = content.replaceAll('&#39;', "'");
    return content;
  }

  String _getFullImageUrl(String path) {
    return Variable.imageBaseUrl(path);
  }
}