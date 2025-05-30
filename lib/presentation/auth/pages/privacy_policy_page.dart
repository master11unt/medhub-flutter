import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Kebijakan Privasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea( // supaya bagian bawah aman dari notch atau bottom nav
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40), // padding bawah lebih besar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle('1. Jenis data yang kami kumpulkan'),
              const SizedBox(height: 12),
              const Text(
                'Kami mengumpulkan data pribadi seperti:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const BulletPoint('Nama lengkap, tanggal lahir, jenis kelamin'),
              const BulletPoint('Nomor telepon & alamat email'),
              const BulletPoint('Data kesehatan (riwayat medis, gejala, resep)'),
              const SizedBox(height: 24),
              
              const SectionTitle('2. Penggunaan data pribadi Anda'),
              const SizedBox(height: 12),
              const Text(
                'Data digunakan untuk:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const BulletPoint('Keperluan konsultasi medis dan catatan riwayat'),
              const BulletPoint('Pengingat jadwal pengobatan'),
              const BulletPoint('Peningkatan layanan aplikasi'),
              const BulletPoint('Notifikasi penting & promosi (opsional)'),
              const SizedBox(height: 24),
              
              const SectionTitle('3. Pengungkapan data pribadi Anda'),
              const SizedBox(height: 12),
              const Text(
                'Kami menggunakan enkripsi dan sistem keamanan berlapis untuk memastikan data pengguna tidak diakses oleh pihak tidak berwenang.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              
              const SectionTitle('4. Hak pengguna'),
              const SizedBox(height: 12),
              const BulletPoint('Melihat, mengubah, atau menghapus data pribadi'),
              const BulletPoint('Menolak penggunaan data untuk tujuan promosi'),
              const BulletPoint('Menonaktifkan akun kapan pun'),
              const SizedBox(height: 24),
              
              const SectionTitle('5. Pembaruan Kebijakan'),
              const SizedBox(height: 12),
              const Text(
                'Perubahan kebijakan akan diinformasikan melalui notifikasi aplikasi. Pengguna disarankan membaca ulang secara berkala.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6), // kasih jarak antar bullet
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
