import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:dynamic_forest/data/models/feature_schema.dart';
import 'package:dynamic_forest/util/application_constants.dart';

//POINT
Map<String, String> symbolTypes = {
  'Hochsitz': 'assets/symbols/object_high-seat_80x114px.png',
  'Kalamität': 'assets/symbols/object_calamity_80x114px.png',
  'Wertholz': 'assets/symbols/object_quality-wood_80x114px.png',
  'Polter': 'assets/symbols/object_polter_80x114px.png',
  'FE-Kontrollpunkt': 'assets/symbols/object_control-point_80x114px.png',
  'Infopunkt': 'assets/symbols/object_info-point_80x114px.png',
  'Rettungspunkt': 'assets/symbols/object_rescue-point_80x114px.png',
  'Grenzpunkt': 'assets/symbols/object_border-point_80x114px.png',
};

// LineString
Map<String, String> lineTypes = {
  'LkW-Straße': 'assets/symbols/object_truck-road-line_80x110px.png',
  'Forstweg': 'assets/symbols/object_forest-road-line_80x83px.png',
  'Rückegasse': 'assets/symbols/object_back-path-line_80x49px.png'
};

Map<String, String> typeToIcon = {
  ...symbolTypes,
  ...lineTypes,
  'Teilfläche': 'assets/symbols/object_subarea-multipolygon_71x114px.png'
};

Map<String, dynamic> objectTypesTranslations = {
  'en': {
    'FE-Kontrollpunkt': 'FE-Controll point',
    'Kalamität': 'Calamity',
    'Polter': 'Rumble',
    'Teilfläche': 'Partial area'
  },
  'de': {
    'FE-Kontrollpunkt': 'FE-Kontrollpunkt',
    'Kalamität': 'Kalamität',
    'Polter': 'Polter',
    'Teilfläche': 'Teilfläche'
  }
};

final _baumarten = <String>[
  'Fichte',
  'Kiefer',
  'Lärche',
  'Douglasie',
  'Buche',
  'Tanne',
  'Eiche',
  'Andere Nadelh',
  'Andere Laubh'
];

final _lineObjectStatus = <String>[
  'geplant',
  'ganzjährig befahrbar',
  'bedingt befahrbar',
  'nicht befahrbar'
];

final _calamity = FeatureSchema((b) => b
  ..objectId = 'SJI9d82ksd'
  ..geometryType = 'Point'
  ..type = 'Kalamität'
  ..nameField = 'Art'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Status': {
        'type': 'string',
        'enum': [
          'Gefunden',
          'Geschlagen',
          'Gerückt',
        ],
        'default': 'Gefunden',
        'pinned': true
      },
      'Erfassungszeitpunkt': {
        'type': 'date-time',
        'dateFormat': 'yMd',
        'pinned': true,
      },
      'Art': {
        'type': 'string',
        'enum': [
          'Käferbefall',
          'Windwurf',
          'Schneebruch',
          'Andere',
        ],
        'pinned': true,
      },
      'Anzahl': {'type': 'integer'},
      'Menge': {'type': 'number', 'unit': 'm**3', 'unitName': 'Efm'},
      'Baumart': {'type': 'string', 'enum': _baumarten},
      'l10n': {
        'en': {
          'Kalamität': 'Calamity',
          'Gefunden': 'Found',
          'Geschlagen': 'Beaten',
          'Gerückt': 'Moved',
          'Menge': 'Lot',
          'Erfassungszeitpunkt': 'Acquisition time'
        },
        'de': {
          'Gefunden': 'Gefunden',
          'Geschlagen': 'Geschlagen',
          'Gerückt': 'Gerückt',
          'Menge': 'Menge',
          'Erfassungszeitpunkt': 'Erfassungszeitpunkt'
        },
      },
    }
  }));

