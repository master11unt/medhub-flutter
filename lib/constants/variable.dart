class Variable {
  static const String baseUrl = "http://172.16.4.200:8000"; 
  
  static String imageBaseUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return '$baseUrl/$cleanPath';
  }
  
  // Tambahkan method untuk API endpoints
  static String apiUrl(String endpoint) {
    if (endpoint.startsWith('/')) {
      endpoint = endpoint.substring(1);
    }
    return '$baseUrl/api/$endpoint';
  }
}