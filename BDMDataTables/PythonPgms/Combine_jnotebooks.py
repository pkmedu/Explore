# -*- coding: utf-8 -*-
"""
Created on Thu Jun 25 22:10:06 2026

@author: muhuri
"""

from pathlib import Path
import nbformat as nbf

# Root folder containing Week1 ... Week14
root = Path(r"C:\Explore\SAS")

# Create a new notebook
combined_nb = nbf.v4.new_notebook()
combined_cells = []

# Find all Week folders
week_folders = sorted(
    [p for p in root.iterdir() if p.is_dir() and p.name.lower().startswith("week")]
)

for week in week_folders:

    # Week heading
    combined_cells.append(
        nbf.v4.new_markdown_cell(f"# {week.name}")
    )

    # Find all notebooks
    notebooks = sorted(week.glob("*.ipynb"))

    for nb_file in notebooks:

        print(nb_file.name)

        # Notebook heading
        combined_cells.append(
            nbf.v4.new_markdown_cell(
                f"## Notebook: {nb_file.name}"
            )
        )

        # Read notebook
        nb = nbf.read(nb_file, as_version=4)

        # Append every cell
        combined_cells.extend(nb.cells)

combined_nb.cells = combined_cells

output_file = root / "Combined_SAS_Course.ipynb"

nbf.write(combined_nb, output_file)

print(f"\nCreated:\n{output_file}")