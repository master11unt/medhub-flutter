// lib/services/emergency_service.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class EmergencyService {
  // Nomor darurat
  static const String AMBULANCE_NUMBER = "085875126197";
  static const String POLICE_NUMBER = "110";
  static const String FIRE_DEPARTMENT = "113";
  static const String SEARCH_RESCUE = "115";

  // Method utama untuk show dialog dan handle emergency call
  static Future<void> showEmergencyDialog(BuildContext context) async {
    debugPrint('=== SHOW EMERGENCY DIALOG START ===');
    
    if (!context.mounted) {
      debugPrint('❌ Context not mounted');
      return;
    }

    try {
      await showDialog<void>(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        builder: (BuildContext dialogContext) {
          return const EmergencyCallDialog();
        },
      );
    } catch (e, stackTrace) {
      debugPrint('❌ Error in showEmergencyDialog: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  // Method untuk direct call tanpa dialog confirmation
  static Future<bool> makeDirectCall(BuildContext context, String number, String serviceName) async {
    debugPrint('=== MAKING DIRECT CALL ===');
    debugPrint('Service: $serviceName');
    debugPrint('Number: $number');
    
    if (!context.mounted) {
      debugPrint('❌ Context not mounted');
      return false;
    }

    // Show loading
    final loadingDialog = showDialog(
      context: context,
      barrierDismissible: false,
      builder: (loadingContext) => const Center(
        child: CircularProgressIndicator(color: Color(0xFFD81305)),
      ),
    );

    try {
      // Check and request permission
      final hasPermission = await checkAndRequestPermission();
      debugPrint('📱 Permission granted: $hasPermission');
      
      if (!hasPermission) {
        // Close loading
        if (context.mounted) Navigator.of(context).pop();
        
        // Show permission error
        if (context.mounted) {
          _showPermissionError(context);
        }
        return false;
      }

      // Make the call
      final success = await makeEmergencyCall(number);
      debugPrint('📞 Call success: $success');
      
      // Close loading
      if (context.mounted) Navigator.of(context).pop();
      
      if (!success && context.mounted) {
        _showCallError(context, serviceName, number);
      }
      
      return success;
      
    } catch (e, stackTrace) {
      debugPrint('❌ Exception in makeDirectCall: $e');
      debugPrint('Stack trace: $stackTrace');
      
      // Close loading
      if (context.mounted) Navigator.of(context).pop();
      
      // Show error
      if (context.mounted) {
        _showCallError(context, serviceName, number);
      }
      
      return false;
    }
  }

  // Check dan request permission
  static Future<bool> checkAndRequestPermission() async {
    debugPrint('=== CHECKING PHONE PERMISSION ===');
    
    try {
      // Untuk Android 13+ (API 33+), permission CALL_PHONE bisa berbeda
      final status = await Permission.phone.status;
      debugPrint('Current permission status: $status');
      
      if (status.isGranted) {
        debugPrint('✅ Phone permission already granted');
        return true;
      }
      
      // Coba request permission
      if (status.isDenied) {
        debugPrint('📞 Requesting phone permission...');
        final result = await Permission.phone.request();
        debugPrint('Permission request result: $result');
        
        if (result.isGranted) {
          return true;
        }
      }
      
      // Jika permission denied, coba dengan dial instead of call
      debugPrint('⚠️ Call permission denied, will use dial mode');
      return true; // Return true untuk fallback ke dial mode
    
    } catch (e, stackTrace) {
      debugPrint('❌ Error checking permission: $e');
      debugPrint('Stack trace: $stackTrace');
      return true; // Return true untuk fallback ke dial mode
    }
  }

  // Make emergency call with multiple fallback options
  static Future<bool> makeEmergencyCall(String number) async {
    try {
      debugPrint('=== MAKING EMERGENCY CALL ===');
      debugPrint('Number: $number');
      
      // Clean nomor telepon
      final cleanNumber = number.replaceAll(RegExp(r'[^\d+]'), '');
      debugPrint('Cleaned number: $cleanNumber');
      
      // Try different URI schemes sebagai fallback
      final List<Map<String, dynamic>> callOptions = [
        {'uri': Uri(scheme: 'tel', path: cleanNumber), 'mode': 'call'},
        {'uri': Uri.parse('tel:$cleanNumber'), 'mode': 'call'},
        {'uri': Uri(scheme: 'tel', path: cleanNumber), 'mode': 'dial'}, // Fallback to dial
      ];
      
      for (int i = 0; i < callOptions.length; i++) {
        final option = callOptions[i];
        final uri = option['uri'] as Uri;
        final mode = option['mode'] as String;
        
        debugPrint('Trying ${mode.toUpperCase()} with URI ${i + 1}: $uri');
        
        try {
          final canLaunch = await canLaunchUrl(uri);
          debugPrint('Can launch URI ${i + 1}: $canLaunch');
          
          if (canLaunch) {
            debugPrint('✅ Launching $mode with URI: $uri');
            
            final success = await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            );
            
            debugPrint('Launch result: $success');
            
            if (success) {
              debugPrint('✅ $mode launched successfully!');
              return true;
            }
          }
        } catch (e) {
          debugPrint('❌ Failed to launch URI ${i + 1}: $e');
          continue;
        }
      }
      
      debugPrint('❌ All call attempts failed');
      return false;
      
    } catch (e, stackTrace) {
      debugPrint('❌ Error making call: $e');
      debugPrint('Stack trace: $stackTrace');
      return false;
    }
  }

  // Show permission error dialog
  static void _showPermissionError(BuildContext context) {
    showDialog(
      context: context,
      builder: (errorContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            SizedBox(width: 8),
            Text('Izin Diperlukan'),
          ],
        ),
        content: const Text(
          'Aplikasi memerlukan izin panggilan telepon untuk menghubungi layanan darurat.\n\n'
          'Silakan berikan izin di pengaturan aplikasi.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(errorContext).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(errorContext).pop();
              openAppSettings(); // Open app settings
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD81305),
              foregroundColor: Colors.white,
            ),
            child: const Text('Buka Pengaturan'),
          ),
        ],
      ),
    );
  }

  // Show call error dialog
  static void _showCallError(BuildContext context, String serviceName, String number) {
    showDialog(
      context: context,
      builder: (errorContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text('Gagal Menelepon'),
          ],
        ),
        content: Text(
          'Tidak dapat menghubungi $serviceName.\n\n'
          'Silakan coba:\n'
          '• Panggil manual: $number\n'
          '• Periksa jaringan telepon\n'
          '• Restart aplikasi',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(errorContext).pop(),
            child: const Text('OK'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(errorContext).pop();
              // Try manual dial
              _tryManualDial(context, number);
            },
            child: const Text('Coba Manual'),
          ),
        ],
      ),
    );
  }

  // Try manual dial as fallback
  static Future<void> _tryManualDial(BuildContext context, String number) async {
    try {
      final dialUri = Uri(scheme: 'tel', path: number);
      await launchUrl(dialUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('❌ Manual dial failed: $e');
    }
  }
}

