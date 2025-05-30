import 'package:flutter/material.dart';
import 'package:medhub/presentation/home/pages/agenda_kesehatan/data_pendaftar_page.dart';
import 'package:medhub/presentation/home/pages/agenda_kesehatan/health_service_detail_page.dart';
import '../../../models/health_service.dart';

class HealthServiceCard extends StatelessWidget {
  final HealthService service;
  final bool isBooking;

  const HealthServiceCard({
    super.key,
    required this.service,
    this.isBooking = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 255,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background Image
            Image.asset(
              service.imagePath,
              height: 210,
              // width: double.infinity,
              // fit: BoxFit.cover,
            ),

            // White Box on Bottom
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date and Location
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service.dateTime,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                service.location,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Pilih Button
                    ElevatedButton(
  onPressed: () {
    if (isBooking) {
      // Kalau booking langsung ke DataPendaftarPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DataPendaftarPage(
            service: service,
            showSimpanButton: false,
          ),
        ),
      );
    } else {
      // Kalau layanan ke detail dulu
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HealthServiceDetailPage(service: service),
        ),
      );
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF00A99D),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    elevation: 0,
  ),
  child: Text(
    isBooking ? 'Detail' : 'Pilih',
    style: const TextStyle(color: Colors.white),
  ),
),

                      ],
                    ),
                    
                  ],
                ),
              ),
            ),

            // Orange Label
            Positioned(
              top: 150,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFF26722),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  service.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