final _qualityWood = FeatureSchema((b) => b
  ..objectId = 'TQI6w54gcd'
  ..geometryType = 'Point'
  ..type = 'Wertholz'
  ..nameField = 'Art'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Status': {
        'type': 'string',
        'enum': [
          'Gefunden',
          'Geschlagen',
          'Gerückt',
        ],
        'default': 'Gefunden',
        'pinned': true
      },
      'Erfassungsdatum': {
        'type': 'date-time',
        'dateFormat': 'yMd',
        'pinned': true,
      },
      'Baumart': {
        'type': 'string',
        'enum': _baumarten,
        'pinned': true,
      },
      'Spezifische_Baumart': {
        'type': 'string',
        'pinned': true,
      },
      'Anzahl': {'type': 'integer'},
      'Menge': {'type': 'number', 'unit': 'm**3', 'unitName': 'Efm'},
    }
  }));

final _huntingStand = FeatureSchema((b) => b
  ..objectId = 'purZhkOuTP'
  ..type = 'Hochsitz'
  ..geometryType = 'Point'
  ..nameField = 'Bezeichung'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Bezeichung': {'type': 'string'},
      'Zustand': {
        'type': 'string',
        'enum': ['Schlecht', 'Normal', 'Gut'],
        'pinned': true
      },
      'Beschreibung': {'type': 'string'}
    }
  }));

final _treeMarkings = FeatureSchema((b) => b
  ..objectId = 'ANOKhJ5B3o'
  ..type = 'Auszeichung'
  ..nameField = 'unique_key'
  ..userCreatable = false
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Ausgezeichnete_Menge': {'type': 'number', 'pinned': true, 'unit': 'Efm'},
      'Bemerkung': {'type': 'string'}
    }
  }));

final _treeStoragePoint = FeatureSchema((b) => b
  ..objectId = 'asd9SKDasf'
  ..geometryType = 'Point'
  ..type = 'Holzlagerplatz'
  ..nameField = 'Bezeichnung'
  ..userCreatable = false
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Bezeichnung': {'type': 'string'},
      'Bemerkung': {'type': 'string'}
    }
  }));

final _infoPoint = FeatureSchema((b) => b
  ..objectId = 'JDS8KSJDFM'
  ..geometryType = 'Point'
  ..type = 'Infopunkt'
  ..nameField = 'unique_key'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Bemerkung': {'type': 'string'},
      'l10n': {
        'en': {
          'Bemerkung': 'Comment',
        },
        'de': {
          'Bemerkung': 'Bemerkung',
        },
      },
    }
  }));

final _hint = FeatureSchema((b) => b
  ..objectId = 'K8jsh9SNDF'
  ..type = 'Bemerkung'
  ..nameField = 'unique_key'
  ..userCreatable = false
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Bemerkung': {'type': 'string'}
    }
  }));

final _heap = FeatureSchema((b) => b
  ..objectId = 'JSHhshsSS'
  ..geometryType = 'Point'
  ..type = 'Polter'
  ..nameField = 'Polternummer'
  ..userCreatable = false
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Polternummer': {
        'type': 'string',
        'pinned': true,
      },
      'Losnummer': {
        'type': 'string',
        'pinned': true,
      },
      'Status': {
        'type': 'string',
        'enum': [
          'Nicht verkauft',
          'Verkauft',
          'Abgeholt',
        ],
        'default': 'Nicht verkauft'
      },
      'Baumart': {
        'type': 'string',
        'enum': _baumarten,
        'pinned': true,
      },
      'Sorte': {
        'type': 'string',
        'enum': [
          'Langholz - L',
          'Abschnitte - LAS',
          'Papierholz - IS',
          'Palette - PAL',
          'Gemischt'
        ]
      },
      'Schätzvolumen': {
        'type': 'number',
        'unit': 'm**3',
        'unitName': 'Fm',
        'pinned': true,
      },
      'Schätzmenge': {
        'type': 'number',
        'unit': 'm**3',
        'unitName': 'Rm',
      },
      'Begiftet': {
        'type': 'string',
        'enum': [
          'Ja',
          'Nein',
        ]
      },
      'Stammlänge': {'type': 'number', 'unit': 'm'},
      'Güte': {
        'type': 'string',
        'enum': [
          'B/C',
          'Cgw',
          'F',
          'TF',
        ]
      },
      'Stückzahl': {
        'type': 'integer',
      },
      'Kalamität': {
        'type': 'string',
        'enum': ['Stark', 'Normal', 'Wenig'],
        'default': 'Normal'
      },
      'Käufer': {
        'type': 'string',
        'pinned': true,
      },
      'Menge_Werksmaß': {
        'type': 'number',
        'unit': 'm**3',
        'unitName': 'Rm',
        'pinned': true,
      },
      'Volumen_Werksmaß': {
        'type': 'number',
        'unit': 'm**3',
        'unitName': 'Fm',
      },
      'Bemerkung': {'type': 'string'},
      'l10n': {
        'en': {
          'Polter': 'Rumble',
        },
        'de': {
          'Polter': 'Polter',
        },
      },
    }
  }));

