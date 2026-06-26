# -*- coding: utf-8 -*-
"""
Created on Thu Jun 25 22:20:23 2026

@author: muhuri
"""

from pathlib import Path
import re
import uuid
import nbformat as nbf
from datetime import datetime

#-------------------------------------------------------
# Configuration
#-------------------------------------------------------

ROOT = Path(r"C:\Explore\SAS")
OUTPUT = ROOT / "Combined_SAS_Course.ipynb"

#-------------------------------------------------------
# Natural sort
#-------------------------------------------------------

def natural_key(text):
    return [int(t) if t.isdigit() else t.lower()
            for t in re.split(r'(\d+)', text)]

#-------------------------------------------------------
# Create notebook
#-------------------------------------------------------

combined = nbf.v4.new_notebook()
cells = []

#-------------------------------------------------------
# Title Page
#-------------------------------------------------------

cells.append(
    nbf.v4.new_markdown_cell(
f"""# SAS Programming Course

**Combined Notebook**

Created: {datetime.now():%B %d, %Y %I:%M %p}

This notebook contains all notebooks from Week1 through Week14.
"""
    )
)

#-------------------------------------------------------
# Table of Contents
#-------------------------------------------------------

toc = ["# Table of Contents\n"]

week_folders = sorted(
    [d for d in ROOT.iterdir()
     if d.is_dir() and d.name.lower().startswith("week")],
    key=lambda x: natural_key(x.name)
)

for week in week_folders:

    toc.append(f"- **{week.name}**")

    notebooks = sorted(
        week.glob("*.ipynb"),
        key=lambda x: natural_key(x.stem)
    )

    for nb in notebooks:
        toc.append(f"    - {nb.stem}")

cells.append(
    nbf.v4.new_markdown_cell("\n".join(toc))
)

#-------------------------------------------------------
# Merge notebooks
#-------------------------------------------------------

merged = []

for week in week_folders:

    cells.append(
        nbf.v4.new_markdown_cell(
            f"# {week.name}"
        )
    )

    notebooks = sorted(
        week.glob("*.ipynb"),
        key=lambda x: natural_key(x.stem)
    )

    for nbfile in notebooks:

        merged.append(str(nbfile.relative_to(ROOT)))

        cells.append(
            nbf.v4.new_markdown_cell(
f"""---
## {nbfile.stem}

*Source:* `{nbfile.relative_to(ROOT)}`
"""
            )
        )

        nb = nbf.read(nbfile, as_version=4)

        # Give every cell a new unique ID
        for cell in nb.cells:
            cell["id"] = uuid.uuid4().hex
            cells.append(cell)

#-------------------------------------------------------
# Metadata
#-------------------------------------------------------

combined.cells = cells
combined.metadata = {
    "language_info": {
        "name": "python"
    }
}

nbf.write(combined, OUTPUT)

print(f"\nCreated:\n{OUTPUT}")

print("\nMerged notebooks:")

for m in merged:
    print("  ", m)