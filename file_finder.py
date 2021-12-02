import os
import pprint
import json 

CUSTOMER_REGION = {
    'Bauwald': ['Duttenstein'],
    'Center-Forst': ['Baumbach', 'Immergruen', 'Weide'],
    'Fugger': ['Wellenburg', 'Babenhausen', 'MarktWald'],
    'HofosOldershausen': ['Muenzenberg', 'Fienerode', 'Breitenbach'],
    'Toerring-Jettenbach': ['Gutenzell', 'Dünzelbach', 'Inning', 'Jettenbach', 'Mischenried', 'Poernbach', 'Seefeld', 'Winhoering'],
    'Wallerstein': ['Dist_12_13'],
    'GrafSpreti': ['Lotzbeck'],
    'Boscor': ['Loewenstein', 'Reitzenstein', 'Rentweinsdorf'],
    'VonPfuel': ['Tüssling'],
    'LucasVonFuerstenberg': ['Brabecke', 'Ruespe']
}

REGIONS = ['Duttenstein', 'Baumbach', 'Immergruen', 'Weide', 'Wellenburg', 'Babenhausen', 'MarktWald', 'Muenzenberg', 'Fienerode', 'Breitenbach', 'Gutenzell', 'Dünzelbach',
           'Inning', 'Jettenbach', 'Mischenried', 'Poernbach', 'Seefeld', 'Winhoering', 'Dist_12_13', 'Lotzbeck', 'Loewenstein', 'Reitzenstein', 'Rentweinsdorf', 'Tuessling', 'Brabecke', 'Ruespe']


def find_URLs(start_path):

    customer_region_files_dict = {}

    for root, dirs, files in os.walk(start_path):
        if ('app_import' in root) and ('temp' not in root) and (any(x in root for x in REGIONS)) and ('old' not in root)  and ('OLD' not in root):
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
                file_type = ''
                if 'general_areas' in f and f.endswith(".geojson"):
                    file_type = 'general_areas'
                    
                elif 'tree_type_infos' in f and f.endswith(".geojson"):
                    file_type = 'tree_type_infos'

                elif 'plot_areas' in f and f.endswith(".geojson"):
                    file_type = 'plot_areas'

                elif 'roads' in f and f.endswith(".geojson"):
                    file_type = 'roads'

                elif 'offline_regions' in f and f.endswith(".geojson"):
                    file_type = 'offline_regions'

                elif 'hunting_districts' in f and f.endswith(".geojson"):
                    file_type = 'hunting_districts'
                 
                elif 'site_map' in f and f.endswith(".geojson"):
                    file_type = 'site_map'
  
                if file_type != '':
                    current_entry = customer_region_files_dict[customer][region][file_type]
                    if current_entry == '':
                        customer_region_files_dict[customer][region][file_type] = root + '/' + str(f)
                    else:
                        new_version_1 = f.split('.')[0][-1]
                        new_version_2 = f.split('.')[0][-2:]
                        old_version_1 = current_entry.split('.')[0][-1]
                        old_version_2 = current_entry.split('.')[0][-2:]

                        if new_version_2.isdigit():
                            if old_version_2.isdigit():
                                if int(new_version_2) > int(old_version_2):
                                    customer_region_files_dict[customer][region][file_type] = root + '/' + str(f)
                            elif old_version_1.isdigit():
                                if int(new_version_2) > int(old_version_1):
                                    customer_region_files_dict[customer][region][file_type] = root + '/' + str(f)  
                        elif new_version_1.isdigit():
                            if old_version_2.isdigit():
                                if int(new_version_1) > int(old_version_2):
                                    customer_region_files_dict[customer][region][file_type] = root + '/' + str(f)
                            elif old_version_1.isdigit():
                                if int(new_version_1) > int(old_version_1):
                                    customer_region_files_dict[customer][region][file_type] = root + '/' + str(f) 

    return customer_region_files_dict


if __name__ == '__main__':
    start_path = '/mnt/nas/gis_data/customers'
    customer_region_files_dict = find_URLs(start_path)

    with open('files.json', 'w') as fp:
        json.dump(customer_region_files_dict, fp)
