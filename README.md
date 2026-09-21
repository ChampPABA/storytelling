# storytelling

A Claude Code skill that builds a **Storytelling Canvas** (Sebastian Kernbach) for any presentation, pitch, or talk. It guides you through the frame (Topic, Audience, Goal, Before, After), then fills the 12 story boxes and saves the result as JSON.

It decides *the story*. Slides, beats, and scripts are the job of a separate presentation-planner or slide skill that reads the canvas.

## What it does

```
/storytelling Help me pitch a CRM budget to the board next week
```

1. Drafts the 5 frame boxes from your content and asks you to confirm or fix them, with examples of good answers and common mistakes
2. Checks the frame (e.g. Goal is yours, After is the audience's; After leads to Goal)
3. Fills Beginning, Middle (SUCCESS), and End
4. Saves `storytelling-canvas.json` and tells the story back to you in chat

## Install

```bash
npx skills add https://github.com/ChampPABA/storytelling --skill storytelling
```

Or globally (all projects):

```bash
npx skills add https://github.com/ChampPABA/storytelling --skill storytelling -g
```

Update:

```bash
npx skills update
```

## The canvas

```
Frame:      Topic · Audience · Goal · Before · After
Beginning:  Start with Why · Common Ground · One Big Idea
Middle:     Simplicity · Unexpectedness · Concreteness · Credibility · Emotions · Storylines · S.T.A.R. moment
End:        Call to Action · Reward
```

**Goal vs After:** Goal is what *you* want (e.g. budget approved). After is what the audience should think / feel / know / want when the story ends. The Goal only happens if the After happens first.

## Output schema

```jsonc
{
  "topic": "...",
  "audience": { "who": "...", "pains": ["..."], "gains": ["..."] },
  "goal": "presenter's outcome",
  "before": { "think": "...", "feel": "...", "know": "...", "want": "..." },
  "after":  { "think": "...", "feel": "...", "know": "...", "want": "..." },
  "beginning": { "start_with_why": "...", "common_ground": "...", "one_big_idea": "..." },
  "middle": {
    "simplicity": { "key_point": "...", "supports": ["...", "...", "..."] },
    "unexpectedness": "...",
    "concreteness": "...",
    "credibility": "...",
    "emotions": "...",
    "storyline": { "type": "report | explanation | pitch | drama", "why": "..." },
    "star_moment": "..."
  },
  "end": {
    "call_to_action": { "audience_type": "doer | supplier | influencer | innovator", "ask": "..." },
    "reward": { "personal": "...", "sphere": "...", "humanity": "..." }
  },
  "gaps": ["evidence still needed"],
  "tone": "...",
  "language": "..."
}
```

## Breaking change (v2)

Earlier versions wrote `storytelling.json` with a `beats` array. v2 writes `storytelling-canvas.json` with the canvas only. Beat planning moved out to presentation-planner / slide skills.

## Source

Kernbach, S. (2018). *Storytelling Canvas: A visual framework for developing and delivering resonating stories.* University of St. Gallen / Stanford d.school. The SUCCESS middle builds on Heath & Heath, *Made to Stick*.

## License

MIT