final _checkPoint = FeatureSchema((b) => b
  ..objectId = 'sAwYBOHefu'
  ..geometryType = 'Point'
  ..type = 'FE-Kontrollpunkt'
  ..nameField = 'ID'
  ..childTypes.addAll(['Baumart_am_KP', 'Messung_am_KP'])
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'ID': {
        'type': 'string',
        'pinned': true,
      },
      'Mittlere_Dichte': {
        'type': 'number',
        'unitName': 'Bäume/ha',
        'pinned': true,
      },
      'FE_Baumartsinformation_zutreffend': {
        'type': 'bool',
      },
      'Bestandsgrenze_passend': {
        'type': 'bool',
      },
      'Status': {
        'type': 'string',
        'enum': ['Ausstehend', 'Aufgenommen']
      },
      'Bemerkung': {
        'type': 'string',
      },
      'l10n': {
        'en': {
          'FE-Kontrollpunkt': 'FE-Controll Point',
          'Bemerkung': 'Comment',
          'Bestandsgrenze_passend': 'Stock limit suitable',
          'Mittlere_Dichte': 'Medium density'
        },
        'de': {
          'FE-Kontrollpunkt': 'FE-Kontrollpunkt',
          'Bemerkung': 'Bemerkung',
          'Bestandsgrenze_passend': 'Bestandsgrenze passend',
          'Mittlere_Dichte': 'Mittlere Dichte'
        },
      },
    }
  }));

final _checkPointTreeType = FeatureSchema((b) => b
  ..objectId = 'AQCWhNvXIU'
  ..type = 'Baumart_am_KP'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Bestandesschicht': {
        'type': 'string',
        'enum': [
          //todo add type 4
          'Hauptbestand',
          'Unterstand',
          'Oberstand',
        ],
      },
      'Baumart': {
        'type': 'string',
        'enum': _baumarten,
        'pinned': true,
      },
      'Alter': {
        'type': 'date-time',
        'dateFormat': 'y',
        'unitName': 'Jahre',
        'isAge': true,
        'pinned': true,
      },
      'Mittelhöhe': {'type': 'number', 'unit': 'm'},
      'Oberhöhe_im_Bestand': {'type': 'number', 'unit': 'm'},
      'Mittlerer_BHD': {'type': 'number', 'unit': 'cm'},
      'Vorrat': {'type': 'number', 'unitName': 'Efm/ha', 'pinned': true},
      'Ertragsklasse': {
        'type': 'integer',
      },
    }
  }));

