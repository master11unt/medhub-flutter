import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/presentation/home/pages/obat/detail_obat_page.dart';

class ObatPage extends StatefulWidget {
  const ObatPage({super.key});

  @override
  State<ObatPage> createState() => _ObatPageState();
}

class _ObatPageState extends State<ObatPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _medicines = [
    {
      'name': 'Paratusin Tablet 1 Strip',
      'package': 'per Strip',
      'price': 'Rp 2.846,- / Strip',
      'image': 'assets/images/obat/paratusin.png',
      'url': 'https://www.k24klik.com/p/paratusin-tab-200s-273',
    },
    {
      'name': 'Lameson 4 mg Tablet',
      'package': 'per Tablet',
      'price': 'Rp 6.238,- / Tablet',
      'image': 'assets/images/obat/lameson.png',
      'url': 'https://www.k24klik.com/p/lameson-4mg-tab-100s-517',
      'warning': 'Obat ini harus menggunakan resep dokter',
    },
    {
      'name': 'Rhinos sr kapsul',
      'package': 'per Tablet',
      'price': 'Rp 9.796,- / Tablet',
      'image': 'assets/images/obat/rhinos.png',
      'url': 'https://www.k24klik.com/p/rhinos-sr-cap-50s-318',
      'warning': 'Obat ini harus menggunakan resep dokter',
    },
    {
      'name': 'Sistenol Tablet 1 Botol',
      'package': 'per Tablet',
      'price': 'Rp 3.615,- / Tablet',
      'image': 'assets/images/obat/sistenol.png',
      'url': 'https://www.k24klik.com/p/sistenol-capl-60s-426',
      'warning': 'Obat ini harus menggunakan resep dokter',
    },
    {
      'name': 'Vometa Sirup 60ml',
      'package': 'per Botol',
      'price': 'Rp 2.846,- / Botol',
      'image': 'assets/images/obat/vometa.png',
      'url': 'https://www.k24klik.com/p/vometa-5mg-5ml-susp-60ml-30',
      'warning': 'Obat ini harus menggunakan resep dokter',
    },
    {
      'name': 'Zambuk salep 25 Gr',
      'package': 'per Tube',
      'price': 'Rp 51.306,- / Tube',
      'image': 'assets/images/obat/zambuk.png',
      'url': 'https://www.k24klik.com/p/zambuk-medicated-ointment-25g-1351',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF00B894);

    List<Map<String, String>> filteredMedicines = _medicines.where((medicine) {
      final query = _searchController.text.toLowerCase();
      return medicine['name']!.toLowerCase().contains(query);
    }).toList();

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
                  SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 20,
                    height: 20,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
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
            Expanded(
              child: filteredMedicines.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.72, // Adjusted to reduce overflow
                      ),
                      itemCount: filteredMedicines.length,
                      itemBuilder: (context, index) {
                        final medicine = filteredMedicines[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailObatPage(
                                  name: medicine['name']!,
                                  package: medicine['package']!,
                                  price: medicine['price']!,
                                  image: medicine['image']!,
                                  url: medicine['url']!,
                                  warning: medicine['warning'] ?? '',
                                ),
                              ),
                            );
                          },
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(40, 41, 61, 0.04),
                                      blurRadius: 1,
                                      offset: Offset(0, 0),
                                    ),
                                    BoxShadow(
                                      color: Color.fromRGBO(96, 97, 112, 0.16),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: constraints.maxHeight * 0.35,
                                      child: Center(
                                        child: Image.asset(
                                          medicine['image']!,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            medicine['name']!,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF453E3E),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            medicine['package']!,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFF888888),
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            medicine['price']!,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFFF25F24),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'Obat tidak ditemukan',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey,
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
