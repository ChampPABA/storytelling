# storytelling

A Claude Code skill for planning presentations using the Storytelling Canvas framework — from raw content to a format-agnostic story blueprint with beat narratives and visual evidence notes.

## What it does

```
/storytelling Help me create a pitch deck about digital transformation for the board
```

Produces a `storytelling.json` containing:
- **Canvas Blueprint** — topic, audience, goal, one big idea, storyline, sparkline
- **Story Beats** — assertion headline, narrative, visual evidence, SUCCESS element, priority, cluster

The output is format-agnostic — any output skill (slides, social posts, articles) can consume it.

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
/storytelling (plan)                output skill (generate)
      │                                  │
      ├─ Receive content                 ├─ Read storytelling.json
      ├─ Clarify missing info            ├─ Adapt beats to format
      ├─ Create blueprint                └─ Produce output
      ├─ User approve/iterate
      ├─ Gen per-beat details
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

## Output Schema

```jsonc
{
  "canvas": {
    "topic": "...",
    "audience": "...",
    "audience_type": "doer | supplier | influencer | innovator",
    "goal": { "before": "...", "after": "..." },
    "one_big_idea": "...",
    "storyline": "pitch | explanation | report | drama",
    "tone": "...",
    "language": "..."
  },
  "beats": [{
    "index": 1,
    "type": "opening | problem | data | star_moment | solution | reward | cta | ...",
    "headline": "Full-sentence assertion summarizing this beat's key message",
    "narrative": "The substance of this beat — what needs to be communicated, in full prose",
    "visual_evidence": "What should be shown to support the headline",
    "success_element": "simplicity | unexpectedness | concreteness | credibility | emotions | storyline | star_moment | null",
    "priority": "essential | important | supplementary",
    "cluster": "opening | problem | evidence | solution | closing"
  }]
}
```

## License

MIT
