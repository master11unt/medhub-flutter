import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/datasource/health_record_remote_datasource.dart';
import 'package:medhub/data/model/request/health_record_request_model.dart';

class EditMedicalInfoPage extends StatefulWidget {
  const EditMedicalInfoPage({Key? key}) : super(key: key);

  @override
  State<EditMedicalInfoPage> createState() => _EditMedicalInfoPageState();
}

class _EditMedicalInfoPageState extends State<EditMedicalInfoPage> {
  late Map<String, dynamic> initialData;
  int? recordId;
  bool isEdit = false;
  bool isLoading = false;

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
  String? existingFileUrl;

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.grey.shade300),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    if (args != null) {
      isEdit = args['isEdit'] ?? false;
      recordId = args['recordId'];
      initialData = args['initialData'] ?? {};

      // Initialize controllers
      tinggiBadanController = TextEditingController(
        text: initialData['height']?.toString() ?? '',
      );
      beratBadanController = TextEditingController(
        text: initialData['weight']?.toString() ?? '',
      );
      golonganDarahController = TextEditingController(
        text: initialData['bloodType'] ?? '',
      );
      
      // Fix tanggal lahir handling
      _selectedDate = _parseBirthDate(initialData['birthDate']);
      tanggalLahirController = TextEditingController(
        text: _selectedDate != null ? _formatDateDisplay(_selectedDate!) : '',
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
      
      // Handle existing file
      existingFileUrl = initialData['medicalDocument'];
      fileController = TextEditingController(
        text: existingFileUrl != null ? 'File sudah ada' : '',
      );
    } else {
      // Initialize empty controllers for new record
      _selectedDate = null;
      tinggiBadanController = TextEditingController();
      beratBadanController = TextEditingController();
      golonganDarahController = TextEditingController();
      tanggalLahirController = TextEditingController();
      umurController = TextEditingController();
      riwayatController = TextEditingController();
      obatController = TextEditingController();
      kondisiController = TextEditingController();
      fileController = TextEditingController();
    }
  }

  // Method baru untuk parse birth date dari berbagai format
  DateTime? _parseBirthDate(dynamic birthDateData) {
    if (birthDateData == null) return null;
    
    try {
      if (birthDateData is String) {
        if (birthDateData.isEmpty) return null;
        
        // Try parsing ISO format (YYYY-MM-DD)
        if (birthDateData.contains('-')) {
          return DateTime.parse(birthDateData.split('T').first);
        }
        
        // Try parsing display format (DD Month YYYY)
        // This is less reliable, so we'll skip it for now
        return null;
      }
      
      if (birthDateData is DateTime) {
        return birthDateData;
      }
      
      return null;
    } catch (e) {
      debugPrint('Error parsing birth date: $e');
      return null;
    }
  }

  // Method untuk format tanggal untuk display
  String _formatDateDisplay(DateTime date) {
    return "${date.day} ${_bulan(date.month)} ${date.year}";
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

  DateTime? _selectedDate;

  Future<void> pickTanggalLahir() async {
    DateTime initialDate = _selectedDate ?? DateTime.now().subtract(const Duration(days: 365 * 20));
    
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
      cancelText: 'Batal',
      confirmText: 'OK',
    );
    
    // Cek mounted setelah operasi async
    if (!mounted) return;
    
    if (picked != null) {
      debugPrint('Date picked: $picked');
      
      setState(() {
        _selectedDate = picked;
        tanggalLahirController.text = _formatDateDisplay(picked);
        
        // Auto calculate age
        final now = DateTime.now();
        int age = now.year - picked.year;
        
        if (now.month < picked.month || 
            (now.month == picked.month && now.day < picked.day)) {
          age--;
        }
        
        umurController.text = age.toString();
      });
      
      debugPrint('Updated tanggal controller: ${tanggalLahirController.text}');
      debugPrint('Updated umur controller: ${umurController.text}');
    }
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'jpg', 'jpeg', 'png'],
      );

      // Cek apakah widget masih mounted setelah operasi async
      if (!mounted) return;

      if (result != null) {
        File file = File(result.files.single.path!);
        
        // Cek ukuran file (maksimal 5MB)
        int fileSizeInBytes = file.lengthSync();
        double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
        
        if (fileSizeInMB > 5) {
          // Cek mounted lagi sebelum akses context
          if (!mounted) return;
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ukuran file terlalu besar. Maksimal 5MB'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        setState(() {
          fileRekamMedis = file;
          fileController.text = result.files.single.name;
          existingFileUrl = null; // Clear existing file URL when new file selected
        });
        
        debugPrint('File selected: ${file.path}');
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
      
      // Cek mounted sebelum akses context
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memilih file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showFileOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (existingFileUrl != null)
                  ListTile(
                    leading: const Icon(Icons.visibility),
                    title: const Text('Lihat File Saat Ini'),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Implement view existing file
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Fitur lihat file akan segera tersedia',
                          ),
                        ),
                      );
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.upload_file),
                  title: Text(
                    existingFileUrl != null ? 'Ganti File' : 'Pilih File',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pickFile();
                  },
                ),
                if (existingFileUrl != null || fileRekamMedis != null)
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: const Text(
                      'Hapus File',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        fileRekamMedis = null;
                        existingFileUrl = null;
                        fileController.text = '';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('File berhasil dihapus')),
                      );
                    },
                  ),
              ],
            ),
          ),
    );
  }

  Future<void> simpanData() async {
    if (isLoading) return;
    if (!mounted) return;

    // Validation
    if (tinggiBadanController.text.isEmpty || 
        beratBadanController.text.isEmpty ||
        golonganDarahController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tinggi badan, berat badan, dan golongan darah wajib diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final token = await AuthLocalDatasource().getToken();
      if (!mounted) return;
      
      debugPrint('=== SAVE DATA DEBUG ===');
      debugPrint('Selected date: $_selectedDate');
      debugPrint('File rekam medis: ${fileRekamMedis?.path}');
      debugPrint('Existing file URL: $existingFileUrl');
      debugPrint('Is edit: $isEdit');
      debugPrint('Record ID: $recordId');
      
      // Tentukan file yang akan dikirim
      String? fileToSend;
      if (fileRekamMedis != null) {
        fileToSend = fileRekamMedis!.path;
        debugPrint('Sending new file: $fileToSend');
      } else if (existingFileUrl != null && existingFileUrl!.isNotEmpty) {
        fileToSend = existingFileUrl;
        debugPrint('Keeping existing file: $fileToSend');
      }
      
      final requestData = HealthRecordRequestModel(
        height: int.tryParse(tinggiBadanController.text),
        weight: int.tryParse(beratBadanController.text),
        bloodType: golonganDarahController.text.trim(),
        birthDate: _selectedDate,
        age: int.tryParse(umurController.text),
        allergies: riwayatController.text.trim().isEmpty ? null : riwayatController.text.trim(),
        currentMedications: obatController.text.trim().isEmpty ? null : obatController.text.trim(),
        currentConditions: kondisiController.text.trim().isEmpty ? null : kondisiController.text.trim(),
        medicalDocument: fileToSend,
      );

      debugPrint('Request data created: ${requestData.toJson()}');

      try {
        if (isEdit && recordId != null) {
          debugPrint('🔄 Updating existing record...');
          final result = await HealthRecordRemoteDatasource().updateHealthRecord(
            recordId!,
            requestData,
            token!,
          );
          debugPrint('✅ Update successful: ${result.status}');
          
          if (!mounted) return;
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Data medis berhasil diperbarui'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          debugPrint('➕ Creating new record...');
          final result = await HealthRecordRemoteDatasource().submitHealthRecord(
            requestData,
            token!,
          );
          debugPrint('✅ Create successful: ${result.status}');
          
          if (!mounted) return;
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Data medis berhasil disimpan'),
              backgroundColor: Colors.green,
            ),
          );
        }

        // Wait a bit before navigation
        await Future.delayed(const Duration(milliseconds: 500));
        
        if (!mounted) return;
        Navigator.pop(context, true);
        
      } catch (apiError) {
        debugPrint('❌ API Error: $apiError');
        
        if (!mounted) return;
        
        String errorMessage = 'Gagal menyimpan data';
        if (apiError.toString().contains('Error parsing')) {
          errorMessage = 'Data berhasil disimpan namun ada masalah dengan response server';
          // Still consider it success and navigate back
          Navigator.pop(context, true);
          return;
        } else {
          errorMessage = 'Gagal menyimpan data: $apiError';
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      
    } catch (e) {
      debugPrint('❌ General Error: $e');
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Widget buildInput(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
    String? hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          readOnly: readOnly || onTap != null,
          onTap: onTap,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF8F8F8),
            border: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: Color(0xFF00A89E), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            hintText: hint,
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
            suffixIcon:
                onTap != null
                    ? Icon(
                      label.contains("Dokumen") || label.contains("File")
                          ? Icons.attach_file
                          : Icons.calendar_today,
                      size: 20,
                      color: const Color(0xFF00A89E),
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
          isEdit ? 'Edit Informasi Medis' : 'Tambah Informasi Medis',
          style: GoogleFonts.poppins(
            color: const Color(0xFF00A89E),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          color: const Color(0xFF00A89E),
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
                const SizedBox(height: 16),

                buildInput(
                  "Tinggi Badan (cm)*",
                  tinggiBadanController,
                  hint: "Contoh: 170",
                  keyboardType: TextInputType.number,
                ),

                buildInput(
                  "Berat Badan (kg)*",
                  beratBadanController,
                  hint: "Contoh: 65",
                  keyboardType: TextInputType.number,
                ),

                buildInput(
                  "Golongan Darah*",
                  golonganDarahController,
                  hint: "Contoh: A, B, AB, O",
                ),

                buildInput(
                  "Tanggal Lahir",
                  tanggalLahirController,
                  readOnly: true,
                  onTap: pickTanggalLahir,
                  hint: "Pilih tanggal lahir",
                ),

                buildInput(
                  "Umur (tahun)",
                  umurController,
                  hint: "Akan terisi otomatis dari tanggal lahir",
                  keyboardType: TextInputType.number,
                ),

                buildInput(
                  "Riwayat Penyakit / Alergi",
                  riwayatController,
                  maxLines: 3,
                  hint: "Tuliskan riwayat penyakit atau alergi yang dimiliki",
                ),

                buildInput(
                  "Obat yang Sedang Dikonsumsi",
                  obatController,
                  maxLines: 3,
                  hint: "Tuliskan obat yang sedang dikonsumsi",
                ),

                buildInput(
                  "Kondisi Kesehatan Saat Ini",
                  kondisiController,
                  maxLines: 2,
                  hint: "Kondisi kesehatan terkini",
                ),

                // File picker with better UI
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dokumen Medis / Rekam Medis",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 48,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(height: 8),

                          if (fileRekamMedis != null)
                            Text(
                              'File baru: ${fileController.text}',
                              style: GoogleFonts.poppins(
                                color: Colors.green[700],
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            )
                          else if (existingFileUrl != null)
                            Text(
                              'File tersedia',
                              style: GoogleFonts.poppins(
                                color: Colors.blue[700],
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          else
                            Text(
                              'Belum ada file',
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                              ),
                            ),

                          const SizedBox(height: 12),

                          ElevatedButton.icon(
                            onPressed: showFileOptions,
                            icon: Icon(
                              existingFileUrl != null || fileRekamMedis != null
                                  ? Icons.edit
                                  : Icons.upload_file,
                            ),
                            label: Text(
                              existingFileUrl != null || fileRekamMedis != null
                                  ? 'Kelola File'
                                  : 'Pilih File',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00A89E),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),
                          Text(
                            'Format yang didukung: PDF, DOC, DOCX, JPG, PNG',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),

                // Save button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : simpanData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A89E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child:
                        isLoading
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                            : Text(
                              isEdit ? "Perbarui Data" : "Simpan Data",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers
    tinggiBadanController.dispose();
    beratBadanController.dispose();
    golonganDarahController.dispose();
    tanggalLahirController.dispose();
    umurController.dispose();
    riwayatController.dispose();
    obatController.dispose();
    kondisiController.dispose();
    fileController.dispose();
    
    super.dispose();
  }
}
