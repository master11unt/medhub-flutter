import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/datasource/education_remote_datasource.dart';
import 'package:medhub/data/model/response/edukasi_response_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart' show parse;

class VideoBloc extends Cubit<VideoState> {
  final EdukasiRemoteDataSource dataSource;
  bool _isClosed = false;

  VideoBloc(this.dataSource) : super(VideoLoading());

  @override
  Future<void> close() {
    _isClosed = true;
    return super.close();
  }

  Future<void> fetchVideos() async {
    if (_isClosed) return; // Check if closed before proceeding

    try {
      emit(VideoLoading());
      final videos = await dataSource.getVideoList();
      if (!_isClosed) {
        // Check again before emitting
        emit(VideoLoaded(videos));
      }
    } catch (e) {
      if (!_isClosed) {
        // Check before emitting error state
        emit(VideoError('Gagal memuat data video: $e'));
      }
    }
  }
}

abstract class VideoState {}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final List<Edukasi> videos;
  VideoLoaded(this.videos);
}

class VideoError extends VideoState {
  final String message;
  VideoError(this.message);
}

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // Make it nullable instead of late
  VideoBloc? _videoBloc;

  @override
  void initState() {
    super.initState();
    // Initialize immediately after super.initState()
    _videoBloc = VideoBloc(EdukasiRemoteDataSource(client: http.Client()));
    _videoBloc?.fetchVideos(); // Use safe call
  }

  @override
  void dispose() {
    _videoBloc?.close(); // Use safe call
    super.dispose();
  }

  // Function to strip HTML tags
  String stripHtml(String htmlString) {
    if (htmlString == null || htmlString.isEmpty) {
      return '';
    }

    // Parse the HTML
    final document = parse(htmlString);

    // Get the text content
    final String parsedString = document.body?.text ?? '';

    // Trim extra whitespace
    return parsedString.trim();
  }

  // Function to get category name
  String getCategoryName(dynamic category) {
    // Handle different possible category types
    if (category == null) {
      return 'Video';
    } else if (category is String) {
      return category;
    } else if (category is Map) {
      // If category is a Map, try to get the name/title
      return category['name'] ??
          category['title'] ??
          category['nama'] ??
          'Video';
    } else {
      // Try to get the name property if it exists
      try {
        return category.name ?? category.title ?? category.nama ?? 'Video';
      } catch (e) {
        // Return a default value if accessing properties fails
        return 'Video';
      }
    }
  }

  // Fungsi untuk membuka YouTube URL
  void _launchYoutube(String url) async {
    if (url.isEmpty) {
      debugPrint('URL kosong');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('URL video tidak tersedia')));
      return;
    }

    final uri = Uri.parse(url);
    try {
      final result = await launchUrl(uri, mode: LaunchMode.platformDefault);

      if (!result) {
        debugPrint('Gagal membuka URL: $url');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Gagal membuka video')));
      }
    } catch (e) {
      debugPrint('Error membuka URL: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if bloc is initialized before using it
    if (_videoBloc == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return BlocProvider.value(
      value: _videoBloc!, // Use non-null assertion only after checking
      child: BlocBuilder<VideoBloc, VideoState>(
        builder: (context, state) {
          if (state is VideoLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF00A89E)),
            );
          } else if (state is VideoError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Use the existing bloc instance
                      _videoBloc?.fetchVideos();
                    },
                    child: Text('Coba Lagi', style: GoogleFonts.poppins()),
                  ),
                ],
              ),
            );
          } else if (state is VideoLoaded) {
            final videos = state.videos;

            if (videos.isEmpty) {
              return Center(
                child: Text(
                  'Tidak ada video yang tersedia',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: videos.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final video = videos[index];
                return GestureDetector(
                  onTap: () => _launchYoutube(video.videoUrl ?? ''),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            Variable.imageBaseUrl(
                              video.thumbnail,
                            ), // GANTI INI!
                            width: 120,
                            height: 110,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 120,
                                height: 110,
                                color: Colors.grey[300],
                                child: const Icon(Icons.error),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEAF3FF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.play_circle_outline,
                                        size: 12,
                                        color: const Color(0xFF0C4CA6),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        getCategoryName(video.category),
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
                                  video.title ?? 'Tidak ada judul',
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
                                  // Strip HTML from content
                                  stripHtml(video.content ?? ''),
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
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('Terjadi kesalahan tidak terduga'));
        },
      ),
    );
  }
}