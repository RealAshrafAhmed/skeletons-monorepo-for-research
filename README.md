# Skeletons Python Research Monorepo

A production-ready template for managing multiple research projects and shared libraries in a single repository using modern Python tooling.

## Why This Structure?

**Problem:** Research codebases often become messy: scattered notebooks, duplicated utility code, inconsistent dependencies, and no testing infrastructure.

**Solution:** This monorepo structure provides:

- **📦 Shared Packages**: Write utilities once, use everywhere. Packages can be imported in any notebook or project.
- **🔬 Isolated Projects**: Each research project gets its own directory with dependencies, while sharing common code.
- **📓 Notebook-Friendly**: Jupyter integration that actually works - imports from local packages seamlessly.
- **🔄 Reproducibility**: Lockfile ensures everyone uses the same dependency versions. Pre-commit hooks enforce code quality.
- **⚡ Fast Iteration**: `uv` makes dependency management 10-100x faster than pip/conda.
- **🧪 Testing Ready**: Example test structure so you can validate critical code paths.

**When to use this:**
- Working on multiple related research projects
- Building reusable tools for experiments (MCMC utilities, plotting helpers, data loaders)
- Collaborating with others who need your code
- Publishing research with reproducible code

**When NOT to use this:**
- Single standalone Jupyter notebook analysis
- Quick exploratory data analysis (use a simple directory instead)

## How to Use This Template

### 1. Initial Setup

```bash
# Clone or copy this template
git clone <this-repo-url> my-research
cd my-research

# Install dependencies
uv sync --all-packages

# Set up pre-commit hooks (optional but recommended)
uv run pre-commit install

# Start Jupyter
uv run jupyter lab
```

### Optional: Using mise

