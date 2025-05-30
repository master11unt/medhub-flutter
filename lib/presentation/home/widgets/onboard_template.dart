import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardTemplate extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  const OnboardTemplate({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onSkip,
    required this.onNext,
  });

  @override
  State<OnboardTemplate> createState() => _OnboardTemplateState();
}

class _OnboardTemplateState extends State<OnboardTemplate> {
  bool _skipPressed = false;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF00A89E);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 0),
            Column(
              children: [
                SvgPicture.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  width: 200,
                ),
                const SizedBox(height: 22),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _skipPressed = true;
                        });
                        widget.onSkip();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: _skipPressed ? primaryColor : const Color(0xff333333),
                        side: BorderSide(color: _skipPressed ? primaryColor : const Color.fromARGB(255, 164, 163, 163), width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Lewati",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: widget.onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Lanjut",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
