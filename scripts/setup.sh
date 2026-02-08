#!/bin/bash
# Complete workspace setup script
# This script installs all dependencies and builds workspace packages

set -e  # Exit on any error

echo "🚀 Setting up workspace..."

# Install all dependencies (including workspace packages)
echo "📦 Installing all dependencies and building workspace packages..."
uv sync --extra dev

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  • Run './scripts/lab.sh' to start Jupyter Lab"
echo "  • Run 'uv run pre-commit install' to set up pre-commit hooks"
echo "  • Check README.md for more commands"
