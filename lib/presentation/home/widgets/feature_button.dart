import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeatureButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final double? iconWidth;
  final double? iconHeight;

  const FeatureButton({
    super.key,
    required this.label,
    required this.iconPath,
    this.iconWidth,
    this.iconHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72, // Tetap 72, jangan terlalu besar biar muat
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE2D7),
              shape: BoxShape.rectangle,
              border: Border.all(color: const Color.fromARGB(255, 247, 189, 168)),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: iconWidth ?? 36, // sedikit dikecilin biar proporsional
                height: iconHeight ?? 36,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis, // Biar ga ada titik-titik, font kecil
            style: const TextStyle(
              fontSize: 10, // KECILIN FONT SIZE, biar teks muat
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
