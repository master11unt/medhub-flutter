class Variable {
  static const String baseUrl = "http://192.168.109.97:8000";

  // bikin end point untuk gambar
  static String imageBaseUrl(String? path) {
    // ngecek kalau path nya null atau kosong, return string kosong
    if (path == null || path.isEmpty) return '';
    // di cek apakah path di awali dengan / atau tidak
    //  kalau ada / nya, maka dipotong pakai substring(1) -> artinya ambil dari index 1 atau mulai karakter1
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return '$baseUrl/$cleanPath';
  }
} 