final _checkPointMeasurement = FeatureSchema((b) => b
  ..objectId = 'Im265gqh3x'
  ..type = 'Messung_am_KP'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Bestandesschicht': {
        'type': 'string',
        'enum': [
          'Hauptbestand',
          'Unterstand',
          'Oberstand',
        ],
        'pinned': true,
      },
      'Baumart': {
        'type': 'string',
        'enum': _baumarten,
        'pinned': true,
      },
      'Bestandesgrundfläche': {'type': 'number', 'unitName': 'm^2/ha'},
      'BHD-1': {'type': 'number', 'unitName': 'cm'},
      'BHD-2': {'type': 'number', 'unitName': 'cm'},
      'BHD-3': {'type': 'number', 'unitName': 'cm'},
      'BHD-4': {'type': 'number', 'unitName': 'cm'},
      'BHD-5': {'type': 'number', 'unitName': 'cm'},
      'BHD-6': {'type': 'number', 'unitName': 'cm'},
      'BHD-7': {'type': 'number', 'unitName': 'cm'},
      'BHD-8': {'type': 'number', 'unitName': 'cm'},
      'BHD-9': {'type': 'number', 'unitName': 'cm'},
      'BHD-10': {'type': 'number', 'unitName': 'cm'},
      'BHD-11': {'type': 'number', 'unitName': 'cm'},
      'BHD-12': {'type': 'number', 'unitName': 'cm'},
      'BHD-13': {'type': 'number', 'unitName': 'cm'},
      'BHD-14': {'type': 'number', 'unitName': 'cm'},
      'BHD-15': {'type': 'number', 'unitName': 'cm'},
      'BHD-16': {'type': 'number', 'unitName': 'cm'},
      'BHD-17': {'type': 'number', 'unitName': 'cm'},
      'BHD-18': {'type': 'number', 'unitName': 'cm'},
      'BHD-19': {'type': 'number', 'unitName': 'cm'},
      'BHD-20': {'type': 'number', 'unitName': 'cm'},
    }
  }));

// POLYGONS
final _blankSpot = FeatureSchema((b) => b
  ..objectId = 'nlqm1vGc5G'
  ..geometryType = 'MultiPolygon'
  ..type = 'Blöße'
  ..nameField = 'Bezeichnung'
  ..userCreatable = false
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Bezeichnung': {'type': 'string'},
      'Enstehungsjahr': {
        'type': 'date-time',
        'dateFormat': 'y',
        'pinned': true,
      },
      'Bemerkung': {'type': 'string'}
    }
  }));

final treeTypes = {
  'Hauptbaumart': {
    'type': 'string',
    'enum': _baumarten,
  },
  'Anteil_Hauptbaumart': {'type': 'number', 'unit': '%'},
  'Stückzahl_Hauptbaumart': {'type': 'integer'},
  '1_Nebenbaumart': {
    'type': 'string',
    'enum': _baumarten,
  },
  'Anteil_1_Nebenbaumart': {'type': 'number', 'unit': '%'},
  'Stückzahl_1_Nebenbaumart': {'type': 'integer'},
  '2_Nebenbaumart': {
    'type': 'string',
    'enum': _baumarten,
  },
  'Anteil_2_Nebenbaumart': {'type': 'number', 'unit': '%'},
  'Stückzahl_2_Nebenbaumart': {'type': 'integer'},
  'Weitere_Baumarten': {'type': 'string'},
  'Bemerkung': {'type': 'string'}
};

final _cultureArea = FeatureSchema((b) => b
  ..objectId = 'FBsh12mnfa'
  ..geometryType = 'MultiPolygon'
  ..type = 'Kulturfläche'
  ..userCreatable = false
  ..nameField = 'Bezeichnung'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Bezeichnung': {'type': 'string'},
      'Enstehungsjahr': {
        'type': 'date-time',
        'dateFormat': 'y',
        'pinned': true,
      },
      'Stückzahl': {'type': 'integer'},
      'Schutzart': {
        'type': 'string',
        'enum': [
          'Einzelschutz',
          'Zaun',
          'Keine',
        ],
        'pinned': true,
      },
      'Abstand_zwischen_den_Reihen': {'type': 'number', 'unit': 'm'},
      'Abstand_in_den_Reihe': {'type': 'number', 'unit': 'm'},
      ...treeTypes
    }
  }));

final _rejuvenation = FeatureSchema((b) => b
  ..objectId = '910yjjRzQC'
  ..geometryType = 'MultiPolygon'
  ..type = 'Naturverjüngung'
  ..userCreatable = false
  ..nameField = 'Bezeichnung'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Bezeichnung': {'type': 'string'},
      'Enstehungsjahr': {
        'type': 'date-time',
        'dateFormat': 'y',
        'pinned': true,
      },
      ...treeTypes
    }
  }));

