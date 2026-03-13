import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// --- Servicio Multijugador BLE ---

class BleMultiplayerService extends ChangeNotifier {

  // --- Estado ---

  bool _isScanning = false;
  bool _isConnected = false;
  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _writeCharacteristic;
  BluetoothCharacteristic? _readCharacteristic;
  List<ScanResult> _scanResults = [];
  String _lastReceivedData = '';

  bool get isScanning => _isScanning;
  bool get isConnected => _isConnected;
  BluetoothDevice? get connectedDevice => _connectedDevice;
  List<ScanResult> get scanResults => _scanResults;
  String get lastReceivedData => _lastReceivedData;

  // --- Inicialización ---

  BleMultiplayerService() {
    FlutterBluePlus.isSupported.then((supported) {
      if (supported) {
        FlutterBluePlus.adapterState.listen((state) {
          if (state == BluetoothAdapterState.on) {
            _setupScanListener();
          }
        });
      }
    });
  }

  void _setupScanListener() {
    FlutterBluePlus.scanResults.listen((results) {
      _scanResults = results;
      notifyListeners();
    });

    FlutterBluePlus.isScanning.listen((state) {
      _isScanning = state;
      notifyListeners();
    });
  }

  // --- Escaneo ---

  Future<void> startScanning() async {
    _scanResults.clear();
    notifyListeners();
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> stopScanning() async {
    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // --- Conexión y Datos ---

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await stopScanning();
      await device.connect(autoConnect: false);
      _connectedDevice = device;
      _isConnected = true;
      notifyListeners();
      await _discoverServices(device);
    } catch (e) {
      _isConnected = false;
      _connectedDevice = null;
      notifyListeners();
    }
  }

  Future<void> disconnect() async {
    if (_connectedDevice != null) {
      await _connectedDevice!.disconnect();
      _connectedDevice = null;
      _isConnected = false;
      _writeCharacteristic = null;
      _readCharacteristic = null;
      notifyListeners();
    }
  }

  Future<void> _discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.properties.write || characteristic.properties.writeWithoutResponse) {
          _writeCharacteristic = characteristic;
        }
        if (characteristic.properties.notify || characteristic.properties.read) {
          _readCharacteristic = characteristic;
          await _subscribeToCharacteristic();
        }
      }
    }
  }

  Future<void> _subscribeToCharacteristic() async {
    if (_readCharacteristic != null && _readCharacteristic!.properties.notify) {
      await _readCharacteristic!.setNotifyValue(true);
      _readCharacteristic!.lastValueStream.listen((value) {
        _lastReceivedData = utf8.decode(value);
        notifyListeners();
      });
    }
  }

  Future<void> sendData(Map<String, dynamic> data) async {
    if (_writeCharacteristic != null) {
      try {
        String jsonString = jsonEncode(data);
        List<int> bytes = utf8.encode(jsonString);
        await _writeCharacteristic!.write(bytes);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}