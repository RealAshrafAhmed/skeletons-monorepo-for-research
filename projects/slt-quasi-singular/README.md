# SLT Quasi-Singular Project

This project demonstrates generating and visualizing samples from a standard normal distribution using a Jupyter notebook.

## How to Run the Notebook

1. **Install all dependencies (from the monorepo root):**
   ```bash
   uv sync --all-packages
   ```

2. **Start Jupyter Lab (from the monorepo root):**
   ```bash
   uv run jupyter lab
   ```
   Then open `projects/slt-quasi-singular/normal_samples.ipynb` in the Jupyter interface.

## How to Run the Notebook with Papermill

1. **Install Papermill (if not already):**
   ```bash
   uv pip install papermill
   ```

2. **Run the notebook non-interactively:**
   ```bash
   uv run papermill projects/slt-quasi-singular/normal_samples.ipynb projects/slt-quasi-singular/normal_samples_output.ipynb
   ```

## Notes
- All dependencies are managed with `uv`.
- For troubleshooting, see the monorepo README.