final _specialCareArea = FeatureSchema((b) => b
  ..objectId = 'QtXURh23hg'
  ..geometryType = 'MultiPolygon'
  ..type = 'Pflegebestand'
  ..userCreatable = false
  ..nameField = 'Bezeichnung'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Bezeichnung': {'type': 'string'},
      'Enstehungsjahr': {
        'type': 'date-time',
        'dateFormat': 'y',
        'pinned': true,
      },
      'Stückzahl': {'type': 'integer'},
      'Schutzart': {
        'type': 'string',
        'enum': [
          'Einzelschutz',
          'Zaun',
          'Keine',
        ],
        'pinned': true,
      },
      'Abstand_zwischen_den_Reihen': {'type': 'number', 'unit': 'm'},
      'Abstand_in_den_Reihe': {'type': 'number', 'unit': 'm'},
      ...treeTypes
    }
  }));

final _undergrowth = FeatureSchema((b) => b
  ..objectId = 's6vAHL00VM'
  ..geometryType = 'MultiPolygon'
  ..type = 'Unterstand'
  ..userCreatable = false
  ..nameField = 'Bezeichnung'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Bezeichnung': {'type': 'string'},
      'Alter': {
        'type': 'date-time',
        'dateFormat': 'y',
        'unitName': 'Jahre',
        'isAge': true,
        'pinned': true,
      },
      ...treeTypes
    }
  }));

final _overgrowth = FeatureSchema((b) => b
  ..objectId = 'sjsS812jsS'
  ..geometryType = 'MultiPolygon'
  ..nameField = 'Bezeichnung'
  ..type = 'Oberstand'
  ..userCreatable = false
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Bezeichnung': {'type': 'string'},
      'Alter': {
        'type': 'date-time',
        'dateFormat': 'y',
        'unitName': 'Jahre',
        'isAge': true,
        'pinned': true,
      },
      ...treeTypes
    }
  }));

final _planningBaseObject = {
  'Geschätzte_Arbeitsstunden': {'type': 'number', 'unit': 'h', 'pinned': true},
  'Kosten_pro_Arbeitsstunde': {'type': 'number', 'unit': '€/h'},
  'Flächenpauschale': {'type': 'number', 'unit': '€/ha'},
  'Förderung': {'type': 'number', 'unit': '€'},
  'Kommentar': {'type': 'string', 'pinned': true}
};

final _plan = FeatureSchema((b) => b
  ..objectId = 'aRuweutH7q'
  ..type = 'Planung'
  ..userCreatable = false
  ..json =
      MapJsonObject({'type': 'object', 'properties': _planningBaseObject}));

final _cuttingPlan = FeatureSchema((b) => b
  ..objectId = 'mEloaurE5j'
  ..geometryType = 'MultiPolygon'
  ..type = 'Einschlagsplanung'
  ..childTypes.add('Sorte')
  ..userCreatable = false
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Hiebsnummer': {
        'type': 'string',
        'pinned': true,
      },
      'Art_des_Einschlags': {
        'type': 'string',
        'enum': [
          'Vornutzung',
          'Endnutzung',
          'Gemischte Nutzung',
          'Kalamität',
        ],
        'pinned': true,
      },
      'Verfahren': {
        'type': 'string',
        'enum': [
          'Motormanuell',
          'Vollernter',
          'Selbstwerbung',
        ],
        'pinned': true,
      },
      'Gesamte_Planungsmenge': {
        'type': 'number',
        'pinned': true,
        'unit': 'Efm'
      },
      'Geplante_Erntekosten': {
        'type': 'number',
        'pinned': true,
        'unit': '€/fm'
      },
      ..._planningBaseObject
    }
  }));
final _treeSpecies = FeatureSchema((b) => b
  ..objectId = 'ks9fjsASls'
  ..geometryType = null
  ..type = 'Sorte'
  ..userCreatable = false
  ..userEditable = true
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Baumart': {
        'type': 'string',
        'enum': _baumarten,
        'pinned': true,
      },
      'Sorte': {
        'type': 'string',
        'enum': [
          'Stammholz - Abschnitte',
          'Stammholz - Langholz',
          'Stammholz - Masten',
          'Stammholz - Palette',
          'Stammholz - Parkett',
          'Industrieholz - Lang',
          'Industrieholz - Kurz',
          'Energieholz - Hackschnitzel',
          'Energieholz - Brennholz',
          'Energieholz - x-kurz'
        ],
        'pinned': true
      },
      'Länge': {'type': 'number', 'unit': 'm', 'pinned': true},
      'Planmenge': {'type': 'number', 'pinned': true, 'unit': 'Efm'},
    }
  }));

