import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/konsultasi_page.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF00A89E);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 55,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new, size: 18),
        //   onPressed: () => Navigator.pop(context),
        //   color: primaryColor,
        // ),
        title: Text(
          "Jadwal",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: primaryColor,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Jadwal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Aulia Rahma Putri",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Flexible(
                    child: Text(
                      "25 April, 08.00 WIB",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text("#KD12042025", style: TextStyle(color: Colors.grey)),
              const Divider(height: 24),

              // Info Dokter
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/dokter2rb.png', // Pastikan file tersedia
                      width: 80,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "dr. Raihana Nur Aziza",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: const [
                            Text(
                              "Dokter Umum",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.circle, size: 10, color: Colors.green),
                            SizedBox(width: 4),
                            Text(
                              "Online",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Senin, Rabu",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.thumb_up,
                                    size: 14,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "96%",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 10,
                        //     vertical: 6,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     color: const Color(0xFFFFEFD6),
                        //     borderRadius: BorderRadius.circular(6),
                        //   ),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       const Icon(
                        //         Icons.circle,
                        //         size: 10,
                        //         color: Colors.orange,
                        //       ),
                        //       const SizedBox(width: 6),
                        //       Text(
                        //         "Sedang Konsultasi",
                        //         style: TextStyle(
                        //           color: Colors.grey[600],
                        //           fontSize: 13,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Tombol Konsultasi Sekarang
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                 onPressed: () {
  showLoadingDialog(context);

  Future.delayed(const Duration(seconds: 2), () {
    if (Navigator.canPop(context)) Navigator.pop(context); // Tutup dialog

    // Gunakan pushReplacement untuk memastikan halaman terbuka
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ConsultationChatPage(),
      ),
    );
  });
},

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A89E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Konsultasi sekarang",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: Container(
            width: 300,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: const Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 13,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00C8AE)),
                  backgroundColor: Color(0xFFB2F1EC),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

}
