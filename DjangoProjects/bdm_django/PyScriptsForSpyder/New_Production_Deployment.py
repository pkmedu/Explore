# -*- coding: utf-8 -*-
"""
Created on Sun Jun 22 15:54:53 2025

@author: muhuri
"""

# -*- coding: utf-8 -*-
"""
CodeHurry.com Dashboard Manager with Input CSV Data
Reads from input CSV file and generates HTML/CSV dashboards

@author: muhuri
@site: https://www.codehurry.com
"""

import os
import sys
import datetime
import pandas as pd
import time
import threading
from pathlib import Path
import sqlite3

class CodeHurryInputDataManager:
    def __init__(self, input_csv_path="C:/Data/Final_Combined/server_dashboard.csv"):
        # Setup paths
        self.base_dir = Path("C:/Explore/DjangoProjects/codehurry_dashboard")
        self.output_dir = self.base_dir / "dashboard_output"
        self.output_dir.mkdir(exist_ok=True)
        
        # Input data file - YOUR CSV FILE
        self.input_csv_path = Path(input_csv_path)
        
        # Output files
        self.csv_file = self.output_dir / "codehurry_processed_data.csv"
        
        # Configuration
        self.production_url = "https://www.codehurry.com"
        self.update_interval = 30
        self.is_running = False
        
        # Data storage
        self.input_data = None
        self.processed_data = None
        
        # Initialize system
        self.load_input_data()
        
        timestamp = self.get_timestamp()
        print("[{}] CodeHurry Input Data Manager initialized".format(timestamp))
        print("[{}] Input CSV: {}".format(timestamp, self.input_csv_path))
        print("[{}] Production: {}".format(timestamp, self.production_url))
    
    def get_timestamp(self):
        """Get formatted timestamp"""
        return datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    def load_input_data(self):
        """Load data from input CSV file"""
        try:
            if not self.input_csv_path.exists():
                timestamp = self.get_timestamp()
                print("[{}] Input CSV file not found: {}".format(timestamp, self.input_csv_path))
                self.log_event("FILE_ERROR", "Input CSV file not found", "FAILED")
                return False
            
            # Read CSV file
            self.input_data = pd.read_csv(self.input_csv_path)
            
            timestamp = self.get_timestamp()
            print("[{}] Input data loaded: {} rows, {} columns".format(
                timestamp, len(self.input_data), len(self.input_data.columns)))
            
            # Display column info
            print("[{}] Columns: {}".format(timestamp, list(self.input_data.columns)))
            
            return True
            
        except Exception as e:
            timestamp = self.get_timestamp()
            print("[{}] Error loading input data: {}".format(timestamp, str(e)))
            return False
    
    def process_input_data(self):
        """Process the input data for dashboard"""
        try:
            if self.input_data is None:
                timestamp = self.get_timestamp()
                print("[{}] No input data available to process".format(timestamp))
                return False
            
            # Create a copy for processing
            self.processed_data = self.input_data.copy()
            
            # Add metadata columns
            self.processed_data['processed_timestamp'] = self.get_timestamp()
            self.processed_data['production_url'] = self.production_url
            self.processed_data['data_source'] = str(self.input_csv_path)
            
            # If there's a timestamp column, try to parse it
            timestamp_columns = [col for col in self.processed_data.columns 
                               if 'time' in col.lower() or 'date' in col.lower()]
            
            if timestamp_columns:
                try:
                    self.processed_data[timestamp_columns[0]] = pd.to_datetime(
                        self.processed_data[timestamp_columns[0]], errors='coerce')
                    timestamp = self.get_timestamp()
                    print("[{}] Parsed timestamp column: {}".format(timestamp, timestamp_columns[0]))
                except:
                    pass
            
            # Calculate basic statistics if numeric columns exist
            numeric_columns = self.processed_data.select_dtypes(include=['number']).columns
            if len(numeric_columns) > 0:
                self.stats_summary = {
                    'total_records': len(self.processed_data),
                    'numeric_columns': len(numeric_columns),
                    'column_stats': {}
                }
                
                for col in numeric_columns:
                    self.stats_summary['column_stats'][col] = {
                        'mean': float(self.processed_data[col].mean()),
                        'median': float(self.processed_data[col].median()),
                        'min': float(self.processed_data[col].min()),
                        'max': float(self.processed_data[col].max()),
                        'std': float(self.processed_data[col].std())
                    }
            
            timestamp = self.get_timestamp()
            print("[{}] Data processing completed - {} records processed".format(
                timestamp, len(self.processed_data)))
            
            return True
            
        except Exception as e:
            timestamp = self.get_timestamp()
            print("[{}] Error processing data: {}".format(timestamp, str(e)))
            return False
    
    def generate_csv_output(self):
        """Generate processed CSV output"""
        try:
            if self.processed_data is None:
                if not self.process_input_data():
                    return False
            
            # Save processed data as CSV
            self.processed_data.to_csv(self.csv_file, index=False)
            
            timestamp = self.get_timestamp()
            print("[{}] CSV output generated: {}".format(timestamp, self.csv_file))
            
            return True
            
        except Exception as e:
            timestamp = self.get_timestamp()
            print("[{}] Error generating CSV output: {}".format(timestamp, str(e)))
            return False
    
    def refresh_data(self):
        """Refresh data from input CSV"""
        timestamp = self.get_timestamp()
        print("[{}] Refreshing data from input CSV...".format(timestamp))
        
        if self.load_input_data():
            if self.process_input_data():
                self.generate_csv_output()
                timestamp = self.get_timestamp()
                print("[{}] Data refresh completed successfully".format(timestamp))
                return True
        
        timestamp = self.get_timestamp()
        print("[{}] Data refresh failed".format(timestamp))
        return False
    
    def start_monitoring(self):
        """Start monitoring for changes in input file"""
        if self.is_running:
            timestamp = self.get_timestamp()
            print("[{}] Monitoring already active".format(timestamp))
            return
        
        self.is_running = True
        timestamp = self.get_timestamp()
        print("[{}] Starting file monitoring (interval: {}s)".format(timestamp, self.update_interval))
        
        def monitoring_loop():
            last_modified = None
            
            while self.is_running:
                try:
                    if self.input_csv_path.exists():
                        current_modified = self.input_csv_path.stat().st_mtime
                        
                        if last_modified is None:
                            last_modified = current_modified
                        elif current_modified > last_modified:
                            timestamp = self.get_timestamp()
                            print("[{}] Input file changed, refreshing data...".format(timestamp))
                            self.refresh_data()
                            last_modified = current_modified
                    
                    time.sleep(self.update_interval)
                    
                except Exception as e:
                    timestamp = self.get_timestamp()
                    print("[{}] Monitoring error: {}".format(timestamp, str(e)))
                    time.sleep(5)
        
        # Start monitoring thread
        monitor_thread = threading.Thread(target=monitoring_loop, daemon=True)
        monitor_thread.start()
    
    def stop_monitoring(self):
        """Stop file monitoring"""
        self.is_running = False
        timestamp = self.get_timestamp()
        print("[{}] File monitoring stopped".format(timestamp))
    
    def get_data_status(self):
        """Get current data status"""
        status = {
            'timestamp': self.get_timestamp(),
            'input_file': str(self.input_csv_path),
            'input_exists': self.input_csv_path.exists(),
            'monitoring_active': self.is_running,
            'production_url': self.production_url,
            'csv_output': str(self.csv_file),
            'update_interval': self.update_interval
        }
        
        if self.input_data is not None:
            status.update({
                'total_records': len(self.input_data),
                'total_columns': len(self.input_data.columns),
                'columns': list(self.input_data.columns)
            })
        
        return status
    
    def print_status(self):
        """Print formatted status"""
        status = self.get_data_status()
        
        print("\n" + "="*60)
        print("📊 CODEHURRY.COM DATA DASHBOARD STATUS")
        print("="*60)
        print("🕐 Current Time: {}".format(status['timestamp']))
        print("📂 Input File: {}".format(status['input_file']))
        print("✅ File Exists: {}".format("Yes" if status['input_exists'] else "No"))
        print("🌐 Production: {}".format(status['production_url']))
        
        if status['monitoring_active']:
            print("📈 Monitoring: 🟢 ACTIVE")
        else:
            print("📈 Monitoring: 🔴 STOPPED")
        
        print("📊 CSV Output: {}".format(status['csv_output']))
        print("⏱️ Update Interval: {}s".format(status['update_interval']))
        
        if 'total_records' in status:
            print("📋 Data Records: {}".format(status['total_records']))
            print("📊 Data Columns: {}".format(status['total_columns']))
        
        print("="*60)