final _plotArea = FeatureSchema((b) => b
  ..objectId = 'Sw41GUV8GK'
  ..geometryType = 'MultiPolygon'
  ..type = 'Flurstück'
  ..nameField = 'Flurstücknummer'
  ..userCreatable = false
  ..userEditable = false
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Gemarkungsnummer': {
        'type': 'string',
        'pinned': true,
      },
      'Eigentümer': {
        'type': 'string',
        'pinned': true,
      },
      'Gemarkung': {
        'type': 'string',
        'pinned': true,
      },
      'Flurstücknummer': {
        'type': 'string',
      },
      'Zuordnung': {
        'type': 'string',
        'enum': [
          'Privat',
          'Forstwirtschaft',
          'Landwirtschaft',
          'Landw & Forstw',
          'Andere'
        ]
      }
    }
  }));

final _standort = FeatureSchema((b) => b
  ..objectId = 'ILjYQKshAX'
  ..geometryType = 'MultiPolygon'
  ..type = 'Standort'
  ..userCreatable = false
  ..userEditable = false
  ..json = MapJsonObject({'type': 'object', 'properties': {}}));

final _huntingArea = FeatureSchema((b) => b
  ..objectId = 'eA7LWTiydp'
  ..geometryType = 'MultiPolygon'
  ..type = 'Jagdrevier'
  ..userCreatable = false
  ..userEditable = false
  ..json = MapJsonObject({'type': 'object', 'properties': {}}));

final _rettungspunkt = FeatureSchema((b) => b
  ..objectId = 'QIUJwpJoao'
  ..geometryType = 'Point'
  ..type = 'Rettungspunkt'
  ..userCreatable = false
  ..userEditable = false
  ..json = MapJsonObject({'type': 'object', 'properties': {}}));

final _treeTypes = FeatureSchema((b) => b
  ..objectId = '01zyPCnQwR'
  ..geometryType = null
  ..userCreatable = false
  ..userEditable = false
  ..type = 'Baumart'
  ..nameField = 'Baumart'
  ..sortKeys.replace(['Bestandesschicht', 'Vorratsanteil', 'Anteil'])
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Baumart': {
        'type': 'string',
        'enum': _baumarten,
        'pinned': true,
      },
      'Spezifische_Baumart': {
        'type': 'string',
        'pinned': true,
      },
      'Bestandesschicht': {
        'type': 'string',
        'enum': ['Überhalt', 'Hauptbestand', 'Zwischenstand', 'Unterstand']
      },
      'Anteil': {'type': 'number', 'unitName': '%'},
      'Vorratsanteil': {
        'type': 'number',
        'unit': '%'
      }, // to be removed for app export
      'Alter': {
        'type': 'date-time',
        'dateFormat': 'y',
        'unitName': 'Jahre',
        'isAge': true,
      },
      'Wertklasse': {'type': 'number'},
      'Mittelhöhe': {'type': 'number', 'unit': 'm'},
      'Oberhöhe': {'type': 'number', 'unit': 'm'},
      'Mittlerer_BHD': {'type': 'number', 'unit': 'cm'},
      'Mittlerer_Vorrat': {'type': 'number', 'unitName': 'Efm/Baum'},
      'Vorrat': {
        'type': 'number',
        'unitName': 'Efm/ha'
      }, // to be removed for app export
      'Ist-Vorrat': {'type': 'number', 'unitName': 'Efm/ha'},
      'Zuwachs': {'type': 'number', 'unitName': 'Efm/ha/Jahr'},
      'Gepflanzte_Stückzahl': {'type': 'number'},
      'Schutzart_der_Kultur': {
        'type': 'string',
        'enum': ['Einzelschutz', 'Zaun', 'Keiner']
      },
      'Bestockte_Fläche': {'type': 'number', 'unit': '%'},
    }
  }));

