import json
import jsonschema
from jsonschema import validate

_baumarten = [
  'Fichte',
  'Kiefer',
  'Lärche',
  'Douglasie',
  'Buche',
  'Tanne',
  'Eiche',
  'Andere Nadelh',
  'Andere Laubh'
]

tree_types_schema = {
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
        'pinned': True
      },
      'Hauptbaumart': {'type': 'string', 'enum': _baumarten, 'pinned': True},
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
        'pinned': True
      },
      'Nebenbaumart': {'type': 'string', 'enum': _baumarten, 'pinned': True},
      'Fläche': {'type': 'number', 'unitName': 'ha'},
      'Oberhöhe': {'type': 'number', 'unit': 'm', 'pinned': True},
      'Ist-Vorrat': {'type': 'number', 'unitName': 'Efm/ha', 'pinned': True},
      'Pflegeblock': {'type': 'string'},
      'Mittelhöhe': {'type': 'number', 'unit': 'm'},
      'Mittlere_Dichte': {'type': 'number', 'unitName': 'Bäume/ha'},
      'Zuwachs': {'type': 'number', 'unitName': 'Efm/ha/Jahr'},
      'Schaden': {'type': 'string'},
      'Nächster_Waldbaul_Eingriff': {
        'type': 'date-time',
        'dateFormat': 'yMd',
        'isAge': False
      },
      'Waldbaul_Behandlung': {'type': 'string'},
      'Waldbaul_Eingriffsstärke': {
        'type': 'number',
        'unitName': 'Efm/ha',
      },
      'Mittlerer_Vorrat': {'type': 'number', 'unitName': 'Efm'},
    },
}


def validateJson(jsonData):
    try:
        validate(instance=jsonData, schema=tree_types_schema)
    except jsonschema.exceptions.ValidationError as err:
        return False
    return True

if __name__ == '__main__':

    with open('/mnt/nas/gis_data/customers/CenterForst/Baumbach/app_import/merged_tree_type_infos__Baumbach__v3.geojson') as f:
        data = json.load(f)

    isValid = validateJson(data)
