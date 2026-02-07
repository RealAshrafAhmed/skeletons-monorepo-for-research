#!/bin/zsh
# Register the current Python environment as a Jupyter kernel and start Jupyter Lab
uv run python -m ipykernel install --user --name=skeletons-monorepo
uv run jupyter lab
