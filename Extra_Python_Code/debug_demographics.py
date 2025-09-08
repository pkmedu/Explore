# -*- coding: utf-8 -*-
"""
Created on Mon Aug 11 15:49:55 2025

@author: muhuri
"""

# -*- coding: utf-8 -*-
"""
DEBUG VERSION - Religious Demographics Analysis
This version includes debug prints to identify where the script might be hanging
"""

print("🔧 DEBUG: Script starting...")

import sys
print(f"🔧 DEBUG: Python version: {sys.version}")

try:
    import pandas as pd
    print("🔧 DEBUG: pandas imported successfully")
except ImportError as e:
    print(f"❌ ERROR: Cannot import pandas: {e}")
    sys.exit(1)

try:
    import numpy as np
    print("🔧 DEBUG: numpy imported successfully")
except ImportError as e:
    print(f"❌ ERROR: Cannot import numpy: {e}")
    sys.exit(1)

try:
    import matplotlib.pyplot as plt
    print("🔧 DEBUG: matplotlib imported successfully")
except ImportError as e:
    print(f"❌ ERROR: Cannot import matplotlib: {e}")
    sys.exit(1)

try:
    import seaborn as sns
    print("🔧 DEBUG: seaborn imported successfully")
except ImportError as e:
    print(f"❌ ERROR: Cannot import seaborn: {e}")
    sys.exit(1)

try:
    from datetime import datetime
    import os
    print("🔧 DEBUG: datetime and os imported successfully")
except ImportError as e:
    print(f"❌ ERROR: Cannot import datetime/os: {e}")
    sys.exit(1)

print("🔧 DEBUG: Checking openpyxl availability...")
try:
    from openpyxl import Workbook
    from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
    from openpyxl.chart import LineChart, Reference
    OPENPYXL_AVAILABLE = True
    print("🔧 DEBUG: openpyxl available")
except ImportError:
    OPENPYXL_AVAILABLE = False
    print("🔧 DEBUG: openpyxl not available - will use pandas Excel writer")

print("🔧 DEBUG: Setting matplotlib style...")
# Set style for better looking plots
plt.style.use('default')
print("🔧 DEBUG: Matplotlib style set")

# Set color palette
colors = ['#2ecc71', '#e74c3c', '#f39c12', '#3498db', '#9b59b6', '#1abc9c']

# Define output directory
OUTPUT_DIR = r'C:\Data'
print(f"🔧 DEBUG: Output directory set to: {OUTPUT_DIR}")

def ensure_output_directory():
    """Create output directory if it doesn't exist"""
    print("🔧 DEBUG: Checking output directory...")
    if not os.path.exists(OUTPUT_DIR):
        try:
            os.makedirs(OUTPUT_DIR)
            print(f"📁 Created output directory: {OUTPUT_DIR}")
        except Exception as e:
            print(f"⚠️  Warning: Could not create directory {OUTPUT_DIR}: {e}")
            print(f"📁 Using current directory instead")
            return os.getcwd()
    else:
        print(f"📁 Output directory already exists: {OUTPUT_DIR}")
    return OUTPUT_DIR

