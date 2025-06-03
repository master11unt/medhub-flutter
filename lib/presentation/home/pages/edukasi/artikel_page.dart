import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/datasource/education_remote_datasource.dart';
import 'package:medhub/data/model/response/edukasi_response_model.dart';
import 'package:medhub/presentation/home/bloc/edukasi/edukasi_bloc.dart';
import 'detail_artikel_page.dart';

class ArtikelPage extends StatefulWidget {
  final String selectedKategori;

  const ArtikelPage({super.key, required this.selectedKategori});

  @override
  State<ArtikelPage> createState() => _ArtikelPageState();
}

class _ArtikelPageState extends State<ArtikelPage> {
  final Map<String, String> _htmlCleanCache = {};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dataSource = EdukasiRemoteDataSource(client: http.Client());
      dataSource.debugFullApiResponse();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        context.read<EdukasiBloc>().add(
          EdukasiEvent.fetch(widget.selectedKategori),
        );
      } catch (e) {
        debugPrint("Error accessing EdukasiBloc: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EdukasiBloc, EdukasiState>(
      builder: (context, state) {
        if (state is EdukasiStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EdukasiStateSuccess) {
          List<Edukasi> artikelList = state.edukasi
              .where((e) => e.type?.toLowerCase() == 'artikel' || e.type == null)
              .toList();

          if (widget.selectedKategori.isNotEmpty) {
            artikelList = artikelList
                .where(
                  (e) =>
                      e.category != null &&
                      e.category!.name != null &&
                      e.category!.name!.toLowerCase().contains(
                            widget.selectedKategori.toLowerCase(),
                          ),
                )
                .toList();
          }

          if (artikelList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.article_outlined, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    widget.selectedKategori.isEmpty
                        ? 'Tidak ada artikel tersedia saat ini.'
                        : 'Tidak ada artikel untuk kategori "${widget.selectedKategori}".',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<EdukasiBloc>().add(const EdukasiEvent.fetch());
                    },
                    child: const Text('Muat Ulang'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: artikelList.length,
            itemBuilder: (context, index) {
              final item = artikelList[index];
              final cleanContent = _cleanHtmlContent(item.content ?? '');

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailArtikelPage(artikel: item),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: _buildThumbnail(item),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item.category != null) ...[
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
                                    if (item.educationCategoryId != null) ...[
                                      FutureBuilder<String?>(
                                        future: EdukasiRemoteDataSource(
                                          client: http.Client(),
                                        ).getCategoryIconUrl(
                                          item.educationCategoryId!,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const SizedBox(
                                              width: 16,
                                              height: 16,
                                              child:
                                                  CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Color(0xFF00A89E),
                                                  ),
                                            );
                                          } else if (snapshot.hasData &&
                                              snapshot.data != null) {
                                            final url = snapshot.data!;
                                            if (url.toLowerCase().endsWith(
                                              '.svg',
                                            )) {
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: SvgPicture.network(
                                                  url,
                                                  width: 16,
                                                  height: 16,
                                                  placeholderBuilder:
                                                      (
                                                        context,
                                                      ) => const SizedBox(
                                                        width: 16,
                                                        height: 16,
                                                        child:
                                                            CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                              color: Color(
                                                                0xFF00A89E,
                                                              ),
                                                            ),
                                                      ),
                                                ),
                                              );
                                            } else {
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: CachedNetworkImage(
                                                  imageUrl: url,
                                                  width: 16,
                                                  height: 16,
                                                  fit: BoxFit.cover,
                                                  errorWidget: (
                                                    context,
                                                    url,
                                                    error,
                                                  ) {
                                                    debugPrint(
                                                      'Error loading category icon: $error, URL: $url',
                                                    );
                                                    return const Icon(
                                                      Icons.category,
                                                      size: 12,
                                                      color: Color(
                                                        0xFF0C4CA6,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                          } else {
                                            return const Icon(
                                              Icons.category,
                                              size: 12,
                                              color: Color(0xFF0C4CA6),
                                            );
                                          }
                                        },
                                      ),
                                    ] else if (item.category?.icon != null &&
                                        item.category!.icon!.isNotEmpty) ...[
                                      // Fallback to the existing category icon logic
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          4,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: Variable.imageBaseUrl(
                                            item.category!.icon,
                                          ),
                                          width: 16,
                                          height: 16,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) {
                                            debugPrint(
                                              'Error loading category icon: $error, URL: $url',
                                            );
                                            return const Icon(
                                              Icons.category,
                                              size: 12,
                                              color: Color(0xFF0C4CA6),
                                            );
                                          },
                                        ),
                                      ),
                                    ] else ...[
                                      const Icon(
                                        Icons.category,
                                        size: 12,
                                        color: Color(0xFF0C4CA6),
                                      ),
                                    ],
                                    const SizedBox(width: 4),
                                    Text(
                                      item.category?.name ?? '',
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
                            ],
                            Text(
                              item.title ?? '-',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              cleanContent,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
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
          );
        } else if (state is EdukasiStateError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error: ${state.message}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.read<EdukasiBloc>().add(const EdukasiEvent.fetch());
                  },
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text("Terjadi kesalahan."));
        }
      },
    );
  }

  Widget _buildThumbnail(Edukasi item) {
    final isVideo =
        (item.type?.toLowerCase() == 'video') ||
        (item.videoUrl != null && item.videoUrl!.isNotEmpty);

    if (item.thumbnail == null || item.thumbnail!.isEmpty) {
      // Jika video, tampilkan icon play di tengah
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(
            isVideo ? Icons.play_circle_fill : Icons.image_not_supported,
            color: Colors.grey,
            size: 40,
          ),
        ),
      );
    }

    final imageUrl = Variable.imageBaseUrl(item.thumbnail);

    debugPrint(
      '[THUMBNAIL DEBUG] ${item.title} | type: ${item.type} | url: $imageUrl',
    );

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            memCacheWidth: 160,
            placeholder:
                (context, url) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF00A89E),
                      ),
                    ),
                  ),
                ),
            errorWidget: (context, url, error) {
              debugPrint(
                '[THUMBNAIL ERROR] ${item.title} | url: $url | error: $error',
              );
              return Container(
                width: 80,
                height: 80,
                color: Colors.grey[200],
                child: Icon(
                  isVideo ? Icons.play_circle_fill : Icons.broken_image,
                  color: Colors.grey,
                  size: 40,
                ),
              );
            },
          ),
        ),
        if (isVideo)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.play_circle_fill,
                color: Colors.white.withOpacity(0.8),
                size: 36,
              ),
            ),
          ),
      ],
    );
  }

  String _cleanHtmlContent(String htmlContent) {
    if (_htmlCleanCache.containsKey(htmlContent)) {
      return _htmlCleanCache[htmlContent]!;
    }

    final String cleaned =
        htmlContent
            .replaceAll(RegExp(r'<br\s*\/?>|<\/?(p|div)[^>]*>'), ' ')
            .replaceAll(RegExp(r'<[^>]*>'), '')
            .replaceAll(RegExp(r'&[^;]+;'), ' ')
            .replaceAll(RegExp(r'\s{2,}'), ' ')
            .trim();

    _htmlCleanCache[htmlContent] = cleaned;
    return cleaned;
  }

  Widget _buildArticleItem(Edukasi item) {
    final thumbnailUrl = Variable.imageBaseUrl(item.thumbnail);

    return ListTile(
      leading: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            _buildThumbnail(item),

            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  item.thumbnail == null
                      ? "NULL"
                      : item.thumbnail!.isEmpty
                      ? "EMPTY"
                      : "URL",
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}