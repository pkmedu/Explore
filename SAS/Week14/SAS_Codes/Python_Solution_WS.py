#!/usr/bin/env python
# coding: utf-8

'''
https://www.lexjansen.com/cgi-bin/xsl_transform.php?x=SESUG2024
https://www.lexjansen.com/sesug/2024/43_Final_PDF.pdf

One Click to Create a List of MEPS-HC ZIP Files' Download URLs: Web
Scraping with SAS® and Python

Pradip K. Muhuri, Agency for Healthcare Research and Quality;
Charles Z.X. Han, Ryman Healthcare Ltd.;
John Vickery, North Carolina State University
'''
# **step 1**
# - note the python libraries/modules

# import libraries
import pandas as pd
import requests
from bs4 import BeautifulSoup
from urllib.parse import quote

# **step 2**
# - get the list of numerical year options from the main page
# - save as list of tuples with year and url

# main page response
main_page = requests.get("https://meps.ahrq.gov/data_stats/download_data_files.jsp")
main_soup = BeautifulSoup(main_page.text, "html.parser")

# get list of data years and links for each year
# skip the "All years" (i.e. non-digit options)
base_year_url = "https://meps.ahrq.gov/mepsweb/data_stats/download_data_files_results.jsp?cboDataYear="
year_url_suffix = "&buttonYearandDataType=Search"

year_options = main_soup.select_one('select[name="cboDataYear"]').select("option")

year_url_list = [
    (x.get("value"), base_year_url + quote(x.get("value")) + year_url_suffix)
    for x in year_options
    if x.get("value").isdigit()
]

# **step 3**
# - use the year_url_list list of tuples to get "HC-" zip file links
# - save these in list of dictionaries

base_hc_url = "https://meps.ahrq.gov/mepsweb/data_stats/download_data_files_detail.jsp?cboPufNumber="
zip_link_list = []
for year, year_url in year_url_list:
    try:
        response = requests.get(year_url)
        response.raise_for_status()
        try:
            dfs = pd.read_html(response.text)
            hc_df = pd.DataFrame()
            for df in dfs:
                if "File(s), Documentation & Codebooks" in df.columns:
                    hc_df = pd.concat([hc_df, df], ignore_index=True)
                    hc_df = hc_df.dropna(subset="PUF no.")
                    hc_df = hc_df.loc[hc_df["PUF no."].str.contains("HC-")]
                    hc_df = hc_df.drop_duplicates(subset="PUF no.")
                    hc_df["hc_url"] = base_hc_url + hc_df["PUF no."]
            if not hc_df.empty:
                hc_df.columns = [
                    "puf_num",
                    "Files",
                    "Data_Update",
                    "Year",
                    "File_Type",
                    "hc_url",
                ]
                for row in hc_df.itertuples():
                    hc_response = requests.get(row.hc_url)
                    hc_response.raise_for_status()
                    hc_soup = BeautifulSoup(hc_response.text, features="lxml")
                    try:
                        meps_file = hc_soup.find(class_="OrangeBox").text
                        for td in hc_soup.find_all("td"):
                            zip_link_dict = {}
                            if td.text.startswith("Data File"):
                                zip_link_dict["data_year"] = row.Year
                                zip_link_dict["puf_num"] = row.puf_num
                                zip_link_dict["meps_file"] = meps_file
                                zip_link_dict["file_format"] = td.text
                                zip_link_dict[
                                    "zip_link"
                                ] = "https://meps.ahrq.gov" + td.find_next("a").get(
                                    "href"
                                ).strip(
                                    ".."
                                )
                                zip_link_list.append(zip_link_dict)
                    except:
                        # Ignore any errors and continue processing the next file
                        pass
        except requests.exceptions.HTTPError as err:
            print(err)
    except requests.exceptions.HTTPError as httperr:
        print(httperr)

# **step 4**
# - save the list of dictionaries to pandas dataframe
# - deduplicate
# - clean up meps_file column to remove "PUF no." prefix
# - clean up file_format column to remove "Data File" prefix
# - sort the dataframe in certain order
# - get n rows of the dataframe

meps_df = pd.DataFrame(zip_link_list)
meps_df.drop_duplicates(inplace=True)
meps_df["meps_file"] = meps_df["meps_file"].str.split(": ", n=1).str[-1]
meps_df["file_format"] = meps_df["file_format"].str.split(", ", n=1).str[-1]
meps_df = meps_df.sort_values(by=['data_year','puf_num', 'file_format'], ascending=[False, True, True])
print(meps_df.head(5))

# **step 4 (continued)**
# - obtain the current date (timestamp)
# - save the dataframe as an excel file

today = pd.Timestamp("now").strftime("%Y-%m-%d")
meps_df.to_excel(f"C:\\Users\pmuhuri\\SASCourse\\Week14\\SAS_Codes\\Python_Solution_WS_{today}.xlsx", index=False)


