import 'package:flutter/material.dart';
import 'package:medhub/data/model/response/doctor_response_model.dart';
import '../pages/home_dan_konsultasi/doctor_detail_page.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorDetailPage(doctor: doctor),
          ),
        );
      },
      child: Container(
        width: 125,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar dokter dengan border + radius
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(0, 0, 0, 0.10),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: doctor.user?.image != null && doctor.user!.image!.isNotEmpty
                ? Image.network(
                    _getFullImageUrl(doctor.user!.image!),
                    height: 125,
                    width: 125,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Error loading doctor image: $error');
                      debugPrint('Image URL: ${_getFullImageUrl(doctor.user!.image!)}');
                      return Image.asset(
                        'assets/images/dokter1.png',
                        height: 125,
                        width: 125,
                        fit: BoxFit.cover,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 125,
                        width: 125,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF00A99D),
                          ),
                        ),
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/dokter1.png',
                    height: 125,
                    width: 125,
                    fit: BoxFit.cover,
                  ),
            ),

            const SizedBox(height: 8),

            // Teks nama dokter
            Text(
              doctor.user?.name ?? '-',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              doctor.specialization ?? 'Dokter Umum',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
  
  String _getFullImageUrl(String imagePath) {
    debugPrint('Original image path: $imagePath');
    
    // Jika sudah berupa URL lengkap, kembalikan apa adanya
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }
    
    // Hapus prefix file:/// jika ada
    if (imagePath.startsWith('file:///')) {
      imagePath = imagePath.substring(8);
    }
    
    // Base URL API
    const String baseApiUrl = 'https://medhub.my.id';
    
    // Pastikan path dimulai dengan slash
    if (!imagePath.startsWith('/')) {
      imagePath = '/$imagePath';
    }
    
    String finalUrl = '$baseApiUrl$imagePath';
    debugPrint('Final image URL: $finalUrl');
    
    return finalUrl;
  }
}