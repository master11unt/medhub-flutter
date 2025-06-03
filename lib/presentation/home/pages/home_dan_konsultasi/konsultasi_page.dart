import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medhub/data/datasource/doctor_remote_datasource.dart';
import 'package:medhub/data/model/response/doctor_response_model.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/doctor_detail_page.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/dokter_rating_page.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/halaman_pdf.dart';

class ConsultationChatPage extends StatefulWidget {
  final int doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String? doctorImage;

  const ConsultationChatPage({
    super.key, 
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    this.doctorImage,
  });

  @override
  State<ConsultationChatPage> createState() => _ConsultationChatPageState();
}

class _ConsultationChatPageState extends State<ConsultationChatPage> {
  bool mulaiChat = false;
  bool chatSelesai = true;
  Doctor? _doctorDetail;
  bool _isLoadingDoctor = false;

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

  @override
  void initState() {
    super.initState();
    _fetchDoctorDetail();
  }

  Future<void> _fetchDoctorDetail() async {
    if (mounted) {
      setState(() {
        _isLoadingDoctor = true;
      });
    }

    try {
      // Fetch doctor detail using DoctorRemoteDatasource
      final datasource = DoctorRemoteDatasource();
      final result = await datasource.getDoctorDetail(widget.doctorId);
      
      if (mounted) {
        setState(() {
          _isLoadingDoctor = false;
          result.fold(
            (error) {
              // Handle error, but still keep the basic info we have
              debugPrint('Error fetching doctor detail: $error');
            },
            (doctor) {
              _doctorDetail = doctor;
            },
          );
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingDoctor = false;
        });
      }
      debugPrint('Exception fetching doctor detail: $e');
    }
  }

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

  void _navigateToDoctorDetail() {
    if (_doctorDetail != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DoctorDetailPage(
            doctor: _doctorDetail!,
          ),
        ),
      );
    } else {
      // If we don't have full doctor detail, create a minimal Doctor object with the info we have
      final doctor = Doctor(
        id: widget.doctorId,
        user: User(
          name: widget.doctorName,
          image: widget.doctorImage,
        ),
        specialization: widget.doctorSpecialty,
      );
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DoctorDetailPage(
            doctor: doctor,
            fromSearch: true, // This will trigger fetching full details in the detail page
          ),
        ),
      );
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
                CircleAvatar(
                  radius: 22, 
                  backgroundImage: widget.doctorImage != null
                    ? NetworkImage(widget.doctorImage!)
                    : const AssetImage('assets/images/dokter1.png') as ImageProvider,
                  onBackgroundImageError: (_, __) {
                    // Fallback to default image if network image fails to load
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctorName,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.doctorSpecialty,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: Colors.grey),
                  onPressed: _navigateToDoctorDetail,
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
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: widget.doctorImage != null
                          ? NetworkImage(widget.doctorImage!)
                          : const AssetImage('assets/images/dokter1.png') as ImageProvider,
                        onBackgroundImageError: (_, __) {
                          // Fallback handled by constructor
                        },
                      ),
                      const SizedBox(width: 28),
                      Expanded(
                        child: Text(
                          '${widget.doctorName}\nTelah bergabung di chat untuk membantu',
                          style: const TextStyle(
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
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: widget.doctorImage != null
                              ? NetworkImage(widget.doctorImage!)
                              : const AssetImage('assets/images/dokter1.png') as ImageProvider,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.doctorName, 
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Text(
                                  'Meninggalkan chat, sesi mu telah berakhir',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => DoctorRatingPage(
                          //       doctorId: widget.doctorId,
                          //       doctorName: widget.doctorName,
                          //       doctorImage: widget.doctorImage,
                          //     ),
                          //   ),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A89E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          'Chat Selesai',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                        ),
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