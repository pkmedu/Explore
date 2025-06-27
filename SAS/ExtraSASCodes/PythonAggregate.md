```Python
import pandas as pd

def runit(rname):
    # Load the dataset
    demographics = pd.read_csv('c:\\Data\sashelp_demographics.csv')  # Assuming the data is in a CSV format

    # Select distinct names based on the region
    clist = demographics[demographics['region'] == rname]['name'].unique()
    clist_str = ', '.join(clist)

    print("Providing values to the function call")
    print(f"NOTE: Processing region {rname}")
    print(f"{rname}_clist = {clist_str}")
    print(f"Number of countries for {rname}_clist = {len(clist)}")
    print(f"NOTE: End of region {rname} processing")
    print()

# Call the function for each region
for region in ['AFR', 'AMR', 'EMR', 'SEAR', 'WPR', 'EUR']:
    runit(region)
```
```Python
import pandas as pd

# Clear log and output (not applicable in Python)
# Clear ODS results (not applicable in Python)

# Load the dataset
demographics = pd.read_csv('c://Data//sashelp_demographics.csv')  # Assuming the data is in a CSV file

# Select distinct names for the AFR region
afr_clist = demographics[demographics['region'] == 'AFR']['name'].unique().tolist()

# Convert list to a comma-separated string
afr_clist_str = ','.join(afr_clist)

# Output the number of countries and the list
print(f"Number of countries for AFR_clist = {len(afr_clist)}")
print(f"AFR_clist = {afr_clist_str}")

```
