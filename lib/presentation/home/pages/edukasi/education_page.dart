import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:medhub/data/datasource/education_remote_datasource.dart';
import 'package:medhub/presentation/home/bloc/edukasi/edukasi_bloc.dart';
import 'artikel_page.dart';
import 'video_page.dart';
import 'search_edukasi_page.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final Color primaryColor = const Color(0xFF00A89E);
  late final EdukasiRemoteDataSource dataSource;
  late final EdukasiBloc edukasiBloc;

  @override
  void initState() {
    super.initState();
    // Create data source and bloc once, not on every build
    dataSource = EdukasiRemoteDataSource(client: http.Client());
    edukasiBloc = EdukasiBloc(dataSource);

    // Only fetch initially for the first tab
    if (_selectedIndex == 0) {
      edukasiBloc.add(const EdukasiEvent.fetch());
    }
  }

  @override
  void dispose() {
    edukasiBloc.close(); 
    _searchController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: edukasiBloc, 
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            color: primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
          title: Text(
            'Edukasi Pengendara',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // Search Bar
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SearchEdukasiPage(),
                      ),
                    );
                  },
                  child: Container(
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
                          child: AbsorbPointer(
                            child: TextField(
                              controller: _searchController,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                              ),
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
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onTabChanged(0),
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:
                                _selectedIndex == 0
                                    ? primaryColor
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: primaryColor, width: 1.5),
                          ),
                          child: Text(
                            'Artikel',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:
                                  _selectedIndex == 0
                                      ? Colors.white
                                      : primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onTabChanged(1),
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:
                                _selectedIndex == 1
                                    ? primaryColor
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: primaryColor, width: 1.5),
                          ),
                          child: Text(
                            'Video',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:
                                  _selectedIndex == 1
                                      ? Colors.white
                                      : primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Expanded(
                  child:
                      _selectedIndex == 0
                          ? const ArtikelPage(selectedKategori: '')
                          : const VideoPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}