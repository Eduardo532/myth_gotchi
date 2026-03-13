enum OntogenicPhase {
  egg,
  baby,
  child,
  teenager,
  adult,
  senior,
  spirit
}

class MythCreature {

  // --- Identificación ---
  final String id;
  String name;
  String speciesId;

  // --- Indicadores Fisiológicos y Psicológicos ---
  int hunger;
  int happiness;
  int ageInHours;
  double weight;
  int careMistakes;
  OntogenicPhase phase;
  DateTime lastInteractionTime;
  DateTime birthDate;

  // --- Inicialización ---
  MythCreature({
    required this.id,
    required this.name,
    required this.speciesId,
    this.hunger = 4,
    this.happiness = 4,
    this.ageInHours = 0,
    this.weight = 1.0,
    this.careMistakes = 0,
    this.phase = OntogenicPhase.egg,
    DateTime? lastInteractionTime,
    DateTime? birthDate,
  })  : lastInteractionTime = lastInteractionTime ?? DateTime.now(),
        birthDate = birthDate ?? DateTime.now();

  // --- Serialización ---
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'speciesId': speciesId,
      'hunger': hunger,
      'happiness': happiness,
      'ageInHours': ageInHours,
      'weight': weight,
      'careMistakes': careMistakes,
      'phase': phase.index,
      'lastInteractionTime': lastInteractionTime.toIso8601String(),
      'birthDate': birthDate.toIso8601String(),
    };
  }

  factory MythCreature.fromJson(Map<String, dynamic> json) {
    return MythCreature(
      id: json['id'] as String,
      name: json['name'] as String,
      speciesId: json['speciesId'] as String,
      hunger: json['hunger'] as int,
      happiness: json['happiness'] as int,
      ageInHours: json['ageInHours'] as int,
      weight: (json['weight'] as num).toDouble(),
      careMistakes: json['careMistakes'] as int,
      phase: OntogenicPhase.values[json['phase'] as int],
      lastInteractionTime: DateTime.parse(json['lastInteractionTime'] as String),
      birthDate: DateTime.parse(json['birthDate'] as String),
    );
  }
}