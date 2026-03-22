---
name: storytelling
description: "Plan presentations using the Storytelling Canvas framework — from raw content to a format-agnostic story blueprint with speaker scripts and visual evidence notes. Use this skill whenever the user wants to plan a presentation, create a slide deck outline, structure a pitch, design a talk, write presentation scripts, or prepare content before generating slides. Also triggers on: '/storytelling', 'วางแผน presentation', 'ทำ slide plan', 'plan slides', 'presentation outline', 'pitch deck plan', 'เตรียม slide', 'วางโครง presentation'. Use this even when the user just says 'I need to present X' or pastes content and says 'turn this into slides'. This skill creates the storytelling plan — the actual slide or content generation happens via a separate output skill afterward."
---

# Storytelling — Presentation Planning Skill

Turn any content into a structured story plan with speaker scripts and visual evidence notes. Built on the Storytelling Canvas framework (Kernbach) and slide design principles (Duarte, Reynolds, Alley).

## What This Skill Produces

A `storytelling.json` file containing:
1. **Presentation Blueprint** — shared context for the entire story (topic, audience, goal, narrative arc)
2. **Story Beats** — each beat is a content unit with: headline, speaker script, visual evidence, and story metadata

Beats are story units, not slides. One beat may become 1 slide, multiple slides, or part of a slide — that mapping is the output skill's responsibility.

This file is a format-agnostic content plan — usable by any output skill: slide generators, social media posts, TikTok scripts, articles, etc.

## Workflow — 5 Steps

### Step 1: Receive Content

Accept content from any source:
- User types/pastes directly
- Reference to a NotebookLM notebook
- File path to a document
- URL

Read or gather the raw content. Don't ask the user to restructure it — that's your job.

### Step 2: Clarify (ask only what's missing)

Check what information you already have from the content and conversation. Only ask for what's genuinely missing. Never ask more than 3 questions at once.

**Required inputs (must have before proceeding):**

| Field | Why it matters |
|---|---|
| **Audience** | Determines vocabulary, depth, emotional appeals |
| **Goal (Before → After)** | What should the audience think/feel/do differently after? |
| **Duration** | Determines story pacing and beat count (~1-2 min per beat) |

**Optional inputs (use smart defaults):**

| Field | Default if not specified |
|---|---|
| Tone | "professional" |
| Language | Same as input content |

If the user gives a brief like "pitch to investors, 10 min" — you already know audience (investors), goal (get funding), duration (10 min). Don't re-ask. Just confirm your interpretation.

### Step 3: Create Presentation Blueprint

Synthesize everything into a per-presentation blueprint. Read `references/storytelling-canvas.md` for the full framework, but here's the core:

```
Presentation Blueprint
──────────────────────
Topic:          [what it's about]
Audience:       [who + what they care about]
Goal:           Before: [current state]
                After:  [desired state]
One Big Idea:   [single sentence — the thesis]
Storyline:      [Report / Explanation / Pitch / Drama]
Sparkline:      [What Is ↔ What Could Be pattern]
Tone:           [professional / casual / inspiring]
Language:       [Thai / English / mixed]
```

**Choosing the storyline type:**
- **Pitch** — user wants approval, budget, buy-in → alternate what-is/what-could-be
- **Explanation** — user wants to teach or inform → progressive complexity
- **Report** — user presents findings/results → data-driven narrative
- **Drama** — user tells a story to inspire → classic hero's journey arc

Show the blueprint to the user for confirmation before proceeding.

### Step 4: Generate Per-Beat Details

Once the blueprint is approved, go straight to generating full details for every beat — do not produce an intermediate beat plan table. Beat count comes from duration (~1-2 min per beat), and S.T.A.R. moment belongs in the middle-to-late section of the story after tension has built, not in the first few beats.

Each beat has **2 layers**:

#### Layer 1: Briefing (for humans)

```
Core Takeaway:  [1 sentence — if the audience forgets everything, they remember this]
Transition IN:  [sentence connecting from previous beat — needed for every beat except the first]
Script:         [what the presenter/author says — at least 100 Thai characters or 50 English words,
                 even for short beats like dividers and CTAs. Complement, not duplicate the content]
Transition OUT: [sentence setting up the next beat — needed for every beat except the last]
```

