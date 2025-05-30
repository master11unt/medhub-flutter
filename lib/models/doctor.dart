class Doctor {
  final String name;
  final String imagePath;
  final bool inConsultation; // tambahkan ini

  Doctor({
    required this.name,
    required this.imagePath,
    this.inConsultation = false,
  });
}
