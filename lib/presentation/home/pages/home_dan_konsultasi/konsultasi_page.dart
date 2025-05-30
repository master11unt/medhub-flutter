import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medhub/models/doctor.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/doctor_detail_page.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/dokter_rating_page.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/halaman_pdf.dart';

class ConsultationChatPage extends StatefulWidget {
  const ConsultationChatPage({super.key});

  @override
  State<ConsultationChatPage> createState() => _ConsultationChatPageState();
}

class _ConsultationChatPageState extends State<ConsultationChatPage> {
  bool mulaiChat = false;
  bool chatSelesai = true;

  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> chatMessages = [
    {'sender': 'dokter', 'type': 'text', 'text': 'Halo, selamat pagi! Ada yang bisa saya bantu hari ini?'},
    {'sender': 'user', 'type': 'text', 'text': 'Pagi dok, saya lagi batuk, pilek, dan demam sejak kemarin. Badan juga agak pegal.'},
    {'sender': 'dokter', 'type': 'text', 'text': 'Baik, itu gejala flu ringan. Sudah periksa suhu tubuh?'},
    {'sender': 'user', 'type': 'text', 'text': 'Sudah dok, 38.2 derajat.'},
    {'sender': 'dokter', 'type': 'text', 'text': 'Oke. Untuk bantu meredakan batuk, pilek, dan demamnya, Anda bisa konsumsi Paratusin.'},
    {'sender': 'user', 'type': 'text', 'text': 'Oke dok, diminumnya berapa kali sehari?'},
    {'sender': 'dokter', 'type': 'text', 'text': 'Cukup 3 kali sehari setelah makan.'},
    {'sender': 'dokter', 'type': 'file', 'fileName': 'Hasil Pemeriksaan', 'fileSize': '213 KB', 'fileUrl': 'assets/lampiran/suratdokter.pdf'},
    {'sender': 'user', 'type': 'text', 'text': 'Siap dok, terima kasih banyak 🙏'},
    {'sender': 'dokter', 'type': 'text', 'text': 'Sama - sama, Apakah ada keluhan lainnya?'},
    {'sender': 'user', 'type': 'text', 'text': 'Tidak dok'},
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        chatMessages.add({
          'sender': 'user',
          'type': 'text',
          'text': _messageController.text.trim(),
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, size: 18, color: Color(0xFF00A89E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Konsultasi',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF00A89E)),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                const CircleAvatar(radius: 22, backgroundImage: AssetImage('assets/images/dokter1rb.png')),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('dr. Rayan Ilham Nugraha',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                      SizedBox(height: 2),
                      Text('Dokter Umum', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              IconButton(
  icon: const Icon(Icons.more_horiz, color: Colors.grey),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DoctorDetailPage(
          doctor: Doctor(
            name: 'Dr. Dummy',
            imagePath: 'assets/images/dokter_dummy.png',
          ),
        ),
      ),
    );
  },
),

              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.1), width: 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/logo_ijo.png', height: 32, width: 32),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Selamat datang di MudHub',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text(
                              'Hai Aulia Rahma Putri! Jelaskan keluhan medis, dokter akan segera membalas. Kamu bisa mendapatkan rekomendasi istirahat dan obat berdasarkan diagnosis.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // 1. Tombol mulai chat (disable setelah diklik)
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mulaiChat ? Colors.grey : const Color(0xFF00A89E),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: mulaiChat ? null : () => setState(() => mulaiChat = true),
                    child: Text(
                      mulaiChat ? 'Chat Dimulai' : 'Mulai Chat',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // 2. Teks nomor antrean
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Nomor antreanmu adalah A02. Mohon menunggu atau klik di sini untuk ',
                      style: const TextStyle(fontSize: 11, color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Batal',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF00A89E),
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 16),

                // 3. Box dokter
                Container(
                  width: 289,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage('assets/images/dokter1rb.png'),
                      ),
                      const SizedBox(width: 28),
                      const Expanded(
                        child: Text(
                          'dr. Rayan Ilham Nugraha\nTelah bergabung di chat untuk membantu',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                if (mulaiChat) ...[
                  const SizedBox(height: 12),
                  for (var message in chatMessages)
                    if (message['type'] == 'file')
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => HalamanPdf(assetPath: message['fileUrl'])),
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/iconpdf.svg', height: 48, width: 48),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(message['fileName'],
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 4),
                                  Text('Pdf ${message['fileSize']}',
                                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Align(
                        alignment: message['sender'] == 'user'
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(10),
                          constraints: const BoxConstraints(maxWidth: 262),
                          decoration: BoxDecoration(
                            color: message['sender'] == 'user'
                                ? const Color(0xFF40434D)
                                : const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: Radius.circular(message['sender'] == 'user' ? 16 : 4),
                              bottomRight: Radius.circular(message['sender'] == 'user' ? 4 : 16),
                            ),
                          ),
                          child: Text(
                            message['text'],
                            style: TextStyle(
                                color: message['sender'] == 'user' ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                  if (chatSelesai) ...[
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/images/dokter1rb.png')),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('dr. Rayan Ilham Nugraha', style: TextStyle(fontWeight: FontWeight.w600)),
                                Text('Meninggalkan chat, sesi mu telah berakhir',
                                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const DoctorRatingPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A89E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Chat Selesai',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                      ),
                    ),
                  ],
                ],
              ],
            ),
          ),

          if (mulaiChat)
            SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Tulis pesan',
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Color(0xFF00A89E)),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
