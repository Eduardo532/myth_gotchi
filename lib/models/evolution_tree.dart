import 'myth_creature.dart';

// --- Modelos de Especie y Evolución ---

class MythicSpecies {
  final String id;
  final String name;
  final String description;

  const MythicSpecies({
    required this.id,
    required this.name,
    required this.description,
  });
}

class EvolutionRule {
  final OntogenicPhase phaseRequired;
  final int maxCareMistakes;
  final String targetSpeciesId;

  const EvolutionRule({
    required this.phaseRequired,
    required this.maxCareMistakes,
    required this.targetSpeciesId,
  });
}

// --- Árbol Evolutivo ---

class EvolutionTree {
  static const List<MythicSpecies> initialEggs = [
    MythicSpecies(id: 'egg_dragon', name: 'Huevo Dracónico', description: 'Escamas rojas calientes.'),
    MythicSpecies(id: 'egg_phoenix', name: 'Huevo Ígneo', description: 'Irradia luz y calor.'),
    MythicSpecies(id: 'egg_kraken', name: 'Huevo Abisal', description: 'Húmedo y profundo.'),
    MythicSpecies(id: 'egg_griffin', name: 'Huevo Áureo', description: 'Plumas doradas incrustadas.'),
    MythicSpecies(id: 'egg_cerberus', name: 'Huevo Sombrío', description: 'Emana un aura oscura.'),
    MythicSpecies(id: 'egg_pegasus', name: 'Huevo Celestial', description: 'Ligero como una nube.'),
    MythicSpecies(id: 'egg_kitsune', name: 'Huevo Espiritual', description: 'Rodeado de fuego fatuo.'),
    MythicSpecies(id: 'egg_yeti', name: 'Huevo Glacial', description: 'Cubierto de escarcha.'),
    MythicSpecies(id: 'egg_leviathan', name: 'Huevo Maremoto', description: 'Resuena con el océano.'),
    MythicSpecies(id: 'egg_basilisk', name: 'Huevo Pétreo', description: 'Duro como la roca pura.'),
  ];

