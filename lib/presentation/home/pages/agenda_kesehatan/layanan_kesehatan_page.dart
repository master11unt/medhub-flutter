import 'package:flutter/material.dart';
import '../../../../models/health_service.dart';
import '../../widgets/health_service_card.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class LayananKesehatanPage extends StatefulWidget {
  final bool initialIsLayananSelected;

  const LayananKesehatanPage({super.key, this.initialIsLayananSelected = true});

  @override
  State<LayananKesehatanPage> createState() => _LayananKesehatanPageState();
}

class _LayananKesehatanPageState extends State<LayananKesehatanPage> {
  late bool isLayananSelected;

  @override
  void initState() {
    super.initState();
    isLayananSelected = widget.initialIsLayananSelected;
  }

  String? selectedLocation;

  final List<String> lokasiList = [
    'Semua Lokasi',
    'Cibubur',
    'Cileungsi',
    'Jonggol',
  ];

  final List<HealthService> allServices = [
    HealthService(
      title: 'Vaksinasi Gratis',
      dateTime: '24 April 2025, 08.00 – 11.00 WIB',
      location: 'Puskesmas Cileungsi 1',
      imagePath: 'assets/images/agenda1.png',
    ),
    HealthService(
      title: 'Donor Darah',
      dateTime: '25 April 2025, 09.00 – 12.00 WIB',
      location: 'RSUD Jonggol',
      imagePath: 'assets/images/agenda2.png',
    ),
    HealthService(
      title: 'Cek Kesehatan Gratis',
      dateTime: '30 April 2025, 08.30 – 11.00 WIB',
      location: 'Posyandu Melati Cibubur',
      imagePath: 'assets/images/agenda3.png',
    ),
  ];
  final List<HealthService> bookingServices = [
    HealthService(
      title: 'Booking Vaksin Anak',
      dateTime: '2 Mei 2025, 10.00 – 12.00 WIB',
      location: 'Klinik Sehat Cibubur',
      imagePath: 'assets/images/agenda1.png',
    ),
    HealthService(
      title: 'Booking Cek Gula Darah',
      dateTime: '5 Mei 2025, 09.00 – 10.30 WIB',
      location: 'Rumah Sakit Medika',
      imagePath: 'assets/images/agenda2.png',
    ),
  ];

  List<HealthService> get filteredServices {
    if (selectedLocation == null || selectedLocation == 'Semua Lokasi') {
      return allServices;
    }
    return allServices
        .where((e) => e.location.contains(selectedLocation!))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Layanan Kesehatan',
          style: TextStyle(
            color: Color(0xFF00A99D),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          color: const Color(0xFF00A89E),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: isLayananSelected
                      ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLayananSelected = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00A99D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Layanan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : OutlinedButton(
                          onPressed: () {
                            setState(() {
                              isLayananSelected = true;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF00A99D)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Layanan',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF00A99D),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: !isLayananSelected
                      ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLayananSelected = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00A99D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Booking',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : OutlinedButton(
                          onPressed: () {
                            setState(() {
                              isLayananSelected = false;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF00A99D)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Booking',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF00A99D),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: isLayananSelected,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: DropdownButtonFormField2<String>(
                  isExpanded: true,
                  value: selectedLocation,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    iconSize: 24,
                    iconEnabledColor: Colors.grey,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 240,
                    width: MediaQuery.of(context).size.width - 32,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    elevation: 2,
                    offset: const Offset(0, -4),
                  ),
                  buttonStyleData: const ButtonStyleData(
                    height: 56,
                    padding: EdgeInsets.only(left: 0, right: 14),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 48,
                    padding: EdgeInsets.zero,
                  ),
                  hint: const Text(
                    'Tentukan Lokasi',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  items: lokasiList.map((String value) {
                    final bool isSelected = value == selectedLocation;
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFE0F7FA) : null,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isLayananSelected
                  ? ListView.separated(
                      itemCount: filteredServices.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return HealthServiceCard(
                          service: filteredServices[index],
                        );
                      },
                    )
                  : ListView.separated(
                      itemCount: bookingServices.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return HealthServiceCard(
                          service: bookingServices[index],
                          isBooking: true,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}