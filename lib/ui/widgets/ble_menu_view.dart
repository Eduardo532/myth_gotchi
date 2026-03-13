import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/ble_multiplayer_service.dart';
import '../../services/homeostasis_loop.dart';

// --- Menú de Conexión BLE ---

class BleMenuView extends StatelessWidget {
  const BleMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bleService = context.watch<BleMultiplayerService>();
    final loop = context.read<HomeostasisLoop>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            'CONEXION',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 2.0,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(height: 10),
          if (bleService.isConnected)
            _ConnectedView(bleService: bleService, loop: loop)
          else
            _ScanningView(bleService: bleService),
        ],
      ),
    );
  }
}

// --- Vista de Escaneo ---

class _ScanningView extends StatelessWidget {
  final BleMultiplayerService bleService;

  const _ScanningView({
    Key? key,
    required this.bleService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              foregroundColor: const Color(0xFF9EAC8E),
            ),
            onPressed: bleService.isScanning ? null : () => bleService.startScanning(),
            child: Text(bleService.isScanning ? 'BUSCANDO...' : 'INICIAR RADAR'),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: bleService.scanResults.isEmpty
                ? const Center(
              child: Text(
                'SIN SEÑAL',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
                : ListView.builder(
              itemCount: bleService.scanResults.length,
              itemBuilder: (context, index) {
                final result = bleService.scanResults[index];
                final deviceName = result.device.platformName.isNotEmpty
                    ? result.device.platformName
                    : 'Gotchi Desconocido';

                return ListTile(
                  dense: true,
                  title: Text(
                    deviceName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.signal_cellular_alt, size: 16, color: Colors.black87),
                  onTap: () => bleService.connectToDevice(result.device),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- Vista Conectada ---

class _ConnectedView extends StatelessWidget {
  final BleMultiplayerService bleService;
  final HomeostasisLoop loop;

  const _ConnectedView({
    Key? key,
    required this.bleService,
    required this.loop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            '¡ENLACE ESTABLECIDO!',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          if (bleService.lastReceivedData.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87),
              ),
              child: Text(
                'VISITA:\n${bleService.lastReceivedData}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  foregroundColor: const Color(0xFF9EAC8E),
                ),
                onPressed: () {
                  if (loop.creature != null) {
                    bleService.sendData({
                      'name': loop.creature!.name,
                      'species': loop.creature!.speciesId,
                    });
                  }
                },
                child: const Text('ENVIAR'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  foregroundColor: const Color(0xFF9EAC8E),
                ),
                onPressed: () => bleService.disconnect(),
                child: const Text('SALIR'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}