If you have [mise](https://mise.jdx.dev/) installed:

```bash
# mise will auto-activate the right Python version
mise install

# Use mise tasks as shortcuts
mise run sync      # uv sync --all-packages
mise run fmt       # format code
mise run lint      # lint code
mise run test      # run tests
mise run jupyter   # start jupyter lab
```

## Common Commands

### Packages

```bash
# Install/sync all packages
uv sync --all-packages

# Add a dependency to a specific package
uv add numpy --package my_package

# Add a dev dependency to root
uv add pytest --dev

# Reinstall a specific package (after changes)
uv sync --all-packages --reinstall-package my_package

# Force full reinstall (nuclear option)
rm uv.lock && uv sync --all-packages
```

### Jupyter

```bash
# Start Jupyter Lab
uv run jupyter lab

# Register kernel (if kernel issues)
uv run python -m ipykernel install --user --name=skeletons-monorepo
```

**Note:** Always restart the Jupyter kernel after installing/updating packages.

### Development

```bash
# Format code
uv run poe fmt

# Lint code
uv run poe lint

# TCustomizing the Template

### Remove Example Content

The template includes example content you should remove or replace:

```bash
# Remove example package (if you don't need PyMC extensions)
rm -rf packages/pymc_extensions

# Remove example project (if starting fresh)
rm -rf projects/slt-quasi-singular

# Remove example notebook
rm notebooks/example_usage.ipynb

# Then sync to update workspace
uv sync --all-packages
```

### Customize for Your Research

1. **Update metadata** in root `pyproject.toml`:
   ```toml
   [project]
   name = "your-research-name"
   description = "Your research description"
   ```

2. **Add your common dependencies** to root `pyproject.toml`:
   ```bash
   # These are available everywhere
   uv add torch transformers datasets
   ```

3. **Create your first shared package**:
   ```bash
   uv init packages/myutils --lib
   cd packages/myutils
   # Edit pyproject.toml to add dependencies
   # Add your code in src/myutils/
   ```

4. **Create your first project**:
   ```bash
   uv init projects/experiment1 --package
   # Add notebooks, scripts, and project-specific code
   ```

5. **Adjust linting rules** in `pyproject.toml` if you find them too strict:
   ```toml
   [tool.ruff.lint]
   ignore = [
     "E501",  # line too long
     # Add more rules to ignore as needed
   ]
   ```

### Typical Research Workflow

```
1. Start with exploratory analysis in notebooks/
2. Extract useful functions into packages/ as they stabilize
3. Create a dedicated projects/ directory when starting formal experiments
4. Use packages/ code across multiple projects
5. Write tests for critical functionality
6. Use papermill to parameterize and batch-run notebooks
```

### Adding Experiment Tracking

For Weights & Biases or MLflow:

```bash
# Add to root dependencies (available everywhere)
uv add wandb
# or
uv add mlflow

# Then use in any notebook or project
```

### Adding GPU Dependencies

## Philosophy & Design Decisions

### Why uv instead of Poetry/conda?

- **Speed**: 10-100x faster than pip, resolves dependencies in seconds
- **Compatibility**: Drop-in replacement for pip, works with standard pyproject.toml
- **Workspace support**: Native monorepo support with `[tool.uv.workspace]`
- **No lock-in**: If uv disappears, you still have standard Python packaging

### Why monorepo instead of multiple repos?

- **Shared code**: Extract common utilities into packages/ without publishing to PyPI
- **Atomic changes**: Update a utility function and all projects using it in one commit
- **Easier onboarding**: Clone once, get everything
- **Better for research**: Most research projects share 80% of their tooling

### Why packages/ vs projects/?

- **packages/**: Reusable libraries (utils, plotting, data loaders) - should have tests
- **projects/**: Specific experiments/papers - can be messier, more exploratory

### Alternatives Considered

- **Separate repos per project**: Too much overhead, code duplication
- **Single directory with utils.py**: Breaks at scale, no proper imports
- **Poetry monorepo**: Slower, less ergonomic workspace support
- **Conda environments**: Slow, large, not reproducible enough

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development workflow and guidelines.

## License

MIT License - see [LICENSE](LICENSE) for details.

---

**I-url https://download.pytorch.org/whl/cu118

# Or add to pyproject.toml with specific index
```

## ype check
uv run poe check

# Run tests
uv run poe test

# Run all checks
uv run poe all
```

### Pre-commit Hooks

Set up pre-commit hooks to automatically format and lint before committing:

```bash
# Install pre-commit hooks
uv run pre-commit install

# Run manually on all files
uv run pre-commit run --all-files
```

### Creating New Packages

```bash
# Create a new library
uv init packages/newlib --lib

# Create a new project
uv init projects/newproject --package
```

Then run `uv sync --all-packages` to register it.

## Project Structure

```
├── packages/               # Shared libraries
│   └── pymc_extensions/    # Example package
│       ├── pyproject.toml
│       ├── src/pymc_extensions/
│       └── tests/          # Package tests
├── projects/               # Research projects
│   └── slt-quasi-singular/ # Example project
├── notebooks/              # Shared notebooks
├── data/                   # Research datasets
├── scripts/                # Utility scripts
├── pyproject.toml          # Root workspace config
├── .pre-commit-config.yaml # Pre-commit hooks
├── .mise.toml              # mise configuration (optional)
└── LICENSE                 # MIT License
```

## Troubleshooting

### Import not working in notebook

1. Restart the Jupyter kernel
2. If still broken: `uv sync --all-packages --reinstall-package <package-name>`
3. Check kernel is using correct venv:
   ```python
   import sys
   print(sys.executable)  # Should be .venv/bin/python
   ```

### Package not found after adding

Make sure it's in the workspace members in root `pyproject.toml`:

```toml
[tool.uv.workspace]
members = [
    "packages/*",
    "projects/*"
]
```

### Wrong Python version

```bash
uv python install 3.12
uv sync --all-packages
```

---

**This skeleton is inspired by the structure and workflow in the `waterloo-slt-reading-group/zoo/python` monorepo.**
