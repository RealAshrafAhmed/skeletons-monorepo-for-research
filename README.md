# Skeletons Python Research Monorepo

## Cheatsheet

```bash
# Install all dependencies (main + dev)
uv sync --extra dev

# Install only main dependencies
uv sync

# Start Jupyter Lab (with auto-kernel registration)
./scripts/lab.sh

# Or start Jupyter Lab directly
uv run jupyter-lab

# Format code
uv run ruff format .

# Lint code
uv run ruff check .

# Run tests
uv run pytest

# Set up pre-commit hooks (after installing dev dependencies)
uv run pre-commit install
```

---

# For those who want to read...

A production-ready template for managing multiple research projects and shared libraries in a single repository using modern Python tooling.

## Why This Structure?

**Problem:** Research codebases often become messy: scattered notebooks, duplicated utility code, inconsistent dependencies, and no testing infrastructure.

**Solution:** This monorepo structure provides:

- **📦 Shared Packages**: Write utilities once, use everywhere. Packages can be imported in any notebook or project.
- **🔬 Isolated Projects**: Each research project gets its own directory with dependencies, while sharing common code.
- **📓 Notebook-Friendly**: Jupyter integration that actually works - imports from local packages seamlessly.
- **🔄 Reproducibility**: Lockfile ensures everyone uses the same dependency versions. Pre-commit hooks enforce code quality.
- **⚡ Fast Iteration**: `uv` makes dependency management fast and ergonomic.
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

# Install all dependencies (main + dev)
uv sync --extra dev

# Set up pre-commit hooks (optional but recommended)
uv run pre-commit install

# Start Jupyter Lab (with auto-kernel registration)
./scripts/lab.sh
```

[// Dependency Structure]

## Dependency Structure

This project uses a structured approach to dependencies:

- **Production dependencies**: Core packages required for running simulations, including `papermill` for programmatic notebook execution.
- **Dev dependencies**: Development tools including Jupyter Lab, formatters, linters, test runners, and interactive notebook tools.

To install different dependency sets:

```bash
# Install only main dependencies (production)
uv sync

# Install main + dev dependencies (development)
uv sync --extra dev

# Install all dependency groups
uv sync --all-groups
```
## Common Commands

### Packages

```bash
# Sync workspace packages and dependencies
uv sync --extra dev

# Add a dependency to a specific package
cd packages/my_package && uv add numpy

# Add a dev dependency to root
uv add --dev pytest

# Add a main dependency to root
uv add papermill

# Force full reinstall (nuclear option)
rm uv.lock && uv sync --extra dev
```

### Jupyter

```bash
# Start Jupyter Lab with automatic kernel registration (recommended)
./scripts/lab.sh

# Or start Jupyter Lab directly
uv run jupyter-lab

# Register kernel manually (if kernel issues)
uv run python -m ipykernel install --user --name=skeletons-monorepo

# Run notebooks programmatically (production)
uv run papermill input.ipynb output.ipynb -p param_name param_value
```

**Note:** The `./scripts/lab.sh` script automatically registers the current environment as a Jupyter kernel before starting Jupyter Lab. Always restart the Jupyter kernel after installing/updating packages.

### Development

```bash

# Format code
uv run ruff format .

# Lint code
uv run ruff check .

# Run tests
uv run pytest

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
uv sync --extra dev
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

   # Add dev/jupyter tools
   uv add --dev jupyterlab ipykernel
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
# Add to main dependencies (available everywhere)
uv add wandb
# or
uv add mlflow

# Then sync
uv sync --extra dev
```

### Adding GPU Dependencies

```bash
# Add PyTorch with CUDA support
uv add torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Or add to pyproject.toml dependencies and sync
uv sync --extra dev
```

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

### Dependency Philosophy

- **Main dependencies**: Only packages needed for production/simulation runs (notably `papermill` for programmatic notebook execution)
- **Dev dependencies**: All interactive and development tools (Jupyter Lab, formatters, linters, etc.)
- **Clean separation**: Keeps production environments lean while full dev environment has everything needed

### Alternatives Considered

- **Separate repos per project**: Too much overhead, code duplication
- **Single directory with utils.py**: Breaks at scale, no proper imports
- **Poetry monorepo**: Slower, less ergonomic workspace support
- **Conda environments**: Slow, large, not reproducible enough

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development workflow and guidelines.

## License

MIT License - see [LICENSE](LICENSE) for details.
