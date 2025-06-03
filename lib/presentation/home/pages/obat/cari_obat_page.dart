import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;
  final VoidCallback? onTap;
  final String? hintText;

  const SearchInput({
    super.key,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextFormField(
        onTap: onTap,
        readOnly: onTap != null,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText ?? 'Cari di sini',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.all(16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFF00B894)),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}