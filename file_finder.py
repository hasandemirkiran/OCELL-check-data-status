import os
import pprint
import json 

CUSTOMER_REGION = {
    'Bauwald': ['Duttenstein'],
    'Center-Forst': ['Baumbach', 'Immergruen', 'Weide'],
    'Fugger': ['Wellenburg', 'Babenhausen', 'MarktWald'],
    'Hofos': ['Muenzenberg', 'Fienerode', 'Breitenbach'],
    'Toerring-Jettenbach': ['Gutenzell', 'Dünzelbach', 'Inning', 'Jettenbach', 'Mischenried', 'Poernbach', 'Seefeld', 'Winhoering'],
    'Wallerstein': ['Dist_12_13'],
    'GrafSpreti': ['Lotzbeck'],
    'Boscor': ['Loewenstein', 'Reitzenstein', 'Rentweinsdorf'],
    'VonPfuel': ['Tüssling']
}

REGIONS = ['Duttenstein', 'Baumbach', 'Immergruen', 'Weide', 'Wellenburg', 'Babenhausen', 'MarktWald', 'Muenzenberg', 'Fienerode', 'Breitenbach', 'Gutenzell', 'Dünzelbach',
           'Inning', 'Jettenbach', 'Mischenried', 'Poernbach', 'Seefeld', 'Winhoering', 'Dist_12_13', 'Lotzbeck', 'Loewenstein', 'Reitzenstein', 'Rentweinsdorf', 'Tüssling']


def find_URLs(start_path):

    customer_region_files_dict = {}

    for root, dirs, files in os.walk(start_path):
        if ('app_import' in root) and ('temp' not in root) and (any(x in root for x in REGIONS)) and ('old' not in root) and ('Old' not in root) and ('OLD' not in root):
            customer = root.split('/')[-3]
            region = root.split('/')[-2]
            if customer not in customer_region_files_dict:
                customer_region_files_dict[customer] = {}
            files_types = {
                'general_areas': '',
                'tree_type_infos': '',
                'plot_areas': '',
                'roads': '',
                'offline_regions': '',
                'hunting_districts' : '',
                'site_map': ''
            }
            customer_region_files_dict[customer][region] = files_types

            for f in files:
                if 'general_areas' in f and f.endswith(".geojson"):
                    general_areas = customer_region_files_dict[customer][region]['general_areas']
                    if general_areas == '':
                        customer_region_files_dict[customer][region]['general_areas'] = str(f)
                    else:
                        new_version = f.split('.')[0][-1]
                        old_version = general_areas.split('.')[0][-1]
                        if new_version.isdigit():
                            if new_version > old_version:
                                customer_region_files_dict[customer][region]['general_areas'] = str(f)

                elif 'tree_type_infos' in f and f.endswith(".geojson"):
                    tree_type_infos = customer_region_files_dict[customer][region]['tree_type_infos']
                    if tree_type_infos == '':
                        customer_region_files_dict[customer][region]['tree_type_infos'] = str(f)
                    else:
                        new_version = f.split('.')[0][-1]
                        old_version = tree_type_infos.split('.')[0][-1]
                        if new_version.isdigit():
                            if new_version > old_version:
                                customer_region_files_dict[customer][region]['tree_type_infos'] = str(f)

                elif 'plot_areas' in f and f.endswith(".geojson"):
                    plot_areas = customer_region_files_dict[customer][region]['plot_areas']
                    if plot_areas == '':
                        customer_region_files_dict[customer][region]['plot_areas'] = str(f)
                    else:
                        new_version = f.split('.')[0][-1]
                        old_version = plot_areas.split('.')[0][-1]
                        if new_version.isdigit():
                            if new_version > old_version:
                                customer_region_files_dict[customer][region]['plot_areas'] = str(f)

                elif 'roads' in f and f.endswith(".geojson"):
                    roads = customer_region_files_dict[customer][region]['roads']
                    if roads == '':
                        customer_region_files_dict[customer][region]['roads'] = str(f)
                    else:
                        new_version = f.split('.')[0][-1]
                        old_version = roads.split('.')[0][-1]
                        if new_version.isdigit():
                            if new_version > old_version:
                                customer_region_files_dict[customer][region]['roads'] = str(f)

                elif 'offline_regions' in f and f.endswith(".geojson"):
                    offline_regions = customer_region_files_dict[customer][region]['offline_regions']
                    if offline_regions == '':
                        customer_region_files_dict[customer][region]['offline_regions'] = str(f)
                    else:
                        new_version = f.split('.')[0][-1]
                        old_version = offline_regions.split('.')[0][-1]
                        if new_version.isdigit():
                            if new_version > old_version:
                                customer_region_files_dict[customer][region]['offline_regions'] = str(f)

                elif 'hunting_districts' in f and f.endswith(".geojson"):
                    hunting_districts = customer_region_files_dict[customer][region]['hunting_districts']
                    if hunting_districts == '':
                        customer_region_files_dict[customer][region]['hunting_districts'] = str(f)
                    else:
                        new_version = f.split('.')[0][-1]
                        old_version = hunting_districts.split('.')[0][-1]
                        if new_version.isdigit():
                            if new_version > old_version:
                                customer_region_files_dict[customer][region]['hunting_districts'] = str(f)                  


                elif 'site_map' in f and f.endswith(".geojson"):
                    site_map = customer_region_files_dict[customer][region]['site_map']
                    if site_map == '':
                        customer_region_files_dict[customer][region]['site_map'] = str(f)
                    else:
                        new_version = f.split('.')[0][-1]
                        old_version = site_map.split('.')[0][-1]
                        if new_version.isdigit():
                            if new_version > old_version:
                                customer_region_files_dict[customer][region]['site_map'] = str(f)                              

    return customer_region_files_dict


if __name__ == '__main__':
    start_path = '/mnt/nas/gis_data/customers/'
    customer_region_files_dict = find_URLs(start_path)

    with open('files.json', 'w') as fp:
        json.dump(customer_region_files_dict, fp)
