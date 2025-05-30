import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // ✅ Tambahan penting
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

class HalamanPdf extends StatefulWidget {
  final String assetPath;
  const HalamanPdf({Key? key, required this.assetPath}) : super(key: key);

  @override
  _HalamanPdfState createState() => _HalamanPdfState();
}

class _HalamanPdfState extends State<HalamanPdf> {
  String? localFilePath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    preparePdf();
  }

  Future<void> preparePdf() async {
    final byteData = await rootBundle.load(widget.assetPath);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/temp.pdf');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    setState(() {
      localFilePath = file.path;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, size: 18, color: Color(0xFF00A89E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Lihat PDF',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF00A89E),
          ),
        ),
        centerTitle: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: localFilePath!,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageSnap: true,
              pageFling: true,
              onRender: (_pages) => setState(() {}),
              onError: (error) => print(error.toString()),
              onPageError: (page, error) =>
                  print('$page: ${error.toString()}'),
            ),
    );
  }
}