final _forestAreas = FeatureSchema((b) => b
  ..objectId = '123ffkdsf3'
  ..geometryType = 'MultiPolygon'
  ..userCreatable = false
  ..userEditable = false
  ..type = 'Bestand'
  ..childTypes.add('Baumart')
  ..nameField = 'Flächen_ID'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Flächen_ID': {'type': 'string'},
      'Distrikt': {'type': 'number'},
      'Distriktsname': {'type': 'string'},
      'Abteilung': {'type': 'number'},
      'Abteilungsname': {'type': 'string'},
      'Nutzungsart': {
        'type': 'string',
        'enum': [
          'Blöße',
          'Jungbestandspflege (JP)',
          'Jungdurchforstung (JD)',
          'Altdurchforstung (AD)',
          'Verjüngungsnutzung (VJ)',
          'Gesicherte Vorausverjüngung (VJ)',
          'Langfristige Behandlung (LB)'
        ],
        'pinned': true
      }, // no enum, since for non-forest other values are possible (Wiese, etc)
      'Hauptbaumart': {'type': 'string', 'enum': _baumarten, 'pinned': true},
      'HBA-Altersklasse': {
        'type': 'string',
        'enum': [
          '0-20',
          '21-40',
          '41-60',
          '61-80',
          '81-100',
          '101-120',
          '121-140',
          '141-160',
          '161-180',
          '>180',
        ],
        'pinned': true
      },
      'Nebenbaumart': {'type': 'string', 'enum': _baumarten, 'pinned': true},
      'Fläche': {'type': 'number', 'unitName': 'ha'},
      'Oberhöhe': {'type': 'number', 'unit': 'm', 'pinned': true},
      'Ist-Vorrat': {'type': 'number', 'unitName': 'Efm/ha', 'pinned': true},
      'Pflegeblock': {'type': 'string'},
      'Mittelhöhe': {'type': 'number', 'unit': 'm'},
      'Mittlere_Dichte': {'type': 'number', 'unitName': 'Bäume/ha'},
      'Zuwachs': {'type': 'number', 'unitName': 'Efm/ha/Jahr'},
      'Schaden': {'type': 'string'},
      'Nächster_Waldbaul_Eingriff': {
        'type': 'date-time',
        'dateFormat': 'yMd',
        'isAge': false
      },
      'Waldbaul_Behandlung': {'type': 'string'},
      'Waldbaul_Eingriffsstärke': {
        'type': 'number',
        'unitName': 'Efm/ha',
      },
      'Mittlerer_Vorrat': {'type': 'number', 'unitName': 'Efm'},
    },
  }));

final _offlineRegion = FeatureSchema((b) => b
  ..objectId = '8fjd9SkiLL'
  ..geometryType = 'MultiPolygon'
  ..type = FeatureTypes.offlineRegion
  ..nameField = 'name'
  ..userCreatable = false
  ..userEditable = false
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'name': {'type': 'string'}
    }
  }));

final _protected = FeatureSchema((b) => b
  ..objectId = 'hdXI5Wq4BO'
  ..geometryType = 'MultiPolygon'
  ..type = 'Schutzzone'
  ..nameField = 'Flächen_ID'
  ..userCreatable = false
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Flächen_ID': {'type': 'string'},
      'Art_der_Schutzzone': {'type': 'string'}
    }
  }));

