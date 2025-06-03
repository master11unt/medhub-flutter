import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/datasource/education_remote_datasource.dart';
import 'package:medhub/data/model/response/edukasi_response_model.dart';
import 'detail_artikel_page.dart';

class SearchEdukasiBloc extends Cubit<SearchEdukasiState> {
  final EdukasiRemoteDataSource dataSource;

  SearchEdukasiBloc(this.dataSource) : super(SearchEdukasiInitial());

  Future<void> searchEdukasi(String query, {String? category}) async {
    try {
      emit(SearchEdukasiLoading());

      final allEdukasi = await dataSource.getEdukasiList(null);

      List<Edukasi> filteredResults = allEdukasi;

      if (query.isNotEmpty) {
        filteredResults =
            filteredResults
                .where(
                  (edukasi) =>
                      (edukasi.title?.toLowerCase().contains(
                            query.toLowerCase(),
                          ) ??
                          false) ||
                      (edukasi.content?.toLowerCase().contains(
                            query.toLowerCase(),
                          ) ??
                          false),
                )
                .toList();
      }

      if (category != null && category.isNotEmpty) {
        filteredResults =
            filteredResults
                .where(
                  (edukasi) =>
                      edukasi.category?.name?.toLowerCase() ==
                      category.toLowerCase(),
                )
                .toList();
      }

      emit(SearchEdukasiSuccess(filteredResults));
    } catch (e) {
      emit(SearchEdukasiFailure(e.toString()));
    }
  }

  Future<void> fetchCategories() async {
    try {
      debugPrint("⭐ STARTING fetchCategories");

      final allEdukasi = await dataSource.getEdukasiList(null);
      debugPrint("📄 Fetched ${allEdukasi.length} edukasi items from backend");

      final Set<String> uniqueCategories = {};
      for (var item in allEdukasi) {
        if (item.category != null &&
            item.category!.name != null &&
            item.category!.name!.isNotEmpty) {
          uniqueCategories.add(item.category!.name!);
        }
      }

      final List<String> sortedCategories = uniqueCategories.toList()..sort();
      debugPrint(
        "Emitting ${sortedCategories.length} categories from backend",
      );

      emit(CategoriesLoaded(sortedCategories));

      return;
    } catch (e) {
      debugPrint(" ERROR fetching categories from backend: $e");
      emit(SearchEdukasiFailure("Gagal memuat kategori: $e"));
      return;
    }
  }
}

// States
abstract class SearchEdukasiState {}

class SearchEdukasiInitial extends SearchEdukasiState {}

class SearchEdukasiLoading extends SearchEdukasiState {}

class SearchEdukasiSuccess extends SearchEdukasiState {
  final List<Edukasi> results;

  SearchEdukasiSuccess(this.results);
}

class CategoriesLoaded extends SearchEdukasiState {
  final List<String> categories;

  CategoriesLoaded(this.categories);
}

class SearchEdukasiFailure extends SearchEdukasiState {
  final String error;

  SearchEdukasiFailure(this.error);
}

class SearchEdukasiPage extends StatefulWidget {
  const SearchEdukasiPage({super.key});

  @override
  State<SearchEdukasiPage> createState() => _SearchEdukasiPageState();
}

