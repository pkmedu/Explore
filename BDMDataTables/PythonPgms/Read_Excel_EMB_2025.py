# -*- coding: utf-8 -*-
"""
Created on Tue Mar 17 16:26:13 2026

@author: muhuri
"""


# Python 3 script
import pandas as pd
import saspy
import os

# 1️⃣ SAS session (adjust your SASPy config)
sas = saspy.SASsession(cfgname='winlocal')  # use your SAS config

# 2️⃣ Excel file path
excel_file = r'C:\Explore\BDMDataTables\ExcelData\Original_EMB_rev_2025.xlsx'

# 3️⃣ List of sheets to import (e.g., Table2 through Table72)
sheet_numbers = range(2, 73)  # 2 to 72 inclusive

# 4️⃣ List to collect dataframes
df_list = []

for num in sheet_numbers:
    sheet_name = f'Table {num}'
    
    # Read sheet with pandas, preserve all text
    df = pd.read_excel(
        excel_file,
        sheet_name=sheet_name,
        dtype=str  # read all columns as string to prevent truncation
    )
    
    # Fill NaNs with empty string
    df = df.fillna('')
    
    # Normalize multi-line cells in i_date (replace line breaks with space)
    if 'i_date' in df.columns:
        df['i_date'] = df['i_date'].str.replace(r'[\r\n]+', ' ', regex=True).str.strip()
    
    df_list.append(df)

# 5️⃣ Combine all sheets into a single dataframe
combined_df = pd.concat(df_list, ignore_index=True)

# Dictionary of Bangladesh districts and common variants
district_dict = {
    'Bagerhat': ['bagerhat'],
    'Bandarban': ['bandarban'],
    'Barguna': ['barguna'],
    'Barishal': ['barishal', 'barisal'],
    'Bhola': ['bhola'],
    'Bogura': ['bogura', 'bogra'],
    'Brahmanbaria': ['brahmanbaria'],
    'Chandpur': ['chandpur'],
    'Chapainawabganj':['chapainawabganj'],
    'Chattogram': ['chattogram', 'chittagong'],
    'Chuadanga': ['chuadanga'],
    'Cumilla': ['cumilla', 'comilla'],
    'Coxs Bazar': ["cox's bazar", 'coxs bazar', 'cox bazar'],
    'Dhaka': ['dhaka'],
    'Dinajpur': ['dinajpur'],
    'Faridpur': ['faridpur'],
    'Feni': ['feni'],
    'Gaibandha': ['gaibandha'],
    'Gazipur': ['gazipur'],
    'Gopalganj': ['gopalganj'],
    'Habiganj': ['habiganj'],
    'Jamalpur': ['jamalpur'],
    'Jashore': ['jashore', 'jessore'],
    'Jhalokati': ['jhalokati', 'jhalakathi'],
    'Jhenaidah': ['jhenaidah'],
    'Joypurhat': ['joypurhat', 'jaipurhat'],
    'Khagrachari': ['khagrachari'],
    'Khulna': ['khulna'],
    'Kishoreganj': ['kishoreganj'],
    'Kurigram': ['kurigram'],
    'Kushtia': ['kushtia'],
    'Lakshmipur': ['lakshmipur', 'laxmipur'],
    'Lalmonirhat': ['lalmonirhat'],
    'Madaripur': ['madaripur'],
    'Magura': ['magura'],
    'Manikganj': ['manikganj'],
    'Meherpur': ['meherpur'],
    'Moulvibazar': ['moulvibazar', 'maulvibazar'],
    'Munshiganj': ['munshiganj'],
    'Mymensingh': ['mymensingh'],
    'Naogaon': ['naogaon'],
    'Narail': ['narail'],
    'Narayanganj': ['narayanganj'],
    'Narsingdi': ['narsingdi'],
    'Natore': ['natore'],
    'Netrokona': ['netrokona', 'netrakona'],
    'Nilphamari': ['nilphamari'],
    'Noakhali': ['noakhali'],
    'Pabna': ['pabna'],
    'Panchagarh': ['panchagarh'],
    'Patuakhali': ['patuakhali'],
    'Pirojpur': ['pirojpur'],
    'Rajbari': ['rajbari'],
    'Rajshahi': ['rajshahi'],
    'Rangamati': ['rangamati'],
    'Rangpur': ['rangpur'],
    'Satkhira': ['satkhira'],
    'Shariatpur': ['shariatpur'],
    'Sherpur': ['sherpur'],
    'Sirajganj': ['sirajganj'],
    'Sunamganj': ['sunamganj'],
    'Sylhet': ['sylhet'],
    'Tangail': ['tangail'],
    'Thakurgaon': ['thakurgaon']
}

# Function to identify district from i_loc
def get_district(location):
    if pd.isna(location):
        return ''

    location = str(location).lower()

    for district, variants in district_dict.items():
        for variant in variants:
            if variant in location:
                return district

    return 'Unknown'

# Create district variable
combined_df['district'] = combined_df['i_loc'].apply(get_district)

# 6️⃣ Optional: reorder or rename columns to match SAS expectation
combined_df = combined_df[['i_sn', 'district', 'i_loc', 'i_date', 'i_description', 'i_info_s']]


sas.submit(r"""
libname mydata 'C:\Explore\BDMDataTables\SASData';
""")
# 7️⃣ Send dataframe to SAS
sas_df = sas.df2sd(combined_df, table='EMB_2025', libref='MYDATA', temp=False)

print("Data successfully imported into SAS MYDATA.EMB")