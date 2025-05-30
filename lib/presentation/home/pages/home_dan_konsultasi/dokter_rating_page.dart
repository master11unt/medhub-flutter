import 'package:flutter/material.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/main_page.dart';
import 'package:url_launcher/url_launcher.dart';


class DoctorRatingPage extends StatefulWidget {
  const DoctorRatingPage({super.key});

  @override
  State<DoctorRatingPage> createState() => _DoctorRatingPageState();
}

class _DoctorRatingPageState extends State<DoctorRatingPage> {
  String? selectedRating;

  final List<Map<String, dynamic>> ratings = [
    {"label": "Sangat puas", "value": "sangat_puas", "percentage": "85%"},
    {"label": "Puas", "value": "puas", "percentage": "70%"},
    {"label": "Cukup", "value": "cukup", "percentage": "60%"},
    {"label": "Kurang puas", "value": "kurang_puas", "percentage": "35%"},
    {"label": "Tidak puas", "value": "tidak_puas", "percentage": "10%"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
   appBar: AppBar(
  automaticallyImplyLeading: false,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.teal, size: 18),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
  title: const Text(
    'Beri Penilaian Dokter',
    style: TextStyle(
      color: Colors.teal,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  titleSpacing: 0, // Biar teks mepet ke kiri, dekat tombol
  backgroundColor: Colors.white,
  elevation: 0,
  surfaceTintColor: Colors.white,
),


      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            Center(
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade100,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/img_dokter.png'),
                    fit: BoxFit.contain, // tidak akan crop wajah
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Konsultasi online',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  '19 April, 16:53 Wib',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Text(
              'dr. Rayan Ilham Nugraha',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            Divider(
              thickness: 1,
              color: Color.fromARGB(255, 103, 102, 102), // abu terang
            ),
            const SizedBox(height: 16),
            const Text(
              'Resep Digital',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/paratusin.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Lameson 4mg Tablet',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('per Tablet'),
                        SizedBox(height: 4),
                        Text('Rp 6.328,- / Tablet'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '2 Per Strip',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Penilaian Dokter',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    'Berikan penilaian ke dokter',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...ratings.map((rating) {
                    return RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(rating['label']),
                          Text(rating['percentage']),
                        ],
                      ),
                      value: rating['value'],
                      groupValue: selectedRating,
                      onChanged: (value) {
                        setState(() {
                          selectedRating = value;
                        });
                      },
                      activeColor: Colors.teal,
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              _showConfirmationDialog(context);
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Beli Obat',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'lanjut ke k 24 mart\nuntuk membeli obat?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                   onPressed: () async {
  Navigator.pop(context);
  const url = 'https://www.k24klik.com/';
  final uri = Uri.parse(url);
  try {
    final result = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal membuka link')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gagal membuka link')),
    );
  }
},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Lanjutkan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
  width: double.infinity,
  child: OutlinedButton(
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainPage()), // <-- Ganti MainPage sesuai dengan halaman utama kamu
      );
    },
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: Colors.teal),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14),
    ),
    child: const Text(
      'Kembali Ke Beranda',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.teal,
      ),
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
}
