# storytelling

A Claude Code skill for planning presentations using the Storytelling Canvas framework — from raw content to a complete slide-by-slide blueprint with speaker scripts and AI generation prompts.

## What it does

```
/storytelling Help me create a 15-minute pitch deck about digital transformation for the board
```

Produces a `storytelling.json` containing:
- **Presentation Blueprint** — topic, audience, goal, storyline, visual style, color palette
- **Per-slide plan** — assertion headline, speaker script, transitions, layout, generation prompt

Pair with [`/gslide`](https://github.com/ChampPABA/gslide) to generate the actual Google Slides.

## Install

```bash
npx skills add https://github.com/ChampPABA/storytelling --skill storytelling
```

Or install globally (available across all projects):

```bash
npx skills add https://github.com/ChampPABA/storytelling --skill storytelling -g
```

## Flow

```
/storytelling (plan)                /gslide (generate)
      │                                  │
      ├─ Receive content                 ├─ Read storytelling.json
      ├─ Clarify missing info            ├─ Create/select presentation
      ├─ Create blueprint                ├─ Gen slides one by one
      ├─ Generate slide plan             └─ Report link
      ├─ User approve/iterate
      ├─ Gen per-slide details
      └─ Save storytelling.json
```

## Frameworks

Built by combining established presentation design research:

| Source | What it provides |
|---|---|
| **Storytelling Canvas** (Kernbach) | 3-Act story structure, SUCCESS formula |
| **Sparkline** (Nancy Duarte) | What Is ↔ What Could Be emotional arc |
| **Assertion-Evidence Model** (Michael Alley) | Full-sentence headlines + visual evidence |
| **Presentation Zen** (Garr Reynolds) | Simplicity, white space, picture superiority |
| **AI Prompt Engineering** | 9-component prompt anatomy for Gemini |

## Output Schema

```jsonc
{
  "presentation": {
    "topic": "...",
    "audience": "...",
    "goal": { "before": "...", "after": "..." },
    "one_big_idea": "...",
    "storyline": "pitch | explanation | report | drama",
    "visual_style": "...",
    "color_palette": { "primary": "#hex", "accent": "#hex", "background": "#hex" },
    "tone": "...",
    "duration_minutes": 15
  },
  "slides": [{
    "index": 1,
    "tab": "infographic",
    "type": "problem",
    "headline": "Full-sentence assertion summarizing this slide's key message",
    "script": "What the presenter says...",
    "transition_in": "...",
    "transition_out": "...",
    "prompt": "Landscape 16:9 infographic. Split-screen layout..."
  }]
}
```

## License

MIT
