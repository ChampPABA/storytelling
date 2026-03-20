#!/bin/bash
set -e

echo "Installing storytelling skill for Claude Code..."

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_SRC="$SCRIPT_DIR/skills/storytelling"
SKILL_DIR="$HOME/.claude/skills/storytelling"

# Verify source exists
if [ ! -f "$SKILL_SRC/SKILL.md" ]; then
    echo "  ERROR: SKILL.md not found at $SKILL_SRC/SKILL.md"
    exit 1
fi

# Create skill directory
mkdir -p "$SKILL_DIR"

# Symlink SKILL.md
ln -sf "$SKILL_SRC/SKILL.md" "$SKILL_DIR/SKILL.md"
echo "  [1/2] Linked: SKILL.md"

# Symlink references directory
if [ -d "$SKILL_SRC/references" ]; then
    ln -sfn "$SKILL_SRC/references" "$SKILL_DIR/references"
    echo "  [2/2] Linked: references/"
fi

echo ""
echo "Done!"
echo "  Skill: /storytelling (in Claude Code)"
echo ""
echo "  Skill is symlinked — updates automatically when you git pull."
echo ""
echo "Usage: /storytelling <your presentation context>"