class ReligiousDemographicsAnalyzer:
    def __init__(self):
        """Initialize the analyzer with demographic data"""
        print("🔧 DEBUG: Initializing ReligiousDemographicsAnalyzer...")
        print("🔄 Initializing Religious Demographics Analyzer...")
        
        print("🔧 DEBUG: Ensuring output directory...")
        self.output_dir = ensure_output_directory()
        print(f"🔧 DEBUG: Output directory set to: {self.output_dir}")
        
        print("🔧 DEBUG: Setting up data...")
        self.setup_data()
        print("🔧 DEBUG: Data setup complete")
        
        print("🔧 DEBUG: Calculating absolute populations...")
        self.calculate_absolute_populations()
        print("🔧 DEBUG: Population calculations complete")
        
    def setup_data(self):
        """Initialize demographic data for Bangladesh and India"""
        print("🔧 DEBUG: Creating Bangladesh data dictionary...")
        
        # Bangladesh/East Pakistan Data (1951-2022)
        self.bangladesh_data = {
            'Year': [1951, 1961, 1974, 1981, 1991, 2001, 2011, 2022],
            'Total_Population_Millions': [42.0, 50.8, 76.4, 87.1, 111.5, 129.2, 149.8, 165.2],
            'Muslim_Percent': [76.9, 80.4, 85.4, 86.6, 88.3, 89.6, 90.4, 91.04],
            'Hindu_Percent': [22.0, 18.5, 13.5, 12.1, 10.5, 9.2, 8.5, 7.95],
            'Buddhist_Percent': [0.7, 0.7, 0.6, 0.6, 0.6, 0.7, 0.6, 0.61],
            'Christian_Percent': [0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.30],
            'Others_Percent': [0.1, 0.1, 0.2, 0.4, 0.3, 0.2, 0.2, 0.10]
        }
        print("🔧 DEBUG: Bangladesh data created")
        
        print("🔧 DEBUG: Creating India data dictionary...")
        # India Data (1951-2011)
        self.india_data = {
            'Year': [1951, 1961, 1971, 1981, 1991, 2001, 2011],
            'Total_Population_Millions': [361.1, 439.2, 548.2, 683.3, 846.4, 1028.6, 1210.9],
            'Hindu_Percent': [84.1, 83.5, 82.7, 82.3, 81.5, 80.5, 79.8],
            'Muslim_Percent': [9.8, 10.7, 11.2, 11.4, 12.6, 13.4, 14.2],
            'Christian_Percent': [2.3, 2.4, 2.6, 2.4, 2.3, 2.3, 2.3],
            'Sikh_Percent': [1.9, 1.8, 1.9, 1.9, 1.9, 1.9, 1.7],
            'Others_Percent': [1.9, 1.6, 1.6, 2.0, 1.7, 1.9, 2.0]
        }
        print("🔧 DEBUG: India data created")
        
        print("🔧 DEBUG: Converting to DataFrames...")
        # Convert to DataFrames
        self.bangladesh_df = pd.DataFrame(self.bangladesh_data)
        self.india_df = pd.DataFrame(self.india_data)
        print("🔧 DEBUG: DataFrames created successfully")
        
    def calculate_absolute_populations(self):
        """Calculate absolute population numbers for each religious group"""
        print("🔧 DEBUG: Calculating Bangladesh absolute populations...")
        
        # Bangladesh absolute populations (in millions)
        religious_groups_bd = ['Muslim', 'Hindu', 'Buddhist', 'Christian', 'Others']
        for group in religious_groups_bd:
            print(f"🔧 DEBUG: Calculating {group} population for Bangladesh...")
            self.bangladesh_df[f'{group}_Population'] = (
                self.bangladesh_df['Total_Population_Millions'] * 
                self.bangladesh_df[f'{group}_Percent'] / 100
            ).round(2)
        
        print("🔧 DEBUG: Calculating India absolute populations...")
        # India absolute populations (in millions)
        religious_groups_in = ['Hindu', 'Muslim', 'Christian', 'Sikh', 'Others']
        for group in religious_groups_in:
            print(f"🔧 DEBUG: Calculating {group} population for India...")
            self.india_df[f'{group}_Population'] = (
                self.india_df['Total_Population_Millions'] * 
                self.india_df[f'{group}_Percent'] / 100
            ).round(2)
        
        print("🔧 DEBUG: All population calculations complete")

    def run_simple_test(self):
        """Run a simple test to verify the class works"""
        print("🔧 DEBUG: Running simple test...")
        print("📊 Sample Bangladesh Data:")
        print(self.bangladesh_df.head())
        print("\n📊 Sample India Data:")
        print(self.india_df.head())
        print("🔧 DEBUG: Simple test complete")

def test_basic_functionality():
    """Test basic functionality without complex operations"""
    print("🔧 DEBUG: Starting basic functionality test...")
    
    try:
        print("🔧 DEBUG: Creating analyzer instance...")
        analyzer = ReligiousDemographicsAnalyzer()
        print("🔧 DEBUG: Analyzer created successfully")
        
        print("🔧 DEBUG: Running simple test...")
        analyzer.run_simple_test()
        print("🔧 DEBUG: Test completed successfully")
        
        return analyzer
        
    except Exception as e:
        print(f"❌ ERROR in basic functionality test: {e}")
        import traceback
        traceback.print_exc()
        return None

def main():
    """Main function with debug output"""
    print("🚀 DEBUG: Starting main function...")
    
    try:
        print("🔧 DEBUG: Running basic functionality test...")
        analyzer = test_basic_functionality()
        
        if analyzer is None:
            print("❌ ERROR: Basic functionality test failed")
            return None
            
        print("✅ DEBUG: Basic test passed! The script is working.")
        print("🔧 DEBUG: You can now run the full analysis if needed.")
        
        # Optionally run a simple CSV export test
        print("🔧 DEBUG: Testing CSV export...")
        try:
            test_file = os.path.join(analyzer.output_dir, 'test_bangladesh_data.csv')
            analyzer.bangladesh_df.to_csv(test_file, index=False)
            print(f"✅ DEBUG: CSV test successful - file saved to: {test_file}")
        except Exception as e:
            print(f"⚠️  DEBUG: CSV test failed: {e}")
        
        return analyzer
        
    except Exception as e:
        print(f"❌ ERROR in main function: {e}")
        import traceback
        traceback.print_exc()
        return None

if __name__ == "__main__":
    print("🔧 DEBUG: Script reached main execution block")
    results = main()
    
    if results:
        print("🎉 DEBUG: Script completed successfully!")
    else:
        print("❌ DEBUG: Script failed!")
    
    print("🔧 DEBUG: Script execution finished")