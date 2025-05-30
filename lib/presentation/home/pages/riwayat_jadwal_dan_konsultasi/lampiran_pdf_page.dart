import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:google_fonts/google_fonts.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({super.key});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  bool _isLoading = true;
  bool _isError = false;

  final Color primaryColor = const Color(0xFF00A89E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
          color: primaryColor,
        ),
        title: Text(
          "Hasil Pemeriksaan",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: primaryColor,
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          SfPdfViewer.asset(
            'lampiran/test.pdf',
            onDocumentLoadFailed: (details) {
              setState(() {
                _isError = true;
                _isLoading = false;
              });
            },
            onDocumentLoaded: (details) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
          if (_isError)
            Center(
              child: Text(
                'Gagal memuat dokumen.',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
              ),
            ),
        ],
      ),
    );
  }
}
