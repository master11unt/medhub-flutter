import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/constants/variable.dart';
import 'package:medhub/presentation/home/bloc/obat/obat_bloc.dart';
import 'package:medhub/presentation/home/pages/obat/detail_obat_page.dart';
import 'package:medhub/data/model/response/obat_response_model.dart';

class ObatPage extends StatefulWidget {
  const ObatPage({super.key});

  @override
  State<ObatPage> createState() => _ObatPageState();
}

class _ObatPageState extends State<ObatPage> {
  final TextEditingController _searchController = TextEditingController();

  // Safe setState wrapper untuk menghindari error setelah dispose
  void _safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    // Tambahkan delay kecil untuk memastikan context sudah ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ObatBloc>().add(const ObatEvent.fetch());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF00B894);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
          color: primaryColor,
        ),
        title: Text(
          'Cari Obat',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Search bar
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Fallback untuk SVG yang mungkin error
                  SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 20,
                    height: 20,
                    color: Colors.grey,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.search, color: Colors.grey, size: 20);
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => _safeSetState(() {}), // Gunakan safe setState
                      decoration: InputDecoration(
                        hintText: 'Cari Obat',
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // BLoC Builder dengan error handling yang lebih baik
            Expanded(
              child: BlocBuilder<ObatBloc, ObatState>(
                builder: (context, state) {
                  debugPrint('Current state type: ${state.runtimeType}');
                  
                  // Pattern matching yang lebih aman untuk versi lama
                  final stateType = state.runtimeType.toString();
                  
                  if (stateType.contains('Initial')) {
                    return const Center(
                      child: Text(
                        'Memuat data obat...',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  } 
                  
                  if (stateType.contains('Loading')) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF00B894),
                      ),
                    );
                  } 
                  
                  if (stateType.contains('Success')) {
                    return _buildSuccessState(state);
                  } 
                  
                  if (stateType.contains('Error')) {
                    return _buildErrorState(state);
                  }
                  
                  // Default fallback
                  return const Center(
                    child: Text(
                      'Status tidak diketahui',
                      style: TextStyle(color: Colors.grey),
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

  Widget _buildSuccessState(dynamic state) {
    try {
      final successState = state as dynamic;
      final rawData = successState.obat;
      
      List<ObatRespon> data = [];
      if (rawData is List) {
        // Filter hanya ObatRespon yang valid
        for (var item in rawData) {
          if (item is ObatRespon) {
            data.add(item);
          }
        }
      }
      
      debugPrint('✅ Data loaded: ${data.length} items');
      
      final query = _searchController.text.toLowerCase();
      final filtered = data.where((obat) {
        final name = obat.name?.toLowerCase() ?? '';
        return name.contains(query);
      }).toList();

      if (filtered.isEmpty) {
        return _buildEmptyState(query);
      }

      return GridView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.72,
        ),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final obat = filtered[index];
          return _buildObatCard(context, obat);
        },
      );
    } catch (e) {
      debugPrint('❌ Error in success state: $e');
      return _buildDataErrorState(e.toString());
    }
  }

  Widget _buildEmptyState(String query) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            query.isEmpty ? Icons.inventory_2_outlined : Icons.search_off,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            query.isEmpty ? 'Tidak ada obat tersedia' : 'Obat tidak ditemukan',
            style: GoogleFonts.poppins(
              fontSize: 16, 
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            query.isEmpty 
              ? 'Belum ada data obat di database'
              : 'Coba dengan kata kunci lain',
            style: GoogleFonts.poppins(
              fontSize: 14, 
              color: Colors.grey.shade600,
            ),
          ),
          if (query.isEmpty) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                if (mounted) {
                  context.read<ObatBloc>().add(const ObatEvent.fetch());
                }
              },
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text('Muat Ulang', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00B894),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorState(dynamic state) {
    final errorState = state as dynamic;
    final message = errorState.message ?? 'Terjadi kesalahan tidak diketahui';
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Terjadi Kesalahan',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.red.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              if (mounted) {
                context.read<ObatBloc>().add(const ObatEvent.fetch());
              }
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: const Text('Coba Lagi', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00B894),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber_outlined,
            size: 64,
            color: Colors.orange.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Error Memproses Data',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.orange.shade600,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              if (mounted) {
                context.read<ObatBloc>().add(const ObatEvent.fetch());
              }
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: const Text('Coba Lagi', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00B894),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObatCard(BuildContext context, ObatRespon obat) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailObatPage(obat: obat),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
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
            const SizedBox(height: 8),
            Expanded(
              child: Center(
                child: _buildObatImage(obat),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              obat.name ?? 'Nama obat tidak tersedia',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF453E3E),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              obat.packaging ?? '-',
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF888888),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              'Rp ${_formatPrice(obat.price)}',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF25F24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildObatImage(ObatRespon obat) {
    if (obat.image == null || obat.image!.isEmpty) {
      return _buildPlaceholderImage();
    }

    String imageUrl = _getFullImageUrl(obat.image!);

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade50,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            
            return Container(
              width: 80,
              height: 80,
              color: Colors.grey.shade50,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF00B894),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            debugPrint('❌ Image load failed: $imageUrl');
            return _buildPlaceholderImage();
          },
        ),
      ),
    );
  }

  String _getFullImageUrl(String imagePath) {
    // Jika sudah URL lengkap
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }
    
    // Hapus prefix file:/// jika ada
    if (imagePath.startsWith('file:///')) {
      imagePath = imagePath.substring(8);
    }
    
    // Gunakan Variable.imageBaseUrl untuk konsistensi
    return Variable.imageBaseUrl(imagePath);
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.medication_outlined,
        size: 48,
        color: Colors.grey,
      ),
    );
  }

  String _formatPrice(dynamic price) {
    if (price == null) return '0';
    
    String priceStr = price.toString();
    priceStr = priceStr.replaceAll(RegExp(r'[^\d]'), '');
    
    if (priceStr.isEmpty) return '0';
    
    try {
      final int priceInt = int.parse(priceStr);
      return priceInt.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      );
    } catch (e) {
      return priceStr;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}