final _subArea = FeatureSchema((b) => b
  ..objectId = '7IpKVBbEKd'
  ..geometryType = 'MultiPolygon'
  ..childTypes.add('Baumart')
  ..type = 'Teilfläche'
  ..nameField = 'Flächen_ID'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Flächen_ID': {'type': 'string'},
      'Nutzungsart': {
        'type': 'string',
        'enum': [
          'Blöße',
          'Jungbestandspflege (JP)',
          'Jungdurchforstung (JD)',
          'Altdurchforstung (AD)',
          'Verjüngungsnutzung (VJ)',
          'Gesicherte Vorausverjüngung (VJ)',
          'Langfristige Behandlung (LB)'
        ],
        'pinned': true,
      },
      'Entstehungsjahr': {
        'type': 'date-time',
        'dateFormat': 'y',
        'pinned': true,
      },
      'l10n': {
        'en': {
          'Teilfläche': 'Partial area',
        },
        'de': {
          'Teilfläche': 'Teilfläche',
        },
      },
    }
  }));

final _plantingPlan = FeatureSchema((b) => b
  ..objectId = 'fMD2NsG8oA'
  ..geometryType = 'MultiPolygon'
  ..type = 'Kulturplan'
  ..childTypes.add('Kulturbaumart')
  ..userCreatable = false
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {..._planningBaseObject},
  }));

final _plantingSpecies = FeatureSchema((b) => b
  ..objectId = 'LTrAnWyha5'
  ..type = 'Kulturbaumart'
  ..userCreatable = false
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Baumart': {
        'type': 'string',
        'enum': _baumarten,
        'pinned': true,
      },
      'Spezifische_Baumart': {
        'type': 'string',
        'pinned': true,
      },
      'Geplante_Stückzahl': {
        'type': 'integer',
        'pinned': true,
      },
      'Schutzart': {
        'type': 'string',
        'enum': [
          'Einzelschutz',
          'Zaun',
          'Keine',
        ],
        'pinned': true,
      },
      'Kosten_pro_Pflanze': {'type': 'number', 'unit': '€'},
      'Abstand_zwischen_den_Reihen': {
        'type': 'number',
        'pinned': true,
        'unit': 'm'
      },
      'Abstand_in_der_Reihe': {'type': 'number', 'pinned': true, 'unit': 'm'},
    }
  }));

final _lkwStrasse = FeatureSchema((b) => b
  ..objectId = 'JLK5KSHDFN'
  ..geometryType = 'LineString'
  ..type = 'LkW-Straße'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Status': {'type': 'string', 'enum': _lineObjectStatus},
      'Bemerkung': {'type': 'string'}
    }
  }));

final _forstweg = FeatureSchema((b) => b
  ..objectId = 'GHK2KLMDRN'
  ..geometryType = 'LineString'
  ..type = 'Forstweg'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Status': {'type': 'string', 'enum': _lineObjectStatus},
      'Bemerkung': {'type': 'string'}
    }
  }));

final _ruckegasse = FeatureSchema((b) => b
  ..objectId = 'ORD1JDMRTN'
  ..geometryType = 'LineString'
  ..type = 'Rückegasse'
  ..json = MapJsonObject({
    'type': 'object',
    'properties': {
      'Status': {'type': 'string', 'enum': _lineObjectStatus},
      'Bemerkung': {'type': 'string'}
    }
  }));

final _schemas = <FeatureSchema>[
  _forestAreas,
  _subArea,
  _plotArea,
  _calamity,
  _qualityWood,
  _huntingStand,
  _infoPoint,
  _heap,
  _checkPoint,
  _treeMarkings,
  _treeStoragePoint,
  _hint,
  _checkPointTreeType,
  _checkPointMeasurement,
  _blankSpot,
  _cultureArea,
  _rejuvenation,
  _specialCareArea,
  _undergrowth,
  _overgrowth,
  _plan,
  _cuttingPlan,
  _offlineRegion,
  _treeSpecies,
  _protected,
  _plantingPlan,
  _plantingSpecies,
  _treeTypes,
  _standort,
  _huntingArea,
  _rettungspunkt,
  _lkwStrasse,
  _forstweg,
  _ruckegasse,
];

List<MapEntry<String, FeatureSchema>> _toEntries(List<FeatureSchema> schemas) {
  assert(schemas.map((e) => e.objectId).toSet().length == schemas.length);
  return [for (final schema in schemas) MapEntry(schema.objectId, schema)];
}

final defaultSchemas =
    BuiltMap<String, FeatureSchema>.from({}..addEntries(_toEntries(_schemas)));
