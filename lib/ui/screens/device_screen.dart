import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/homeostasis_loop.dart';
import '../widgets/creature_sprite.dart';
import '../widgets/status_meters.dart';

// --- Pantalla Principal ---

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E8F0),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 4,
              child: _VirtualLcdScreen(),
            ),
            Container(
              height: 2,
              color: Colors.black12,
            ),
            const Expanded(
              flex: 1,
              child: _HardwarePanel(),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Entorno Virtual LCD ---

class _VirtualLcdScreen extends StatelessWidget {
  const _VirtualLcdScreen({Key? key}) : super(key: key);

  void _showDevMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF9EAC8E),
        border: Border.all(color: Colors.black87, width: 4.0),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Consumer<HomeostasisLoop>(
        builder: (context, loop, child) {
          final hasCreature = loop.creature != null;

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // --- Fila Superior de Iconos ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _LcdIcon(
                    icon: Icons.monitor_heart,
                    isActive: false,
                    onTap: () => _showDevMessage(context, 'Menú de Estadísticas en desarrollo'),
                  ),
                  _LcdIcon(
                    icon: Icons.restaurant,
                    isActive: false,
                    onTap: () {
                      if (hasCreature) {
                        loop.feed();
                      } else {
                        _showDevMessage(context, 'No hay criatura para alimentar');
                      }
                    },
                  ),
                  _LcdIcon(
                    icon: Icons.cleaning_services,
                    isActive: false,
                    onTap: () => _showDevMessage(context, 'Acción de Limpiar/Bañar en desarrollo'),
                  ),
                  _LcdIcon(
                    icon: Icons.sports_esports,
                    isActive: false,
                    onTap: () {
                      if (hasCreature) {
                        loop.play();
                      } else {
                        _showDevMessage(context, 'No hay criatura para jugar');
                      }
                    },
                  ),
                ],
              ),

              // --- Pantalla Central (Sprite y Medidores) ---
              Expanded(
                child: hasCreature
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const StatusMeters(),
                    const Spacer(),
                    const CreatureSprite(),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'EDAD: ${loop.creature!.ageInHours ~/ 24}D',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'PESO: ${loop.creature!.weight.toStringAsFixed(1)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                    : const Center(
                  child: Text(
                    'PRESIONA (B)\nPARA INICIAR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),

              // --- Fila Inferior de Iconos ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _LcdIcon(
                    icon: Icons.bluetooth,
                    isActive: false,
                    onTap: () => _showDevMessage(context, 'Menú de Conexión BLE en desarrollo'),
                  ),
                  _LcdIcon(
                    icon: Icons.record_voice_over,
                    isActive: false,
                    onTap: () => _showDevMessage(context, 'Acción de Disciplina en desarrollo'),
                  ),
                  _LcdIcon(
                    icon: Icons.medical_services,
                    isActive: false,
                    onTap: () => _showDevMessage(context, 'Acción de Medicina en desarrollo'),
                  ),
                  _LcdIcon(
                    icon: Icons.notification_important,
                    isActive: loop.needsAttention,
                    onTap: () {
                      if (loop.needsAttention) {
                        _showDevMessage(context, '¡Tu criatura necesita atención!');
                      } else {
                        _showDevMessage(context, 'Historial de Alertas en desarrollo');
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// --- Icono Pulsable LCD ---

class _LcdIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _LcdIcon({
    Key? key,
    required this.icon,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isActive ? Colors.black87 : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 28.0,
          color: isActive ? const Color(0xFF9EAC8E) : Colors.black54,
        ),
      ),
    );
  }
}

// --- Panel de Hardware ---

class _HardwarePanel extends StatelessWidget {
  const _HardwarePanel({Key? key}) : super(key: key);

  void _showDevMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loop = context.read<HomeostasisLoop>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _HardwareButton(
            label: 'A',
            onTap: () => _showDevMessage(context, 'Botón A: Seleccionar (En desarrollo)'),
          ),
          _HardwareButton(
            label: 'B',
            onTap: () {
              if (loop.creature == null) {
                loop.hatchNewEgg('egg_dragon');
              } else {
                _showDevMessage(context, 'Botón B: Ejecutar / Atrás (En desarrollo)');
              }
            },
          ),
          _HardwareButton(
            label: 'C',
            onTap: () => _showDevMessage(context, 'Botón C: Cancelar (En desarrollo)'),
          ),
        ],
      ),
    );
  }
}

class _HardwareButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _HardwareButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFE56B70),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black26, width: 2.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 4),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}