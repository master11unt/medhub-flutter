import 'package:flutter/material.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/cari_dokter_page.dart';

class GreetingHeader extends StatelessWidget {
  final String userName;
  // final Widget? profileImageWidget;
  final String? userImageUrl;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onSearchTap;

  const GreetingHeader({
    super.key,
    required this.userName,
    this.userImageUrl,
    // this.profileImageWidget,
    this.onNotificationPressed,
    this.onSearchTap,
  });

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 11) return 'Selamat Pagi';
    if (hour >= 11 && hour < 15) return 'Selamat Siang';
    if (hour >= 15 && hour < 18) return 'Selamat Sore';
    return 'Selamat Malam';
  }

  @override
  Widget build(BuildContext context) {
    final greeting = _getGreeting();
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF00A99D),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(16, topPadding + 16, 16, 20),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child:
                    userImageUrl != null && userImageUrl!.isNotEmpty
                        ? CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(userImageUrl!),
                        )
                        : const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greeting,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: onNotificationPressed ?? () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CariDokterPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    'Cari dokter, artikel...',
                    style: TextStyle(color: Colors.grey),
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
