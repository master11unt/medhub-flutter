import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/model/response/education_category.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/model/response/edukasi_response_model.dart';

class EdukasiRemoteDataSource {
  final http.Client client;

  EdukasiRemoteDataSource({required this.client});

  Future<List<Edukasi>> getEdukasiList(String? kategori) async {
    try {
      final uri = Uri.parse('${Variable.baseUrl}/api/edukasi');
      debugPrint("Fetching from: $uri");

      final response = await client.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['data'] != null &&
            jsonData['data'] is List &&
            (jsonData['data'] as List).isNotEmpty) {
          final sampleItem = (jsonData['data'] as List)[0];
          debugPrint(
            "Sample item thumbnail: ${sampleItem['thumbnail'] ?? 'No thumbnail field'}",
          );
        }

        if (jsonData['data'] != null && jsonData['data'] is List) {
          final List<Edukasi> result =
              (jsonData['data'] as List)
                  .map((item) => Edukasi.fromMap(item))
                  .toList();

          debugPrint(" Parsed ${result.length} edukasi items from backend");
          return result;
        }
      }

      throw Exception(
        'Failed to load education data from backend: ${response.statusCode}',
      );
    } catch (e) {
      debugPrint(" Error fetching edukasi: $e");
      throw Exception('Error fetching education data: $e');
    }
  }

  Future<Edukasi?> getEdukasiDetail(String id) async {
    try {
      final response = await client.get(
        Uri.parse('${Variable.baseUrl}/api/artikel/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final edukasiResponModel = EdukasiResponModel.fromMap(jsonData);

        if (edukasiResponModel.success == true &&
            edukasiResponModel.data != null &&
            edukasiResponModel.data!.isNotEmpty) {
          return edukasiResponModel.data!.first;
        }
      }
      return null;
    } catch (e) {
      debugPrint("Error dalam getEdukasiDetail: $e");
      return null;
    }
  }

  Future<List<Edukasi>> searchEdukasi(String query) async {
    try {
      final response = await client.get(
        Uri.parse('${Variable.baseUrl}/api/artikel/search?q=$query'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final edukasiResponModel = EdukasiResponModel.fromMap(jsonData);

        if (edukasiResponModel.success == true &&
            edukasiResponModel.data != null) {
          return edukasiResponModel.data!;
        }
      }
      return [];
    } catch (e) {
      debugPrint("Error dalam searchEdukasi: $e");
      return [];
    }
  }

  Future<List<Edukasi>> getVideoList() async {
    try {
      final uri = Uri.parse('${Variable.baseUrl}/api/edukasi');
      debugPrint("Fetching videos from: $uri");

      final response = await client.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      debugPrint("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        debugPrint("Response body: ${response.body}");

        if (jsonData.containsKey('data') && jsonData['data'] is List) {
          final List<dynamic> allEducationData = jsonData['data'];

          final List<Edukasi> videos =
              allEducationData
                  .map((item) => Edukasi.fromMap(item))
                  .where(
                    (edu) =>
                        edu.type == 'video' ||
                        (edu.videoUrl != null && edu.videoUrl!.isNotEmpty),
                  )
                  .toList();

          debugPrint(
            "Found ${videos.length} videos from ${allEducationData.length} items",
          );
          return videos;
        } else {
          debugPrint(
            "Response format invalid: ${response.body.substring(0, 100)}...",
          );
          return [];
        }
      } else {
        // Try alternative endpoint if first one fails
        final alternativeUri = Uri.parse('${Variable.baseUrl}/edukasi');
        debugPrint("First endpoint failed, trying: $alternativeUri");

        final alternativeResponse = await client.get(
          alternativeUri,
          headers: {'Content-Type': 'application/json'},
        );

        if (alternativeResponse.statusCode == 200) {
          final Map<String, dynamic> jsonData = jsonDecode(
            alternativeResponse.body,
          );

          if (jsonData.containsKey('data') && jsonData['data'] is List) {
            final List<dynamic> allData = jsonData['data'];
            final List<Edukasi> videos =
                allData
                    .map((item) => Edukasi.fromMap(item))
                    .where(
                      (edu) =>
                          edu.type == 'video' ||
                          (edu.videoUrl != null && edu.videoUrl!.isNotEmpty),
                    )
                    .toList();
          }
        }

        throw Exception('Gagal mengambil data video: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error dalam getVideoList: $e");
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<void> debugImageUrls() async {
    try {
      final items = await getEdukasiList(null);
      debugPrint('---------- IMAGE URL DEBUGGING ----------');
      debugPrint('Found ${items.length} education items');

      for (var item in items.take(5)) {
        debugPrint('------------------------------------');
        debugPrint('Item: ${item.title}');
        debugPrint('Thumbnail: ${item.thumbnail}');

        if (item.thumbnail != null && item.thumbnail!.isNotEmpty) {
          if (item.thumbnail!.startsWith('/')) {
            debugPrint(
              'Full URL would be: ${Variable.baseUrl}${item.thumbnail}',
            );
          } else if (!item.thumbnail!.contains('://')) {
            debugPrint(
              'Full URL would be: ${Variable.baseUrl}/${item.thumbnail}',
            );
          } else {
            debugPrint('URL is already absolute');
          }
        } else {
          debugPrint('No thumbnail for this item');
        }
      }
      debugPrint('---------- END DEBUGGING ----------');
    } catch (e) {
      debugPrint('Error debugging images: $e');
    }
  }

  Future<void> debugFullApiResponse() async {
    try {
      final uri = Uri.parse('${Variable.baseUrl}/api/edukasi');
      debugPrint(" Testing API endpoint: $uri");

      final response = await client.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        debugPrint(" API returned 200 OK");
        debugPrint(" Response body length: ${response.body.length}");

        final preview =
            response.body.length > 300
                ? response.body.substring(0, 300) + "..."
                : response.body;
        debugPrint(" Response preview: $preview");

        final jsonData = json.decode(response.body);

        if (jsonData['data'] != null && jsonData['data'] is List) {
          final items = jsonData['data'] as List;

          if (items.isNotEmpty) {
            final firstItem = items[0];
            debugPrint(" First item: ${json.encode(firstItem)}");

            if (firstItem['thumbnail'] != null) {
              final thumbnail = firstItem['thumbnail'];
              debugPrint(" First item thumbnail: $thumbnail");
              debugPrint(
                " Full URL would be: ${Variable.imageBaseUrl(thumbnail)}",
              );
            } else {
              debugPrint(" First item has no thumbnail field!");
            }

            if (firstItem['category'] != null) {
              final category = firstItem['category'];
              debugPrint(" Category: ${json.encode(category)}");

              if (category['icon'] != null) {
                final icon = category['icon'];
                debugPrint(" Category icon: $icon");
                debugPrint(" Full icon URL: ${Variable.imageBaseUrl(icon)}");
              } else {
                debugPrint(" Category has no icon field!");
              }
            }
          }
        }
      } else {
        debugPrint(" API returned error: ${response.statusCode}");
        debugPrint(" Error body: ${response.body}");
      }
    } catch (e) {
      debugPrint(" Exception testing API: $e");
    }
  }

  Future<void> debugCategoryIcons() async {
    try {
      final uri = Uri.parse('${Variable.baseUrl}/api/categories');
      debugPrint(" Memeriksa kategori dari API: $uri");

      final response = await client.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['data'] != null && jsonData['data'] is List) {
          final categories = jsonData['data'] as List;

          debugPrint("Ditemukan ${categories.length} kategori");

          for (var category in categories) {
            final name = category['name'] ?? 'Tanpa nama';
            final icon = category['icon'] ?? 'Tidak ada icon';

            debugPrint("Kategori: $name");
            debugPrint("Path icon: $icon");

            if (icon != null &&
                icon.toString().isNotEmpty &&
                icon != 'Tidak ada icon') {
              final fullUrl = Variable.imageBaseUrl(icon.toString());
              debugPrint(" URL lengkap: $fullUrl");
            }
          }
        } else {
          debugPrint(" Format JSON tidak sesuai");
        }
      } else {
        debugPrint("API error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint(" Error debug kategori: $e");
    }
  }

  Future<List<EduCategory>> getEducationCategories() async {
    try {
      // Get token from local storage
      final authLocalDatasource = AuthLocalDatasource();
      final token = await authLocalDatasource.getToken();

      final uri = Uri.parse('${Variable.baseUrl}/api/api-categories');
      debugPrint("Fetching education categories from: $uri");

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint("Categories response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('data') && jsonData['data'] is List) {
          final edukasiCategoryResponse = EdukasiCategoryResponse.fromMap(
            jsonData,
          );

          if (edukasiCategoryResponse.data != null) {
            debugPrint(
              "Found ${edukasiCategoryResponse.data!.length} education categories",
            );
            return edukasiCategoryResponse.data!;
          }
        } else {
          debugPrint(
            "Response format invalid: ${response.body.substring(0, min(100, response.body.length))}...",
          );
        }
      } else {
        // Try alternative endpoint if first one fails
        final alternativeUri = Uri.parse('${Variable.baseUrl}/api/categories');
        debugPrint(
          "First endpoint failed, trying alternative: $alternativeUri",
        );

        final alternativeResponse = await client.get(
          alternativeUri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (alternativeResponse.statusCode == 200) {
          final Map<String, dynamic> jsonData = jsonDecode(
            alternativeResponse.body,
          );

          if (jsonData.containsKey('data') && jsonData['data'] is List) {
            final edukasiCategoryResponse = EdukasiCategoryResponse.fromMap(
              jsonData,
            );

            if (edukasiCategoryResponse.data != null) {
              debugPrint(
                "Found ${edukasiCategoryResponse.data!.length} education categories from alternative endpoint",
              );
              return edukasiCategoryResponse.data!;
            }
          }
        }

        throw Exception(
          'Failed to load education categories: ${response.statusCode}',
        );
      }

      return [];
    } catch (e) {
      debugPrint("Error fetching education categories: $e");
      throw Exception('Error fetching education categories: $e');
    }
  }

  Future<String?> getCategoryIcon(int categoryId) async {
    try {
      // Check if we can get the icon from existing data first
      final categories = await getEducationCategories();

      // Try to find the category by ID
      final category = categories.firstWhere(
        (category) => category.id == categoryId,
        orElse: () => EduCategory(),
      );

      // If we found the category and it has an icon, return it
      if (category.icon != null && category.icon!.isNotEmpty) {
        debugPrint("Found icon for category ID $categoryId: ${category.icon}");
        return category.icon;
      }

      // If we couldn't find it in the list, try a direct API call
      final authLocalDatasource = AuthLocalDatasource();
      final token = await authLocalDatasource.getToken();

      final uri = Uri.parse(
        '${Variable.baseUrl}/api/api-categories/$categoryId',
      );
      debugPrint("Fetching specific category from: $uri");

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('data') && jsonData['data'] != null) {
          final categoryData = EduCategory.fromMap(jsonData['data']);
          if (categoryData.icon != null && categoryData.icon!.isNotEmpty) {
            debugPrint(
              "Found icon via API for category ID $categoryId: ${categoryData.icon}",
            );
            return categoryData.icon;
          }
        }
      }

      debugPrint("No icon found for category ID $categoryId");
      return null;
    } catch (e) {
      debugPrint("Error fetching category icon for ID $categoryId: $e");
      return null;
    }
  }

  // Helper method to get the full image URL from a category ID
  Future<String?> getCategoryIconUrl(int categoryId) async {
    final iconPath = await getCategoryIcon(categoryId);
    if (iconPath != null && iconPath.isNotEmpty) {
      return Variable.imageBaseUrl(iconPath);
    }
    return null;
  }
}

int min(int a, int b) {
  return a < b ? a : b;
}