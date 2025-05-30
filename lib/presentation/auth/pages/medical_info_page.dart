import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/main_page.dart';
import 'package:medhub/presentation/auth/bloc/medical_info/medical_info_bloc.dart';

class MedicalInfoPage extends StatefulWidget {
  final bool isEdit;
  final int? recordId;
  final Map<String, dynamic>? initialData;

  MedicalInfoPage({
    super.key,
    this.isEdit = false,
    this.recordId,
    this.initialData,
  });

  static const Color primaryColor = Color(0xFF00A89E);

  @override
  State<MedicalInfoPage> createState() => _MedicalInfoPageState();
}

class _MedicalInfoPageState extends State<MedicalInfoPage> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _bloodTypeController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _ageController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _medicationsController = TextEditingController();
  final _conditionsController = TextEditingController();
  final _medicalDocumentController = TextEditingController();

  String? _medicalFileName;
  Uint8List? _medicalFileBytes;

  @override
  void initState() {
    super.initState();
    // Jika edit, isi controller dengan data awal
    if (widget.isEdit && widget.initialData != null) {
      _heightController.text = widget.initialData?['height']?.toString() ?? '';
      _weightController.text = widget.initialData?['weight']?.toString() ?? '';
      _bloodTypeController.text = widget.initialData?['bloodType'] ?? '';
      _birthDateController.text = widget.initialData?['birthDate'] ?? '';
      _ageController.text = widget.initialData?['age']?.toString() ?? '';
      _allergiesController.text = widget.initialData?['allergies'] ?? '';
      _medicationsController.text =
          widget.initialData?['currentMedications'] ?? '';
      _conditionsController.text =
          widget.initialData?['currentConditions'] ?? '';
      _medicalDocumentController.text =
          widget.initialData?['medicalDocument'] ?? '';
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _bloodTypeController.dispose();
    _birthDateController.dispose();
    _ageController.dispose();
    _allergiesController.dispose();
    _medicationsController.dispose();
    _conditionsController.dispose();
    _medicalDocumentController.dispose();
    super.dispose();
  }

  Widget buildLabeledInputField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 46,
          child: TextField(
            controller: controller,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
            cursorColor: Colors.grey.shade400,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF757575),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 11,
              ),
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.15),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.15),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDatePickerField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 46,
          child: TextField(
            controller: controller,
            readOnly: true,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Pilih Tanggal Lahir',
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF757575),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 11,
              ),
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.15),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.15),
                  width: 1,
                ),
              ),
              suffixIcon: const Icon(Icons.calendar_today, size: 20),
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now().subtract(
                  const Duration(days: 365 * 18),
                ),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                controller.text = picked.toIso8601String().split('T').first;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildFilePickerField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final result = await FilePicker.platform.pickFiles(
              type: FileType.any,
              withData: true,
            );
            if (result != null && result.files.isNotEmpty) {
              setState(() {
                _medicalFileName = result.files.first.name;
                _medicalFileBytes = result.files.first.bytes;
                _medicalDocumentController.text = _medicalFileName ?? '';
              });
            }
          },
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black.withOpacity(0.15),
                width: 1,
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _medicalFileName ?? 'Pilih file dokumen medis',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color:
                          _medicalFileName == null
                              ? const Color(0xFF757575)
                              : Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.attach_file, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(
              child: Container(
                width: 300,
                height: 210,
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
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF00C8AE),
                      ),
                      backgroundColor: Color(0xFFB2F1EC),
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }

  void showSuccessDialog(BuildContext context, {bool isEdit = false}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFF00C8AE),
                    child: Icon(
                      Icons.save_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    isEdit ? 'Berhasil diupdate!' : 'Berhasil disimpan!',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MedicalInfoPage.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Navigator.of(context).pushReplacementNamed('/main');
                        });
                      },
                      child: const Text(
                        'Lanjut ke Beranda',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Gagal'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

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
          onPressed: () => Navigator.of(context).pop(),
          color: MedicalInfoPage.primaryColor,
        ),
        title: Text(
          'Informasi Medis',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: MedicalInfoPage.primaryColor,
            fontSize: 16,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocListener<MedicalInfoBloc, MedicalInfoState>(
        listener: (context, state) {
          if (state is MedicalInfoLoading) {
            showLoadingDialog(context);
          } else if (state is MedicalInfoSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            showSuccessDialog(context, isEdit: widget.isEdit);
          } else if (state is MedicalInfoError) {
            Navigator.of(context, rootNavigator: true).pop(); // tutup loading
            showErrorDialog(context, state.message);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildLabeledInputField(
                    'Tinggi Badan',
                    'Tinggi Badan',
                    _heightController,
                  ),
                  const SizedBox(height: 16),
                  buildLabeledInputField(
                    'Berat Badan',
                    'Berat Badan',
                    _weightController,
                  ),
                  const SizedBox(height: 16),
                  buildLabeledInputField(
                    'Golongan Darah',
                    'Golongan Darah',
                    _bloodTypeController,
                  ),
                  const SizedBox(height: 16),
                  buildDatePickerField('Tanggal Lahir', _birthDateController),
                  const SizedBox(height: 16),
                  buildLabeledInputField('Umur', 'Umur', _ageController),
                  const SizedBox(height: 16),
                  buildLabeledInputField(
                    'Riwayat Penyakit / Alergi',
                    'Riwayat Penyakit / Alergi',
                    _allergiesController,
                  ),
                  const SizedBox(height: 16),
                  buildLabeledInputField(
                    'Obat yang sedang dikonsumsi',
                    'Obat yang sedang dikonsumsi',
                    _medicationsController,
                  ),
                  const SizedBox(height: 16),
                  buildLabeledInputField(
                    'Kondisi Kesehatan Saat Ini',
                    'Kondisi Kesehatan Saat Ini',
                    _conditionsController,
                  ),
                  const SizedBox(height: 16),
                  buildFilePickerField('Dokumen Medis / Rekam Medis'),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00A89E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        // Validasi sederhana
                        if (_heightController.text.isEmpty ||
                            _weightController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Tinggi dan berat badan wajib diisi",
                              ),
                            ),
                          );
                          return;
                        }

                        // Ambil token sebelum submit
                        final token = await AuthLocalDatasource().getToken();
                        print('Token: $token');

                        if (token.isEmpty) {
                          showErrorDialog(
                            context,
                            "Anda belum login. Silakan login ulang.",
                          );
                          return;
                        }

                        final birthDate = DateTime.tryParse(
                          _birthDateController.text,
                        );

                        if (widget.isEdit && widget.recordId != null) {
                          context.read<MedicalInfoBloc>().add(
                            MedicalInfoEvent.edit(
                              id: widget.recordId!,
                              height: int.tryParse(_heightController.text),
                              weight: int.tryParse(_weightController.text),
                              bloodType: _bloodTypeController.text,
                              birthDate: birthDate, // <-- sudah DateTime?
                              age: int.tryParse(_ageController.text),
                              allergies: _allergiesController.text,
                              currentMedications: _medicationsController.text,
                              currentConditions: _conditionsController.text,
                              medicalDocument: _medicalDocumentController.text,
                            ),
                          );
                        } else {
                          context.read<MedicalInfoBloc>().add(
                            MedicalInfoEvent.submit(
                              height: int.tryParse(_heightController.text),
                              weight: int.tryParse(_weightController.text),
                              bloodType: _bloodTypeController.text,
                              birthDate: birthDate, // <-- sudah DateTime?
                              age: int.tryParse(_ageController.text),
                              allergies: _allergiesController.text,
                              currentMedications: _medicationsController.text,
                              currentConditions: _conditionsController.text,
                              medicalDocument: _medicalDocumentController.text,
                            ),
                          );
                        }
                      },
                      child: Text(
                        widget.isEdit ? 'Update' : 'Simpan',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