class _SearchEdukasiPageState extends State<SearchEdukasiPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = '';
  List<String> categories = [];
  late final SearchEdukasiBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchEdukasiBloc(
      EdukasiRemoteDataSource(client: http.Client()),
    );

    _searchBloc.fetchCategories().then((_) {
      if (mounted) {
        _searchBloc.searchEdukasi('');
      }
    });

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchBloc.close();
    super.dispose();
  }

  Future<void> _onSearchChanged() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      _searchBloc.searchEdukasi(
        _searchController.text,
        category: selectedCategory,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back, size: 18, color: Colors.teal),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
          title: Text(
            'Edukasi Pengendara',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.teal,
            ),
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Cari Edukasi',
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Pilih Kategori',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(width: 8),
                      BlocBuilder<SearchEdukasiBloc, SearchEdukasiState>(
                        builder: (context, state) {
                          if (state is SearchEdukasiLoading) {
                            return const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  BlocBuilder<SearchEdukasiBloc, SearchEdukasiState>(
                    buildWhen: (previous, current) {
                      return current is CategoriesLoaded ||
                          current is SearchEdukasiInitial;
                    },
                    builder: (context, state) {
                      if (state is CategoriesLoaded) {
                        categories = state.categories;
                        if (categories.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Tidak ada kategori tersedia',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          );
                        }
                        return _buildCategoriesList(categories);
                      }
                      return _buildCategoryPlaceholders();
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Expanded(
                child: BlocBuilder<SearchEdukasiBloc, SearchEdukasiState>(
                  buildWhen: (previous, current) {
                    return current is SearchEdukasiLoading ||
                        current is SearchEdukasiSuccess ||
                        current is SearchEdukasiFailure;
                  },
                  builder: (context, state) {
                    if (state is SearchEdukasiLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SearchEdukasiSuccess) {
                      if (state.results.isEmpty) {
                        return Center(
                          child: Text(
                            selectedCategory.isEmpty
                                ? 'Tidak ada hasil pencarian untuk "${_searchController.text}"'
                                : 'Tidak ada artikel untuk kategori "$selectedCategory" dengan kata kunci "${_searchController.text}"',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          final artikel = state.results[index];
                          return _buildArticleItem(artikel);
                        },
                      );
                    } else if (state is SearchEdukasiFailure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 48,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Error: ${state.error}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed:
                                  () => _searchBloc.searchEdukasi(
                                    _searchController.text,
                                    category: selectedCategory,
                                  ),
                              child: const Text('Coba Lagi'),
                            ),
                          ],
                        ),
                      );
                    }
                    // Initial state
                    return _buildInitialMessage();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesList(List<String> categories) {
    final sortedCategories = List<String>.from(categories)..sort();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children:
            sortedCategories.map((item) {
              final isSelected = selectedCategory == item;
              return Container(
                margin: const EdgeInsets.only(right: 12, bottom: 6, top: 2),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      debugPrint("Tapped on category: $item");
                      setState(() {
                        selectedCategory = isSelected ? '' : item;
                      });

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _searchBloc.searchEdukasi(
                          _searchController.text,
                          category: isSelected ? '' : item,
                        );
                      });
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.teal.shade50 : Colors.white,
                        border: Border.all(
                          color:
                              isSelected ? Colors.teal : Colors.grey.shade300,
                          width: isSelected ? 1.5 : 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: Colors.teal.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Text(
                          item,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w500,
                            color: isSelected ? Colors.teal : Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildArticleItem(Edukasi item) {
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
            // Thumbnail
            _buildThumbnail(item),
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
                          // Tampilkan icon kategori dari backend
                          if (item.category?.icon != null &&
                              item.category!.icon!.isNotEmpty) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                imageUrl: Variable.imageBaseUrl(
                                  item.category!.icon,
                                ),
                                width: 16,
                                height: 16,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) {
                                  return const Icon(
                                    Icons.category,
                                    size: 12,
                                    color: Color(0xFF0C4CA6),
                                  );
                                },
                              ),
                            ),
                          ] else ...[
                            // Fallback jika tidak ada icon
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
                  // Judul
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
                  // Konten
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
  }

  // Fungsi untuk menampilkan thumbnail artikel
  Widget _buildThumbnail(Edukasi item) {
    if (item.thumbnail == null || item.thumbnail!.isEmpty) {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: Variable.imageBaseUrl(item.thumbnail),
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
          debugPrint('Error loading image: $error, URL: $url');
          return Container(
            width: 80,
            height: 80,
            color: Colors.grey[200],
            child: const Icon(Icons.broken_image, color: Colors.grey),
          );
        },
      ),
    );
  }

  String _cleanHtmlContent(String htmlContent) {
    if (htmlContent.isEmpty) {
      return '';
    }

    try {
      String result = htmlContent;

      const entities = {
        '&gt;': '>',
        '&lt;': '<',
        '&amp;': '&',
        '&quot;': '"',
        '&apos;': "'",
        '&nbsp;': ' ',
      };

      entities.forEach((entity, replacement) {
        result = result.replaceAll(entity, replacement);
      });

      result = result.replaceAll(RegExp(r'<br\s*\/?>|<\/?(p|div)[^>]*>'), ' ');
      result = result.replaceAll(RegExp(r'<[^>]*>'), '');

      result = result.replaceAll(RegExp(r'>{2,}'), ''); 
      result = result.replaceAll(RegExp(r'\\[rnt]'), ' '); 
      result = result.replaceAll(
        RegExp(r'\s{2,}'),
        ' ',
      ); 

      return result.trim();
    } catch (e) {
      debugPrint('Error cleaning HTML: $e');
     
      return htmlContent
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .replaceAll('&gt;', '>')
          .replaceAll('&lt;', '<')
          .trim();
    }
  }


  Widget _buildInitialMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'Pilih kategori atau ketik kata kunci untuk mencari',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 14),
          ),
        ],
      ),
    );
  }

  
  Widget _buildCategoryPlaceholders() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          4,
          (index) => Container(
            margin: const EdgeInsets.only(right: 12),
            width: 80 + (index * 10),
            height: 36,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ), 
      ),
    );
  }
}