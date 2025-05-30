import 'package:flutter/material.dart';
import 'package:medhub/presentation/home/widgets/health_service_card.dart';
import '../../../../models/health_service.dart';

class BookingCardList extends StatelessWidget {
  final List<HealthService> bookingServices;

  const BookingCardList({super.key, required this.bookingServices});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: bookingServices.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return HealthServiceCard(service: bookingServices[index]);
      },
    );
  }
}
