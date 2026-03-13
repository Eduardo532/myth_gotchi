import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/myth_creature.dart';
import '../models/evolution_tree.dart';

// --- Bucle de Homeostasis ---

class HomeostasisLoop extends ChangeNotifier {
  MythCreature? _creature;
  Timer? _tickTimer;
  Timer? _attentionTimer;

  bool _needsAttention = false;
  bool _isDead = false;

  MythCreature? get creature => _creature;
  bool get needsAttention => _needsAttention;
  bool get isDead => _isDead;

  HomeostasisLoop() {
    _initializeEcosystem();
  }

  // --- Inicialización y Persistencia ---

  Future<void> _initializeEcosystem() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('saved_creature');

    if (data != null) {
      _creature = MythCreature.fromJson(jsonDecode(data));
      _calculateOfflineMetabolism();
    }

    _startBiologicalClock();
    notifyListeners();
  }

  Future<void> _saveState() async {
    if (_creature == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_creature', jsonEncode(_creature!.toJson()));
  }

  Future<void> hatchNewEgg(String speciesId) async {
    _creature = MythCreature(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Mito',
      speciesId: speciesId,
    );
    _isDead = false;
    _needsAttention = false;
    await _saveState();
    notifyListeners();
  }

  // --- Reloj Biológico ---

  void _startBiologicalClock() {
    _tickTimer?.cancel();
    _tickTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _processBiologicalTick();
    });
  }

  void _calculateOfflineMetabolism() {
    if (_creature == null || _creature!.phase == OntogenicPhase.spirit) return;

    final now = DateTime.now();
    final minutesPassed = now.difference(_creature!.lastInteractionTime).inMinutes;

    for (int i = 0; i < minutesPassed; i++) {
      _processBiologicalTick(isOffline: true);
      if (_creature!.phase == OntogenicPhase.spirit) break;
    }
  }

  void _processBiologicalTick({bool isOffline = false}) {
    if (_creature == null || _creature!.phase == OntogenicPhase.spirit) return;

    _creature!.ageInHours += 1;

    if (_creature!.ageInHours % 60 == 0) {
      if (_creature!.hunger > 0) _creature!.hunger -= 1;
      if (_creature!.happiness > 0) _creature!.happiness -= 1;
    }

    _evaluateHomeostasis();
    _evaluateOntogeny();
    _evaluateMortality();

    _creature!.lastInteractionTime = DateTime.now();

    if (!isOffline) {
      _saveState();
      notifyListeners();
    }
  }

  // --- Interacción del Usuario ---

  void feed() {
    if (_creature == null || _creature!.phase == OntogenicPhase.spirit) return;
    if (_creature!.hunger < 4) {
      _creature!.hunger += 1;
      _creature!.weight += 0.5;
      _resolveAttentionCall();
      _saveState();
      notifyListeners();
    }
  }

  void play() {
    if (_creature == null || _creature!.phase == OntogenicPhase.spirit) return;
    if (_creature!.happiness < 4) {
      _creature!.happiness += 1;
      _creature!.weight -= 0.2;
      _resolveAttentionCall();
      _saveState();
      notifyListeners();
    }
  }

  // --- Algoritmos de Consecuencia ---

  void _evaluateHomeostasis() {
    if (_creature!.hunger == 0 || _creature!.happiness == 0) {
      if (!_needsAttention) {
        _needsAttention = true;
        _attentionTimer = Timer(const Duration(minutes: 15), _registerCareMistake);
      }
    }
  }

  void _resolveAttentionCall() {
    if (_creature!.hunger > 0 && _creature!.happiness > 0) {
      _needsAttention = false;
      _attentionTimer?.cancel();
    }
  }

  void _registerCareMistake() {
    if (_needsAttention && _creature != null) {
      _creature!.careMistakes += 1;
      _needsAttention = false;
      _saveState();
      notifyListeners();
    }
  }

  void _evaluateOntogeny() {
    if (_creature == null) return;

    OntogenicPhase? nextPhase;

    if (_creature!.phase == OntogenicPhase.egg && _creature!.ageInHours >= 5) {
      nextPhase = OntogenicPhase.baby;
    } else if (_creature!.phase == OntogenicPhase.baby && _creature!.ageInHours >= 65) {
      nextPhase = OntogenicPhase.child;
    } else if (_creature!.phase == OntogenicPhase.child && _creature!.ageInHours >= 1440) {
      nextPhase = OntogenicPhase.teenager;
    } else if (_creature!.phase == OntogenicPhase.teenager && _creature!.ageInHours >= 4320) {
      nextPhase = OntogenicPhase.adult;
    } else if (_creature!.phase == OntogenicPhase.adult && _creature!.ageInHours >= 12960) {
      nextPhase = OntogenicPhase.senior;
    } else if (_creature!.phase == OntogenicPhase.senior && _creature!.ageInHours >= 20160) {
      nextPhase = OntogenicPhase.spirit;
    }

    if (nextPhase != null) {
      if (nextPhase == OntogenicPhase.spirit) {
        _creature!.phase = OntogenicPhase.spirit;
        _isDead = true;
      } else {
        final nextSpecies = EvolutionTree.checkEvolution(_creature!.speciesId, nextPhase, _creature!.careMistakes);
        if (nextSpecies != null) {
          _creature!.speciesId = nextSpecies;
          _creature!.phase = nextPhase;
        }
      }
    }
  }

  void _evaluateMortality() {
    if (_creature!.careMistakes >= 20) {
      _creature!.phase = OntogenicPhase.spirit;
      _isDead = true;
    }
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    _attentionTimer?.cancel();
    super.dispose();
  }
}