**Why transitions matter:** Each beat must flow into the next — without transitions, the story feels like disconnected information. The transition_in reminds the audience where they are; the transition_out creates anticipation for what comes next. Beat 1 has no transition_in (it's the opening). The last beat has no transition_out (it ends with the CTA).

Every beat needs a script, even short ones. A divider beat still has a spoken line that carries the audience across the arc.

Read `references/storytelling-canvas.md` Section "SUCCESS Formula" for how to craft each script based on the beat's story role.

#### Layer 2: Beat Spec (format-agnostic)

```
SUCCESS Element:[which element of the Canvas this beat addresses:
                 simplicity / unexpectedness / concreteness / credibility / emotions / storyline / star_moment
                 — null for opening, divider, reward, and CTA beats]
Visual Evidence:[what should be shown to support the headline — described as content intent,
                 not as a prompt. e.g. "bar chart comparing 3 competitors" not "flat vector infographic"]
Emotional Tone: [alarming / confident / curious / relieved / inspiring / shocking / nostalgic]
```

**Why SUCCESS element matters:** The middle section of a story must cover all dimensions of the Canvas — Simplicity, Unexpectedness, Concreteness, Credibility, Emotions. Tagging each beat keeps the story balanced and prevents over-indexing on one type (e.g., 5 data beats in a row).

**Show progress to the user** as you generate:
```
กำลังสร้างรายละเอียด 12 beats...
✅ Beat 1/12 — Opening
✅ Beat 2/12 — Common Ground
...
```

### Step 5: Save storytelling.json

Write the complete output to `storytelling.json` in the current working directory.

**Schema:**

```jsonc
{
  "canvas": {
    // — General Conditions (Kernbach) —
    "topic": "string",
    "audience": "string",
    "audience_type": "doer | supplier | influencer | innovator",
    "audience_analysis": {
      "before": {
        "think": "string — what they currently believe",
        "feel": "string — how they currently feel",
        "know": "string — what they currently know",
        "want": "string — what they currently want to do"
      },
      "after": {
        "think": "string — what they should believe",
        "feel": "string — how they should feel",
        "know": "string — what they should know",
        "want": "string — what they should want to do"
      }
    },
    "goal": {
      "before": "string — summary of audience state before",
      "after": "string — summary of desired state after"
    },
    "one_big_idea": "string — single thesis sentence, the one thing they must remember",
    "common_ground": "string — shared experience or vision between presenter and audience",

    // — Story Architecture —
    "storyline": "pitch | explanation | report | drama",
    "plot_type": "man_in_a_hole | rags_to_riches | cinderella | icarus | riches_to_rags | oedipus",
    "conflict_type": "self_vs_self | self_vs_others | self_vs_environment",
    "sparkline_type": "what_is_vs_what_could_be | progressive | data_driven | hero_journey",
    "star_moment_index": "number — index of the S.T.A.R. moment beat",

    // — Ending —
    "reward": {
      "personal": "string — how the audience personally benefits",
      "sphere": "string — how it benefits people around them",
      "humanity": "string — how it contributes to something larger"
    },

    // — Delivery —
    "tone": "string",
    "language": "string"
  },
  "beats": [
    {
      "index": 1,
      "type": "opening | common_ground | problem | data | star_moment | divider | solution | process | roi | comparison | reward | cta | ...",
      "story_role": "string — e.g. beginning/start_with_why, middle/credibility, end/reward",
      "success_element": "simplicity | unexpectedness | concreteness | credibility | emotions | storyline | star_moment | null",
      "sparkline_position": "what_is | what_could_be | shift | neutral",
      "emotional_tone": "string",

      "headline": "string — full-sentence assertion (Alley model)",
      "visual_evidence": "string — what should be shown to support the headline, described as content intent",
      "content": ["array of specific data/text items to include"],
      "core_takeaway": "string — 1 sentence: if they forget everything else, they remember this",

      "transition_in": "string | null",
      "script": "string — spoken words, 100+ Thai chars or 50+ English words",
      "transition_out": "string | null"
    }
  ]
}
```

After saving, tell the user:
```
📄 storytelling.json พร้อมแล้ว (X beats) — นำไปใช้ต่อได้เลย
```

Note: `storytelling.json` เป็น format-agnostic content plan — skill ใดก็ได้รับไปเป็น context แล้วตีความสู่ output format ของตัวเอง

## Important Principles

**On beat types:** Each beat has exactly one `type` — the primary narrative function (opening, problem, data, solution, star_moment, etc.). If a beat is trying to do two things at once (e.g., establish common ground AND deliver the S.T.A.R. moment), split it into two beats. The `success_element` field is separate — it tags which Canvas dimension the beat serves, not the narrative role.

**On S.T.A.R. placement:** The S.T.A.R. moment is the climax of the story — it lands hardest when tension has been building through the Middle section. Placing it in the first 3 beats kills the arc before it starts. A 12-beat story should have its S.T.A.R. around beats 7-9.

**On beats vs slides:** Beats are story units, not slides. A beat represents one narrative idea — it may become 1 slide, multiple slides, or share a slide with another beat. The split into visual units is the output skill's responsibility. Don't think in slides when planning beats.

**On headlines:** Every beat headline is a full-sentence assertion (Michael Alley's model). "ต้นทุนซ่อนเร้นสูงถึง 1.2 ล้านต่อปี" not "ต้นทุน". This is backed by research — audiences understand and remember assertion headlines significantly better than topic labels.

**On content density:** Each beat carries exactly one idea. If you find yourself putting two arguments, two data points, or two emotional appeals into a single beat — split it. The script can elaborate, but the headline and core takeaway must be singular and sharp. Audiences remember one thing per moment, not five.

**On emotional arc:** Stories that just dump information are forgettable. The Sparkline pattern (Duarte) alternates between "what is" (current reality, problems) and "what could be" (vision, solutions). This tension and resolution keeps the audience engaged and makes the final vision feel earned. For Pitch storylines, this is essential — tag each beat's `sparkline_position` carefully to maintain the rhythm.

**On SUCCESS elements:** The middle section of a story must cover all 7 elements of the Canvas (Simplicity, Unexpectedness, Concreteness, Credibility, Emotions, Storylines, S.T.A.R. moment). Tagging each beat keeps you honest — if you look at your `success_element` tags and see only "data/credibility" beats, the story is too dry. Balance information with emotion.

## Reference Files

Read these when you need deeper knowledge:

| File | When to read |
|---|---|
| `references/storytelling-canvas.md` | Step 3 (blueprint) — for SUCCESS formula, story roles, audience types |
