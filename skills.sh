#!/bin/bash
set -e

REPO="https://github.com/ChampPABA/storytelling.git"
INSTALL_DIR="$HOME/.claude/skills/storytelling"
CLONE_DIR="$HOME/.local/share/storytelling"

echo "Installing storytelling skill for Claude Code..."

# Clone or update repo
if [ -d "$CLONE_DIR/.git" ]; then
    echo "  [1/3] Updating existing installation..."
    git -C "$CLONE_DIR" pull --ff-only
else
    echo "  [1/3] Cloning repository..."
    mkdir -p "$(dirname "$CLONE_DIR")"
    git clone "$REPO" "$CLONE_DIR"
fi

SKILL_SRC="$CLONE_DIR/skills/storytelling"

# Verify source
if [ ! -f "$SKILL_SRC/SKILL.md" ]; then
    echo "  ERROR: SKILL.md not found at $SKILL_SRC/SKILL.md"
    exit 1
fi

# Create skill directory and symlinks
echo "  [2/3] Linking skill..."
mkdir -p "$INSTALL_DIR"
ln -sf "$SKILL_SRC/SKILL.md" "$INSTALL_DIR/SKILL.md"

if [ -d "$SKILL_SRC/references" ]; then
    echo "  [3/3] Linking references..."
    ln -sfn "$SKILL_SRC/references" "$INSTALL_DIR/references"
fi

echo ""
echo "Done!"
echo "  Skill: /storytelling (in Claude Code)"
echo "  Source: $CLONE_DIR"
echo ""
echo "  Update anytime: bash $CLONE_DIR/skills.sh"
echo ""
echo "Usage: /storytelling <your presentation context>"
