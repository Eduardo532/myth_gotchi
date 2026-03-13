import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/homeostasis_loop.dart';
import '../../models/myth_creature.dart';

// --- Controlador de Sprite ---

class CreatureSprite extends StatefulWidget {
  const CreatureSprite({Key? key}) : super(key: key);

  @override
  State<CreatureSprite> createState() => _CreatureSpriteState();
}

class _CreatureSpriteState extends State<CreatureSprite> with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _scaleAnimation;

  // --- Inicialización y Ciclo de Vida ---

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  // --- Lógica de Renderizado Visual ---

  IconData _getSpriteIcon(OntogenicPhase phase, String speciesId) {
    if (phase == OntogenicPhase.spirit) return Icons.water_drop_outlined;
    if (phase == OntogenicPhase.egg) return Icons.egg;
    if (phase == OntogenicPhase.baby) return Icons.child_care;
    if (phase == OntogenicPhase.senior) return Icons.elderly;

    if (speciesId.contains('dragon')) return Icons.local_fire_department;
    if (speciesId.contains('phoenix')) return Icons.wb_sunny;
    if (speciesId.contains('kraken') || speciesId.contains('squid') || speciesId.contains('leviathan')) return Icons.water;
    if (speciesId.contains('griffin') || speciesId.contains('pegasus')) return Icons.flight;
    if (speciesId.contains('cerberus')) return Icons.pets;
    if (speciesId.contains('kitsune')) return Icons.auto_awesome;
    if (speciesId.contains('yeti')) return Icons.ac_unit;
    if (speciesId.contains('basilisk')) return Icons.visibility;

    return Icons.cruelty_free;
  }

  Color _getSpriteColor(String speciesId) {
    if (speciesId.contains('dragon') || speciesId.contains('phoenix')) return Colors.red.shade900;
    if (speciesId.contains('kraken') || speciesId.contains('leviathan')) return Colors.blue.shade900;
    if (speciesId.contains('griffin') || speciesId.contains('pegasus')) return Colors.amber.shade700;
    if (speciesId.contains('cerberus')) return Colors.black87;
    if (speciesId.contains('kitsune')) return Colors.purple.shade700;
    if (speciesId.contains('yeti')) return Colors.cyan.shade800;
    if (speciesId.contains('basilisk')) return Colors.green.shade900;
    return Colors.black87;
  }

  // --- Construcción de Interfaz ---

  @override
  Widget build(BuildContext context) {
    final loop = context.watch<HomeostasisLoop>();
    final creature = loop.creature;

    if (creature == null) return const SizedBox.shrink();

    final iconData = _getSpriteIcon(creature.phase, creature.speciesId);
    final color = creature.phase == OntogenicPhase.spirit ? Colors.grey.shade700 : _getSpriteColor(creature.speciesId);

    return Center(
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: (creature.phase == OntogenicPhase.spirit || creature.phase == OntogenicPhase.egg)
                ? 1.0
                : _scaleAnimation.value,
            child: Icon(
              iconData,
              size: 120.0,
              color: color,
            ),
          );
        },
      ),
    );
  }
}