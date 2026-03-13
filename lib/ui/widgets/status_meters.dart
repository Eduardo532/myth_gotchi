import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/homeostasis_loop.dart';

// --- Medidores de Estado ---

class StatusMeters extends StatelessWidget {
  const StatusMeters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loop = context.watch<HomeostasisLoop>();
    final creature = loop.creature;

    if (creature == null) return const SizedBox.shrink();

    return Column(
      children: [
        _MeterRow(
          label: 'HAMBRE',
          value: creature.hunger,
          maxValue: 4,
          filledIcon: Icons.restaurant,
          emptyIcon: Icons.restaurant_outlined,
        ),
        const SizedBox(height: 8),
        _MeterRow(
          label: 'FELICIDAD',
          value: creature.happiness,
          maxValue: 4,
          filledIcon: Icons.favorite,
          emptyIcon: Icons.favorite_border,
        ),
      ],
    );
  }
}

class _MeterRow extends StatelessWidget {
  final String label;
  final int value;
  final int maxValue;
  final IconData filledIcon;
  final IconData emptyIcon;

  const _MeterRow({
    Key? key,
    required this.label,
    required this.value,
    required this.maxValue,
    required this.filledIcon,
    required this.emptyIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: List.generate(maxValue, (index) {
            return Icon(
              index < value ? filledIcon : emptyIcon,
              size: 20.0,
              color: Colors.black87,
            );
          }),
        ),
      ],
    );
  }
}