  static final Map<String, List<EvolutionRule>> _evolutionMap = {
    // --- Línea Evolutiva: Dragón ---
    'egg_dragon': [
      const EvolutionRule(phaseRequired: OntogenicPhase.baby, maxCareMistakes: 99, targetSpeciesId: 'baby_dragon'),
    ],
    'baby_dragon': [
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 2, targetSpeciesId: 'child_dragon_pure'),
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 99, targetSpeciesId: 'child_dragon_feral'),
    ],
    'child_dragon_pure': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 3, targetSpeciesId: 'teen_dragon_noble'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_dragon_rogue'),
    ],
    'child_dragon_feral': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 4, targetSpeciesId: 'teen_dragon_rogue'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_dragon_wild'),
    ],
    'teen_dragon_noble': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 1, targetSpeciesId: 'adult_bahamut'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_wyvern'),
    ],
    'teen_dragon_rogue': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 3, targetSpeciesId: 'adult_wyvern'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_drake'),
    ],
    'teen_dragon_wild': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_drake'),
    ],
    'adult_bahamut': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_ancient_dragon'),
    ],
    'adult_wyvern': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_ancient_dragon'),
    ],
    'adult_drake': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_ancient_dragon'),
    ],
    'senior_ancient_dragon': [
      const EvolutionRule(phaseRequired: OntogenicPhase.spirit, maxCareMistakes: 99, targetSpeciesId: 'spirit_dragon_soul'),
    ],

    // --- Línea Evolutiva: Fénix ---
    'egg_phoenix': [
      const EvolutionRule(phaseRequired: OntogenicPhase.baby, maxCareMistakes: 99, targetSpeciesId: 'baby_phoenix'),
    ],
    'baby_phoenix': [
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 3, targetSpeciesId: 'child_phoenix_light'),
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 99, targetSpeciesId: 'child_phoenix_ash'),
    ],
    'child_phoenix_light': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 2, targetSpeciesId: 'teen_phoenix_sun'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_phoenix_dusk'),
    ],
    'child_phoenix_ash': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 5, targetSpeciesId: 'teen_phoenix_dusk'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_phoenix_soot'),
    ],
    'teen_phoenix_sun': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 0, targetSpeciesId: 'adult_solar_phoenix'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_firebird'),
    ],
    'teen_phoenix_dusk': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 3, targetSpeciesId: 'adult_firebird'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_ember_crow'),
    ],
    'teen_phoenix_soot': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_ember_crow'),
    ],
    'adult_solar_phoenix': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_ash_bird'),
    ],
    'adult_firebird': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_ash_bird'),
    ],
    'adult_ember_crow': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_ash_bird'),
    ],
    'senior_ash_bird': [
      const EvolutionRule(phaseRequired: OntogenicPhase.spirit, maxCareMistakes: 99, targetSpeciesId: 'spirit_eternal_flame'),
    ],

    // --- Línea Evolutiva: Kraken ---
    'egg_kraken': [
      const EvolutionRule(phaseRequired: OntogenicPhase.baby, maxCareMistakes: 99, targetSpeciesId: 'baby_squid'),
    ],
    'baby_squid': [
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 2, targetSpeciesId: 'child_kraken_tide'),
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 99, targetSpeciesId: 'child_kraken_swamp'),
    ],
    'child_kraken_tide': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 3, targetSpeciesId: 'teen_kraken_oceanic'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_kraken_toxic'),
    ],
    'child_kraken_swamp': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 4, targetSpeciesId: 'teen_kraken_toxic'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_kraken_mud'),
    ],
    'teen_kraken_oceanic': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 1, targetSpeciesId: 'adult_cthulhu'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_giant_squid'),
    ],
    'teen_kraken_toxic': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 3, targetSpeciesId: 'adult_giant_squid'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_swamp_beast'),
    ],
    'teen_kraken_mud': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_swamp_beast'),
    ],
    'adult_cthulhu': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_deep_one'),
    ],
    'adult_giant_squid': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_deep_one'),
    ],
    'adult_swamp_beast': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_deep_one'),
    ],
    'senior_deep_one': [
      const EvolutionRule(phaseRequired: OntogenicPhase.spirit, maxCareMistakes: 99, targetSpeciesId: 'spirit_abyssal_echo'),
    ],

    // --- Línea Evolutiva: Grifo ---
    'egg_griffin': [
      const EvolutionRule(phaseRequired: OntogenicPhase.baby, maxCareMistakes: 99, targetSpeciesId: 'baby_griffin'),
    ],
    'baby_griffin': [
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 2, targetSpeciesId: 'child_griffin_wind'),
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 99, targetSpeciesId: 'child_griffin_dust'),
    ],
    'child_griffin_wind': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 2, targetSpeciesId: 'teen_griffin_majestic'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_griffin_scavenger'),
    ],
    'child_griffin_dust': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 4, targetSpeciesId: 'teen_griffin_scavenger'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_griffin_feral'),
    ],
    'teen_griffin_majestic': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 1, targetSpeciesId: 'adult_royal_griffin'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_manticore'),
    ],
    'teen_griffin_scavenger': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 3, targetSpeciesId: 'adult_manticore'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_gargoyle'),
    ],
    'teen_griffin_feral': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_gargoyle'),
    ],
    'adult_royal_griffin': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_elder_griffin'),
    ],
    'adult_manticore': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_elder_griffin'),
    ],
    'adult_gargoyle': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_elder_griffin'),
    ],
    'senior_elder_griffin': [
      const EvolutionRule(phaseRequired: OntogenicPhase.spirit, maxCareMistakes: 99, targetSpeciesId: 'spirit_golden_feather'),
    ],

    // --- Línea Evolutiva: Cerbero ---
    'egg_cerberus': [
      const EvolutionRule(phaseRequired: OntogenicPhase.baby, maxCareMistakes: 99, targetSpeciesId: 'baby_hound'),
    ],
    'baby_hound': [
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 2, targetSpeciesId: 'child_cerberus_shadow'),
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 99, targetSpeciesId: 'child_cerberus_bone'),
    ],
    'child_cerberus_shadow': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 3, targetSpeciesId: 'teen_cerberus_underworld'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_cerberus_feral'),
    ],
    'child_cerberus_bone': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 4, targetSpeciesId: 'teen_cerberus_feral'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_cerberus_stray'),
    ],
    'teen_cerberus_underworld': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 1, targetSpeciesId: 'adult_hades_cerberus'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_hellhound'),
    ],
    'teen_cerberus_feral': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 3, targetSpeciesId: 'adult_hellhound'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_shadow_mutt'),
    ],
    'teen_cerberus_stray': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_shadow_mutt'),
    ],
    'adult_hades_cerberus': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_ancient_hound'),
    ],
    'adult_hellhound': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_ancient_hound'),
    ],
    'adult_shadow_mutt': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_ancient_hound'),
    ],
    'senior_ancient_hound': [
      const EvolutionRule(phaseRequired: OntogenicPhase.spirit, maxCareMistakes: 99, targetSpeciesId: 'spirit_underworld_guardian'),
    ],

    // --- Línea Evolutiva: Pegaso ---
    'egg_pegasus': [
      const EvolutionRule(phaseRequired: OntogenicPhase.baby, maxCareMistakes: 99, targetSpeciesId: 'baby_foal'),
    ],
    'baby_foal': [
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 2, targetSpeciesId: 'child_pegasus_cloud'),
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 99, targetSpeciesId: 'child_pegasus_storm'),
    ],
    'child_pegasus_cloud': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 2, targetSpeciesId: 'teen_pegasus_valkyrie'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_pegasus_nightmare'),
    ],
    'child_pegasus_storm': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 4, targetSpeciesId: 'teen_pegasus_nightmare'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_pegasus_strider'),
    ],
    'teen_pegasus_valkyrie': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 1, targetSpeciesId: 'adult_alicorn'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_dark_steed'),
    ],
    'teen_pegasus_nightmare': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 3, targetSpeciesId: 'adult_dark_steed'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_kelpie'),
    ],
    'teen_pegasus_strider': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_kelpie'),
    ],
    'adult_alicorn': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_wise_steed'),
    ],
    'adult_dark_steed': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_wise_steed'),
    ],
    'adult_kelpie': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_wise_steed'),
    ],
    'senior_wise_steed': [
      const EvolutionRule(phaseRequired: OntogenicPhase.spirit, maxCareMistakes: 99, targetSpeciesId: 'spirit_constellation'),
    ],

    // --- Línea Evolutiva: Kitsune ---
    'egg_kitsune': [
      const EvolutionRule(phaseRequired: OntogenicPhase.baby, maxCareMistakes: 99, targetSpeciesId: 'baby_fox'),
    ],
    'baby_fox': [
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 2, targetSpeciesId: 'child_kitsune_spirit'),
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 99, targetSpeciesId: 'child_kitsune_trickster'),
    ],
    'child_kitsune_spirit': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 3, targetSpeciesId: 'teen_kitsune_mystic'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_kitsune_corrupted'),
    ],
    'child_kitsune_trickster': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 4, targetSpeciesId: 'teen_kitsune_corrupted'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_kitsune_feral'),
    ],
    'teen_kitsune_mystic': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 1, targetSpeciesId: 'adult_nine_tails'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_yako'),
    ],
    'teen_kitsune_corrupted': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 3, targetSpeciesId: 'adult_yako'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_nogitsune'),
    ],
    'teen_kitsune_feral': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_nogitsune'),
    ],
    'adult_nine_tails': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_ten_tailed'),
    ],
    'adult_yako': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_ten_tailed'),
    ],
    'adult_nogitsune': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_ten_tailed'),
    ],
    'senior_ten_tailed': [
      const EvolutionRule(phaseRequired: OntogenicPhase.spirit, maxCareMistakes: 99, targetSpeciesId: 'spirit_kami'),
    ],

    // --- Línea Evolutiva: Yeti ---
    'egg_yeti': [
      const EvolutionRule(phaseRequired: OntogenicPhase.baby, maxCareMistakes: 99, targetSpeciesId: 'baby_yeti'),
    ],
    'baby_yeti': [
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 3, targetSpeciesId: 'child_yeti_snow'),
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 99, targetSpeciesId: 'child_yeti_slush'),
    ],
    'child_yeti_snow': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 2, targetSpeciesId: 'teen_yeti_frost'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_yeti_wild'),
    ],
    'child_yeti_slush': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 5, targetSpeciesId: 'teen_yeti_wild'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_yeti_mud'),
    ],
    'teen_yeti_frost': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 1, targetSpeciesId: 'adult_behemoth'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_wendigo'),
    ],
    'teen_yeti_wild': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 3, targetSpeciesId: 'adult_wendigo'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_troll'),
    ],
    'teen_yeti_mud': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_troll'),
    ],
    'adult_behemoth': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_glacier_king'),
    ],
    'adult_wendigo': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_glacier_king'),
    ],
    'adult_troll': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_glacier_king'),
    ],
    'senior_glacier_king': [
      const EvolutionRule(phaseRequired: OntogenicPhase.spirit, maxCareMistakes: 99, targetSpeciesId: 'spirit_winter_wind'),
    ],

    // --- Línea Evolutiva: Leviatán ---
    'egg_leviathan': [
      const EvolutionRule(phaseRequired: OntogenicPhase.baby, maxCareMistakes: 99, targetSpeciesId: 'baby_serpent'),
    ],
    'baby_serpent': [
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 2, targetSpeciesId: 'child_leviathan_wave'),
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 99, targetSpeciesId: 'child_leviathan_mud'),
    ],
    'child_leviathan_wave': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 3, targetSpeciesId: 'teen_leviathan_abyssal'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_leviathan_lurker'),
    ],
    'child_leviathan_mud': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 5, targetSpeciesId: 'teen_leviathan_lurker'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_leviathan_bottomfeeder'),
    ],
    'teen_leviathan_abyssal': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 1, targetSpeciesId: 'adult_sea_emperor'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_sea_serpent'),
    ],
    'teen_leviathan_lurker': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 3, targetSpeciesId: 'adult_sea_serpent'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_eel'),
    ],
    'teen_leviathan_bottomfeeder': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_eel'),
    ],
    'adult_sea_emperor': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_world_serpent'),
    ],
    'adult_sea_serpent': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_world_serpent'),
    ],
    'adult_eel': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_world_serpent'),
    ],
    'senior_world_serpent': [
      const EvolutionRule(phaseRequired: OntogenicPhase.spirit, maxCareMistakes: 99, targetSpeciesId: 'spirit_ocean_current'),
    ],

    // --- Línea Evolutiva: Basilisco ---
    'egg_basilisk': [
      const EvolutionRule(phaseRequired: OntogenicPhase.baby, maxCareMistakes: 99, targetSpeciesId: 'baby_lizard'),
    ],
    'baby_lizard': [
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 2, targetSpeciesId: 'child_basilisk_crystal'),
      const EvolutionRule(phaseRequired: OntogenicPhase.child, maxCareMistakes: 99, targetSpeciesId: 'child_basilisk_venom'),
    ],
    'child_basilisk_crystal': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 3, targetSpeciesId: 'teen_basilisk_gorgon'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_basilisk_viper'),
    ],
    'child_basilisk_venom': [
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 5, targetSpeciesId: 'teen_basilisk_viper'),
      const EvolutionRule(phaseRequired: OntogenicPhase.teenager, maxCareMistakes: 99, targetSpeciesId: 'teen_basilisk_crawler'),
    ],
    'teen_basilisk_gorgon': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 1, targetSpeciesId: 'adult_titan_basilisk'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_cockatrice'),
    ],
    'teen_basilisk_viper': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 3, targetSpeciesId: 'adult_cockatrice'),
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_stone_snake'),
    ],
    'teen_basilisk_crawler': [
      const EvolutionRule(phaseRequired: OntogenicPhase.adult, maxCareMistakes: 99, targetSpeciesId: 'adult_stone_snake'),
    ],
    'adult_titan_basilisk': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_petrified_king'),
    ],
    'adult_cockatrice': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_petrified_king'),
    ],
    'adult_stone_snake': [
      const EvolutionRule(phaseRequired: OntogenicPhase.senior, maxCareMistakes: 99, targetSpeciesId: 'senior_petrified_king'),
    ],
    'senior_petrified_king': [
      const EvolutionRule(phaseRequired: OntogenicPhase.spirit, maxCareMistakes: 99, targetSpeciesId: 'spirit_dust_wraith'),
    ],
  };

  static String getSpeciesName(String speciesId) {
    final egg = initialEggs.where((e) => e.id == speciesId).firstOrNull;
    if (egg != null) return egg.name;

    final formatted = speciesId.replaceAll('_', ' ');
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  static String? checkEvolution(String currentSpeciesId, OntogenicPhase nextPhase, int currentCareMistakes) {
    final rules = _evolutionMap[currentSpeciesId];
    if (rules == null || rules.isEmpty) return null;

    final phaseRules = rules.where((rule) => rule.phaseRequired == nextPhase).toList();
    if (phaseRules.isEmpty) return null;

    phaseRules.sort((a, b) => a.maxCareMistakes.compareTo(b.maxCareMistakes));

    for (final rule in phaseRules) {
      if (currentCareMistakes <= rule.maxCareMistakes) {
        return rule.targetSpeciesId;
      }
    }

    return phaseRules.last.targetSpeciesId;
  }
}