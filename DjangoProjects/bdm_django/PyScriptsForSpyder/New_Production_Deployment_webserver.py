# -*- coding: utf-8 -*-
"""
Created on Sun Jun 22 16:27:29 2025

@author: muhuri
"""

# -*- coding: utf-8 -*-
"""
CodeHurry.com CSV Dashboard with Web Server
Reads CSV data and serves it via web interface

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
from flask import Flask, render_template_string, jsonify
import webbrowser

class CodeHurryWebDashboard:
    def __init__(self, input_csv_path="C:/Data/Final_Combined/server_dashboard.csv"):
        # Setup paths
        self.base_dir = Path("C:/Explore/DjangoProjects/codehurry_dashboard")
        self.output_dir = self.base_dir / "dashboard_output"
        self.output_dir.mkdir(exist_ok=True)
        
        # Input data file
        self.input_csv_path = Path(input_csv_path)
        
        # Output files
        self.csv_file = self.output_dir / "codehurry_processed_data.csv"
        
        # Configuration
        self.production_url = "https://www.codehurry.com"
        self.local_port = 8090
        self.update_interval = 30
        self.is_running = False
        
        # Data storage
        self.input_data = None
        self.processed_data = None
        
        # Web server
        self.app = Flask(__name__)
        self.setup_web_routes()
        
        # Initialize system
        self.load_input_data()
        
        timestamp = self.get_timestamp()
        print("[{}] CodeHurry Web Dashboard initialized".format(timestamp))
        print("[{}] Input CSV: {}".format(timestamp, self.input_csv_path))
        print("[{}] Production: {}".format(timestamp, self.production_url))
        print("[{}] Local Server: http://localhost:{}".format(timestamp, self.local_port))
    
    def get_timestamp(self):
        """Get formatted timestamp"""
        return datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    def setup_web_routes(self):
        """Setup Flask web routes"""
        
        @self.app.route('/')
        def dashboard():
            """Main dashboard page"""
            try:
                if self.processed_data is None:
                    self.process_input_data()
                
                # Get data info
                total_records = len(self.processed_data) if self.processed_data is not None else 0
                total_columns = len(self.processed_data.columns) if self.processed_data is not None else 0
                
                # Get column info
                if self.processed_data is not None:
                    numeric_cols = self.processed_data.select_dtypes(include=['number']).columns.tolist()
                    text_cols = self.processed_data.select_dtypes(include=['object']).columns.tolist()
                    
                    # Get sample data (first 20 rows)
                    sample_data = self.processed_data.head(20)
                    
                    # Calculate basic stats for numeric columns
                    stats = {}
                    for col in numeric_cols[:5]:  # Show stats for first 5 numeric columns
                        stats[col] = {
                            'mean': float(self.processed_data[col].mean()),
                            'min': float(self.processed_data[col].min()),
                            'max': float(self.processed_data[col].max())
                        }
                else:
                    numeric_cols = []
                    text_cols = []
                    sample_data = pd.DataFrame()
                    stats = {}
                
                return render_template_string(self.get_dashboard_template(), 
                                            production_url=self.production_url,
                                            local_port=self.local_port,
                                            current_time=self.get_timestamp(),
                                            input_file=self.input_csv_path.name,
                                            total_records=total_records,
                                            total_columns=total_columns,
                                            numeric_cols_count=len(numeric_cols),
                                            text_cols_count=len(text_cols),
                                            sample_data=sample_data,
                                            columns=sample_data.columns.tolist()[:10],
                                            stats=stats)
                
            except Exception as e:
                return f"<h1>Error: {str(e)}</h1><p>Check if your CSV file exists and is readable.</p>"
        
        @self.app.route('/api/data')
        def api_data():
            """API endpoint for raw data"""
            try:
                if self.processed_data is not None:
                    return jsonify({
                        'success': True,
                        'total_records': len(self.processed_data),
                        'total_columns': len(self.processed_data.columns),
                        'columns': self.processed_data.columns.tolist(),
                        'sample_data': self.processed_data.head(10).to_dict('records')
                    })
                else:
                    return jsonify({'success': False, 'error': 'No data loaded'})
            except Exception as e:
                return jsonify({'success': False, 'error': str(e)})
        
        @self.app.route('/api/refresh')
        def api_refresh():
            """API endpoint to refresh data"""
            try:
                if self.load_input_data() and self.process_input_data():
                    return jsonify({'success': True, 'message': 'Data refreshed successfully'})
                else:
                    return jsonify({'success': False, 'error': 'Failed to refresh data'})
            except Exception as e:
                return jsonify({'success': False, 'error': str(e)})
        
        @self.app.route('/api/status')
        def api_status():
            """API endpoint for system status"""
            return jsonify({
                'timestamp': self.get_timestamp(),
                'input_file': str(self.input_csv_path),
                'file_exists': self.input_csv_path.exists(),
                'monitoring_active': self.is_running,
                'total_records': len(self.processed_data) if self.processed_data is not None else 0
            })
    
    def get_dashboard_template(self):
        """HTML template for dashboard"""
        return '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeHurry.com Live Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            background: linear-gradient(45deg, #2c3e50, #34495e);
            color: white;
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            margin-bottom: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .header h1 {
            margin: 0;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        .header p {
            margin: 10px 0 0 0;
            opacity: 0.9;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            border-left: 5px solid #3498db;
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-value {
            font-size: 2.5em;
            font-weight: bold;
            color: #2c3e50;
            margin: 10px 0;
        }
        .stat-label {
            color: #7f8c8d;
            font-size: 1.1em;
            font-weight: 500;
        }
        .data-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .data-table th {
            background: #3498db;
            color: white;
            padding: 15px;
            text-align: left;
            border-radius: 5px 5px 0 0;
        }
        .data-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #ecf0f1;
        }
        .data-table tr:hover {
            background: #f8f9fa;
        }
        .refresh-btn {
            background: #27ae60;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            margin: 10px 0;
        }
        .refresh-btn:hover {
            background: #219a52;
        }
        .status-indicator {
            display: inline-block;
            width: 10px;
            height: 10px;
            background: #27ae60;
            border-radius: 50%;
            margin-right: 10px;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
        .api-links {
            background: #e8f4fd;
            padding: 15px;
            border-radius: 10px;
            margin-top: 20px;
        }
        .api-links a {
            color: #3498db;
            text-decoration: none;
            margin-right: 15px;
        }
        .api-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 CodeHurry.com Live Dashboard</h1>
            <p><span class="status-indicator"></span>Live Data Processing Active</p>
            <p>Production: <a href="{{ production_url }}" style="color: #ecf0f1;">{{ production_url }}</a></p>
            <p>Local Server: <a href="http://localhost:{{ local_port }}" style="color: #ecf0f1;">http://localhost:{{ local_port }}</a></p>
            <p>Last Updated: {{ current_time }}</p>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">Data Source</div>
                <div class="stat-value">📂</div>
                <div class="stat-label">{{ input_file }}</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-label">Total Records</div>
                <div class="stat-value">{{ total_records }}</div>
                <div class="stat-label">Data Rows</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-label">Total Columns</div>
                <div class="stat-value">{{ total_columns }}</div>
                <div class="stat-label">Data Fields</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-label">Column Types</div>
                <div class="stat-value">{{ numeric_cols_count + text_cols_count }}</div>
                <div class="stat-label">{{ numeric_cols_count }} Numeric, {{ text_cols_count }} Text</div>
            </div>
        </div>
        
        <div class="data-section">
            <h2>📊 Live Data Preview</h2>
            <button class="refresh-btn" onclick="refreshData()">🔄 Refresh Data</button>
            
            {% if sample_data is not none and not sample_data.empty %}
            <table class="data-table">
                <thead>
                    <tr>
                        {% for col in columns %}
                        <th>{{ col }}</th>
                        {% endfor %}
                    </tr>
                </thead>
                <tbody>
                    {% for index, row in sample_data.iterrows() %}
                    <tr>
                        {% for col in columns %}
                        <td>{{ row[col] if col in row else '' }}</td>
                        {% endfor %}
                    </tr>
                    {% endfor %}
                </tbody>
            </table>
            {% else %}
            <p>No data available. Check your input CSV file.</p>
            {% endif %}
        </div>
        
        {% if stats %}
        <div class="data-section">
            <h2>📈 Column Statistics</h2>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Column</th>
                        <th>Mean</th>
                        <th>Min</th>
                        <th>Max</th>
                    </tr>
                </thead>
                <tbody>
                    {% for col, stat in stats.items() %}
                    <tr>
                        <td><strong>{{ col }}</strong></td>
                        <td>{{ "%.2f"|format(stat.mean) }}</td>
                        <td>{{ "%.2f"|format(stat.min) }}</td>
                        <td>{{ "%.2f"|format(stat.max) }}</td>
                    </tr>
                    {% endfor %}
                </tbody>
            </table>
        </div>
        {% endif %}
        
        <div class="data-section">
            <h2>🔗 API Endpoints</h2>
            <div class="api-links">
                <a href="/api/data" target="_blank">📊 Raw Data (JSON)</a>
                <a href="/api/status" target="_blank">📈 System Status</a>
                <a href="/api/refresh" target="_blank">🔄 Refresh Data</a>
            </div>
        </div>
    </div>
    
    <script>
        function refreshData() {
            fetch('/api/refresh')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    alert('Error refreshing data: ' + data.error);
                }
            })
            .catch(error => {
                alert('Network error: ' + error);
            });
        }
        
        // Auto-refresh every 30 seconds
        setInterval(function() {
            fetch('/api/status')
            .then(response => response.json())
            .then(data => {
                console.log('Status check:', data);
            });
        }, 30000);
    </script>
</body>
</html>
'''
    
    def load_input_data(self):
        """Load data from input CSV file"""
        try:
            if not self.input_csv_path.exists():
                timestamp = self.get_timestamp()
                print("[{}] Input CSV file not found: {}".format(timestamp, self.input_csv_path))
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
    
    def start_web_server(self):
        """Start the Flask web server"""
        try:
            timestamp = self.get_timestamp()
            print("[{}] Starting web server on port {}...".format(timestamp, self.local_port))
            
            # Run Flask app
            self.app.run(
                host='0.0.0.0',  # Listen on all interfaces
                port=self.local_port,
                debug=False,
                use_reloader=False,
                threaded=True
            )
            
        except Exception as e:
            timestamp = self.get_timestamp()
            print("[{}] Web server error: {}".format(timestamp, str(e)))
    
    def start_monitoring(self):
        """Start file monitoring in background"""
        if self.is_running:
            return
        
        self.is_running = True
        timestamp = self.get_timestamp()
        print("[{}] Starting file monitoring...".format(timestamp))
        
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
                            print("[{}] Input file changed, refreshing...".format(timestamp))
                            self.load_input_data()
                            self.process_input_data()
                            self.generate_csv_output()
                            last_modified = current_modified
                    
                    time.sleep(self.update_interval)
                    
                except Exception as e:
                    timestamp = self.get_timestamp()
                    print("[{}] Monitoring error: {}".format(timestamp, str(e)))
                    time.sleep(5)
        
        # Start monitoring thread
        monitor_thread = threading.Thread(target=monitoring_loop, daemon=True)
        monitor_thread.start()
    
    def open_browser(self):
        """Open web browser to dashboard"""
        try:
            time.sleep(2)  # Wait for server to start
            url = f"http://localhost:{self.local_port}"
            webbrowser.open(url)
            timestamp = self.get_timestamp()
            print("[{}] Opening browser: {}".format(timestamp, url))
        except Exception as e:
            timestamp = self.get_timestamp()
            print("[{}] Browser open error: {}".format(timestamp, str(e)))

# Utility functions
def start_web_dashboard(input_csv="C:/Data/Final_Combined/server_dashboard.csv", open_browser=True):
    """Start web dashboard with optional browser opening"""
    
    # Create dashboard instance
    dashboard = CodeHurryWebDashboard(input_csv)
    
    # Process initial data
    print("🔄 Processing initial data...")
    if dashboard.process_input_data():
        dashboard.generate_csv_output()
    
    # Start file monitoring
    dashboard.start_monitoring()
    
    # Open browser in background if requested
    if open_browser:
        browser_thread = threading.Thread(target=dashboard.open_browser, daemon=True)
        browser_thread.start()
    
    timestamp = dashboard.get_timestamp()
    print("\n[{}] ✅ Web dashboard starting!".format(timestamp))
    print("🌐 URL: http://localhost:{}".format(dashboard.local_port))
    print("📊 CSV Output: {}".format(dashboard.csv_file))
    print("🔄 File monitoring active")
    print("\n💡 Press Ctrl+C to stop the server")
    
    # Start web server (this will block)
    dashboard.start_web_server()
    
    return dashboard

def quick_web_start():
    """Quick start with default settings"""
    return start_web_dashboard()

# Main execution
if __name__ == "__main__":
    print("🚀 CodeHurry.com Web Dashboard - Starting...")
    
    try:
        # Check if Flask is installed
        import flask
        print("✅ Flask web framework detected")
        
        # Start web dashboard
        web_dashboard = start_web_dashboard()
        
    except ImportError:
        print("❌ Flask not installed. Install with: pip install flask")
        print("🔄 Running in CSV-only mode...")
        
        # Fallback to CSV processing only
        from pathlib import Path
        import pandas as pd
        
        input_file = Path("C:/Data/Final_Combined/server_dashboard.csv")
        if input_file.exists():
            df = pd.read_csv(input_file)
            print(f"✅ Loaded {len(df)} rows from {input_file}")
        else:
            print(f"❌ Input file not found: {input_file}")
    
    except KeyboardInterrupt:
        print("\n⏹️ Web server stopped by user")
    
    except Exception as e:
        print(f"❌ Error: {str(e)}")

print("\n📋 Web Dashboard Script Loaded!")
print("💡 Use start_web_dashboard() to begin")