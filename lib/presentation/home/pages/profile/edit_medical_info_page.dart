import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:google_fonts/google_fonts.dart';

class EditMedicalInfoPage extends StatefulWidget {
  const EditMedicalInfoPage({Key? key}) : super(key: key);

  @override
  State<EditMedicalInfoPage> createState() => _EditMedicalInfoPageState();
}

class _EditMedicalInfoPageState extends State<EditMedicalInfoPage> {
  late Map<String, dynamic> initialData;

  late TextEditingController tinggiBadanController;
  late TextEditingController beratBadanController;
  late TextEditingController golonganDarahController;
  late TextEditingController tanggalLahirController;
  late TextEditingController umurController;
  late TextEditingController riwayatController;
  late TextEditingController obatController;
  late TextEditingController kondisiController;
  late TextEditingController fileController;

  File? fileRekamMedis;

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.grey.shade300),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['initialData'] != null) {
      initialData = args['initialData'];

      tinggiBadanController = TextEditingController(
        text: initialData['height']?.toString() ?? '',
      );
      beratBadanController = TextEditingController(
        text: initialData['weight']?.toString() ?? '',
      );
      golonganDarahController = TextEditingController(
        text: initialData['bloodType'] ?? '',
      );
      tanggalLahirController = TextEditingController(
        text: initialData['birthDate'] ?? '',
      );
      umurController = TextEditingController(
        text: initialData['age']?.toString() ?? '',
      );
      riwayatController = TextEditingController(
        text: initialData['allergies'] ?? '',
      );
      obatController = TextEditingController(
        text: initialData['currentMedications'] ?? '',
      );
      kondisiController = TextEditingController(
        text: initialData['currentConditions'] ?? '',
      );
      fileController = TextEditingController(
        text: initialData['medicalDocument'] ?? '',
      );
    }
  }

  String _bulan(int month) {
    const bulan = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];
    return bulan[month - 1];
  }

  Future<void> pickTanggalLahir() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        tanggalLahirController.text =
            "\${picked.day} \${_bulan(picked.month)} \${picked.year}";
      });
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        fileRekamMedis = File(result.files.single.path!);
        fileController.text = result.files.single.name;
      });
    }
  }

  void simpanData() {
    print("Data disimpan:");
    print("Tinggi: \${tinggiBadanController.text}");
    print("Berat: \${beratBadanController.text}");
    print("Golongan Darah: \${golonganDarahController.text}");
    print("Tanggal Lahir: \${tanggalLahirController.text}");
    print("Umur: \${umurController.text}");
    print("Riwayat: \${riwayatController.text}");
    print("Obat: \${obatController.text}");
    print("Kondisi: \${kondisiController.text}");
    print("File: \${fileRekamMedis?.path ?? 'Tidak ada'}");

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Data berhasil disimpan")));

    Navigator.pop(context, true);
  }

  Widget buildInput(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          // readOnly: readOnly || onTap != null,
          onTap: onTap,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF8F8F8),
            border: border,
            enabledBorder: border,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon:
                onTap != null
                    ? Icon(
                      label == "Dokumen Medis / Rekam Medis"
                          ? Icons.attach_file
                          : Icons.calendar_today,
                      size: 20,
                    )
                    : null,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Edit Informasi Medis',
          style: GoogleFonts.poppins(
            color: Color(0xFF00A89E),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          color: Color(0xFF00A89E),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildInput("Tinggi Badan", tinggiBadanController),
                buildInput("Berat Badan", beratBadanController),
                buildInput("Golongan Darah", golonganDarahController),
                buildInput(
                  "Tanggal Lahir",
                  tanggalLahirController,
                  // readOnly: true,
                  onTap: pickTanggalLahir,
                ),
                buildInput("Umur", umurController),
                buildInput(
                  "Riwayat Penyakit / Alergi",
                  riwayatController,
                  maxLines: 2,
                ),
                buildInput(
                  "Obat yang Sedang Dikonsumsi",
                  obatController,
                  maxLines: 2,
                ),
                buildInput("Kondisi Kesehatan Saat Ini", kondisiController),
                buildInput(
                  "Dokumen Medis / Rekam Medis",
                  fileController,
                  // readOnly: true, 
                  onTap: pickFile,
                ),
                ElevatedButton(
                  onPressed: simpanData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A89E),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Simpan", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
