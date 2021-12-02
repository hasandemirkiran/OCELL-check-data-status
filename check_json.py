import geojson
import json
import pprint


def check_general_areas(file):

    file_name = file.split('/')[-1]

    nutzungsart = ['Blöße',
                   'Jungbestandspflege (JP)',
                   'Jungdurchforstung (JD)',
                   'Altdurchforstung (AD)',
                   'Verjüngungsnutzung (VJ)',
                   'Gesicherte Vorausverjüngung (VJ)',
                   'Langfristige Behandlung (LB)']

    result = {
        'number_of_features':  0,
        'lack_Flächen_ID': 0,
        'lack_Abteilung': 0,
        'lack_Nutzungsart': 0,
        'wrong_Nutzungsart': 0,
        'lack_Hauptbaumart': 0,
        'lack_Altersklasse': 0,
        'lack_Oberhöhe': 0,
        'lack_Ist-Vorrat': 0,
        'lack_Mittelhöhe': 0,
        'lack_Bestockte_Fläche': 0,
    }

    with open(file) as f:
        gj = geojson.load(f)
    features = gj['features']

    result['number_of_features'] = len(features)

    for feature in features:
        properties = feature['properties']
        if 'Flächen_ID' not in properties:
            result['lack_Flächen_ID'] += 1
        if 'Abteilung' not in properties:
            result['lack_Abteilung'] += 1
        if 'Nutzungsart' not in properties:
            result['lack_Nutzungsart'] += 1
        if 'Nutzungsart' in properties and 'Flächentyp' not in properties:
            if properties['Nutzungsart'] != "Blöße" :
                if properties['Nutzungsart'] not in nutzungsart:
                    result['wrong_Nutzungsart'] += 1
                if 'Hauptbaumart' not in properties:
                    result['lack_Hauptbaumart'] += 1
                if 'Altersklasse' not in properties:
                    result['lack_Altersklasse'] += 1
                if 'Oberhöhe' not in properties:
                    result['lack_Oberhöhe'] += 1
                if 'Ist-Vorrat' not in properties:
                    result['lack_Ist-Vorrat'] += 1
                if 'Mittelhöhe`' not in properties:
                    result['lack_Mittelhöhe'] += 1
                if '`Bestockte_Fläche`' not in properties:
                    result['lack_Bestockte_Fläche'] += 1

    return file_name, result


def check_tree_type_infos(file):
    file_name = file.split('/')[-1]

    result = {
        'number_of_features':  0,
        'Baumart': 0,
        'Bestandesschicht': 0,
        'Alter': 0,
        'Vorratsanteil': 0,
        'Mittelhöhe': 0,
        'Oberhöhe': 0,
        'Zuwachs': 0
    }

    with open(file) as f:
        gj = geojson.load(f)
    features = gj['features']

    result['number_of_features'] = len(features)

    for feature in features:
        properties = feature['properties']
        if 'Baumart' not in properties:
            result['Baumart'] += 1
        if 'Bestandesschicht' not in properties:
            result['Bestandesschicht'] += 1
        if 'Alter' not in properties:
            result['Alter'] += 1
        if 'Vorratsanteil' not in properties:
            result['Vorratsanteil'] += 1
        if 'Mittelhöhe' not in properties:
            result['Mittelhöhe'] += 1
        if 'Oberhöhe' not in properties:
            result['Oberhöhe'] += 1
        if 'Zuwachs' not in properties:
            result['Zuwachs'] += 1

    return file_name, result


def check_plot_areas(file):
    file_name = file.split('/')[-1]

    result = {
        'number_of_features':  0,
        'Gemarkungsnummer':  0,
        'Eigentümer': 0,
        'Gemarkung': 0,
        'Flurstücknummer': 0,
        'Zuordnung': 0,
    }

    with open(file) as f:
        gj = geojson.load(f)
    features = gj['features']

    result['number_of_features'] = len(features)

    for feature in features:
        properties = feature['properties']
        if 'Gemarkungsnummer' not in properties:
            result['Gemarkungsnummer'] += 1
        if 'Eigentümer' not in properties:
            result['Eigentümer'] += 1
        if 'Gemarkung' not in properties:
            result['Gemarkung'] += 1
        if 'Flurstücknummer' not in properties:
            result['Flurstücknummer'] += 1
        if 'Zuordnung' not in properties:
            result['Zuordnung'] += 1

    return file_name, result


def check_offline_region(file):
    return


if __name__ == '__main__':

    with open('files.json') as f:
        data = json.load(f)

    for customer in data:
        for region in data[customer]:
            if data[customer][region]['tree_type_infos'] != '':
                tree_type_infos = data[customer][region]['tree_type_infos']
                print(check_tree_type_infos(tree_type_infos))