// Simplified Emergency Dialog
class EmergencyCallDialog extends StatelessWidget {
  const EmergencyCallDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFFDFDFD),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 280, 
          maxWidth: 400,
          maxHeight: 600,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  const Icon(
                    Icons.emergency,
                    color: Color(0xFFD81305),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Panggilan Darurat',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Emergency buttons - Simplified approach
              _buildSimpleEmergencyButton(
                context,
                'Ambulans',
                'Layanan medis darurat',
                Icons.local_hospital,
                EmergencyService.AMBULANCE_NUMBER,
                const Color(0xFFD81305),
              ),
              const SizedBox(height: 12),
              
              _buildSimpleEmergencyButton(
                context,
                'Polisi (110)', 
                'Keamanan dan kecelakaan',
                Icons.local_police,
                EmergencyService.POLICE_NUMBER,
                const Color(0xFF1976D2),
              ),
              const SizedBox(height: 12),
              
              _buildSimpleEmergencyButton(
                context,
                'Pemadam Kebakaran (113)',
                'Kebakaran dan penyelamatan',
                Icons.local_fire_department,
                EmergencyService.FIRE_DEPARTMENT,
                const Color(0xFFFF6F00),
              ),
              const SizedBox(height: 12),
              
              _buildSimpleEmergencyButton(
                context,
                'SAR (115)',
                'Search and Rescue',
                Icons.search,
                EmergencyService.SEARCH_RESCUE,
                const Color(0xFF388E3C),
              ),
              
              const SizedBox(height: 20),
              
              // Cancel button
              TextButton(
                onPressed: () {
                  debugPrint('🚫 Emergency dialog cancelled');
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey[600],
                ),
                child: const Text('Batal'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Simplified emergency button yang langsung call dengan confirmation
  Widget _buildSimpleEmergencyButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    String number,
    Color color,
  ) {
    return InkWell(
      onTap: () async {
        debugPrint('🆘 Emergency button tapped: $title');
        debugPrint('📱 Number: $number');
        
        // Close current dialog
        if (context.mounted) {
          Navigator.of(context).pop();
        }
        
        // Wait for dialog to close
        await Future.delayed(const Duration(milliseconds: 100));
        
        // Get new context and show confirmation
        if (context.mounted) {
          final shouldCall = await _showQuickConfirmation(context, title, number);
          
          if (shouldCall == true && context.mounted) {
            debugPrint('📞 User confirmed, making direct call...');
            await EmergencyService.makeDirectCall(context, number, title);
          }
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.05),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.phone, color: color, size: 20),
          ],
        ),
      ),
    );
  }

  // Quick confirmation dialog
  Future<bool?> _showQuickConfirmation(
    BuildContext context,
    String service,
    String number,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.phone, color: Color(0xFFD81305)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Panggil $service?',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Text(
          'Anda akan menghubungi $service ($number).\n\nIni adalah panggilan darurat.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD81305),
              foregroundColor: Colors.white,
            ),
            child: const Text('Panggil'),
          ),
        ],
      ),
    );
  }
}