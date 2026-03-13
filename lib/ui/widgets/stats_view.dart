import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/homeostasis_loop.dart';
import '../../models/evolution_tree.dart';
import 'status_meters.dart';

class StatsView extends StatelessWidget {
  const StatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loop = context.watch<HomeostasisLoop>();
    final creature = loop.creature;

    if (creature == null) return const SizedBox.shrink();

    final speciesName = EvolutionTree.getSpeciesName(creature.speciesId);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'ESTADO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 2.0,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const StatusMeters(),
          const Divider(color: Colors.black54),
          _StatRow(label: 'NOMBRE:', value: creature.name),
          _StatRow(label: 'ESPECIE:', value: speciesName),
          _StatRow(label: 'EDAD:', value: '${creature.ageInHours ~/ 24} DIAS'),
          _StatRow(label: 'PESO:', value: '${creature.weight.toStringAsFixed(1)} G'),
          _StatRow(label: 'ERRORES:', value: '${creature.careMistakes}/20'),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}