# Utility functions for Spyder console
def start_input_dashboard(input_csv="C:/Data/Final_Combined/server_dashboard.csv"):
    """Start dashboard with input CSV file"""
    manager = CodeHurryInputDataManager(input_csv)
    
    # Process initial data
    print("🔄 Processing input data...")
    if manager.process_input_data():
        print("📊 Generating CSV output...")
        manager.generate_csv_output()
        
        # Start monitoring
        manager.start_monitoring()
        
        # Show status
        manager.print_status()
        
        timestamp = manager.get_timestamp()
        print("\n[{}] ✅ Input data processing started!".format(timestamp))
        print("📊 CSV Output: {}".format(manager.csv_file))
        
        return manager
    else:
        print("❌ Failed to process input data")
        return None

def quick_data_status():
    """Quick status check"""
    manager = CodeHurryInputDataManager()
    manager.print_status()
    return manager

def generate_reports_from_csv(input_csv="C:/Data/Final_Combined/server_dashboard.csv"):
    """Generate reports from CSV file"""
    manager = CodeHurryInputDataManager(input_csv)
    
    print("🔄 Loading and processing data...")
    if manager.process_input_data():
        print("📊 Generating CSV output...")
        manager.generate_csv_output()
        
        print("✅ CSV output generated:")
        print("  📊 CSV: {}".format(manager.csv_file))
        
        return manager
    else:
        print("❌ Failed to process input data")
        return None

# Main execution
if __name__ == "__main__":
    print("📊 CodeHurry.com Input Data Dashboard Manager - Starting...")
    
    try:
        # Start with input CSV
        input_csv_path = "C:/Data/Final_Combined/server_dashboard.csv"
        dashboard_manager = start_input_dashboard(input_csv_path)
        
        if dashboard_manager:
            print("\n💡 Available commands:")
            print("   dashboard_manager.print_status()")
            print("   dashboard_manager.stop_monitoring()")
            print("   dashboard_manager.refresh_data()")
            print("   generate_reports_from_csv()")
            
            # Keep running
            try:
                print("\n⌛ File monitoring active. Press Ctrl+C to stop...")
                while True:
                    time.sleep(60)
                    if not dashboard_manager.is_running:
                        break
            except KeyboardInterrupt:
                timestamp = dashboard_manager.get_timestamp()
                print("\n[{}] ⏹️ Stopping dashboard...".format(timestamp))
                dashboard_manager.stop_monitoring()
                print("✅ Dashboard stopped.")
        
    except Exception as e:
        print("❌ Error starting dashboard: {}".format(str(e)))
        import traceback
        traceback.print_exc()

print("\n📋 CSV Data Processor loaded successfully!")
print("💡 Use start_input_dashboard('your_file.csv') to begin")