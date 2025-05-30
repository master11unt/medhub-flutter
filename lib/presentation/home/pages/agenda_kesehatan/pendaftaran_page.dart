import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medhub/models/health_service.dart';
import 'data_pendaftar_page.dart';

class PendaftaranPage extends StatefulWidget {
  final HealthService service;

  const PendaftaranPage({super.key, required this.service});

  @override
  State<PendaftaranPage> createState() => _PendaftaranPageState();
}

class _PendaftaranPageState extends State<PendaftaranPage> {
  final Color primaryColor = const Color(0xFF00A89E);
  bool hasMedicalHistory = false;
  bool agreedToTerms = false;
  String selectedGender = 'Perempuan';

  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final nikController = TextEditingController();
  final historyController = TextEditingController();

  Widget buildLabeledTextField(String label, TextEditingController controller) {
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
              hintText: label,
              hintStyle: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF757575)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.15), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.15), width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGenderOption(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: label,
          groupValue: selectedGender,
          onChanged: (val) => setState(() => selectedGender = val!),
          activeColor: primaryColor,
        ),
        GestureDetector(
          onTap: () => setState(() => selectedGender = label),
          child: Text(label, style: GoogleFonts.poppins(fontSize: 14)),
        ),
      ],
    );
  }

  Widget buildYesNoOption(String label, bool value, VoidCallback onTap) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<bool>(
          value: value,
          groupValue: hasMedicalHistory,
          onChanged: (_) => onTap(),
          activeColor: primaryColor,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(label, style: GoogleFonts.poppins(fontSize: 14)),
        ),
      ],
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
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
      ),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF00C8AE), size: 80),
              const SizedBox(height: 24),
              const Text('Pendaftaran Berhasil!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C8AE),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DataPendaftarPage(
                          service: widget.service, // <--- ini penting!
                          showSimpanButton: true,
                        ),
                      ),
                    );
                  },
                  child: const Text('Lihat Rincian Pendaftaran',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleSubmit() async {
    if (!agreedToTerms ||
        nameController.text.isEmpty ||
        dobController.text.isEmpty ||
        addressController.text.isEmpty ||
        phoneController.text.isEmpty ||
        nikController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mohon lengkapi semua data dan centang persetujuan")),
      );
      return;
    }

    showLoadingDialog(context);
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
    showSuccessDialog(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    addressController.dispose();
    phoneController.dispose();
    nikController.dispose();
    historyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pendaftaran',
            style: GoogleFonts.poppins(color: primaryColor, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF00A99D), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabeledTextField('Nama Lengkap', nameController),
              const SizedBox(height: 20),
              buildLabeledTextField('Tanggal Lahir', dobController),
              const SizedBox(height: 20),
              Text('Jenis Kelamin', style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 14, color: primaryColor)),
              Row(
                children: [
                  buildGenderOption('Laki-Laki'),
                  const SizedBox(width: 16),
                  buildGenderOption('Perempuan'),
                ],
              ),
              const SizedBox(height: 20),
              buildLabeledTextField('Alamat', addressController),
              const SizedBox(height: 20),
              buildLabeledTextField('No. Telepon', phoneController),
              const SizedBox(height: 20),
              buildLabeledTextField('NIK', nikController),
              const SizedBox(height: 20),
              buildLabeledTextField('Riwayat Alergi/Penyakit', historyController),
              const SizedBox(height: 20),
              Text(
                'Apakah memiliki riwayat penyakit tertentu?',
                style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF074A58), fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  buildYesNoOption('Ya', true, () => setState(() => hasMedicalHistory = true)),
                  const SizedBox(width: 20),
                  buildYesNoOption('Tidak', false, () => setState(() => hasMedicalHistory = false)),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Saya menyetujui data saya digunakan untuk keperluan pendaftaran dan layanan kesehatan",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14, color: const Color(0xFF074A58)),
              ),
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: agreedToTerms,
                    onChanged: (val) => setState(() => agreedToTerms = true),
                    activeColor: primaryColor,
                  ),
                  GestureDetector(
                    onTap: () => setState(() => agreedToTerms = true),
                    child: Text("Ya, Saya setuju",
                        style: GoogleFonts.poppins(fontSize: 14, color: const Color.fromARGB(255, 0, 0, 0))),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: agreedToTerms ? primaryColor : const Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: agreedToTerms ? handleSubmit : null,
                  child: Text('Daftar',
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
