---
name: storytelling
description: "Plan presentations using the Storytelling Canvas framework — from raw content to a complete slide-by-slide blueprint with speaker scripts and AI generation prompts. Use this skill whenever the user wants to plan a presentation, create a slide deck outline, structure a pitch, design a talk, write presentation scripts, or prepare content before generating slides. Also triggers on: '/storytelling', 'วางแผน presentation', 'ทำ slide plan', 'plan slides', 'presentation outline', 'pitch deck plan', 'เตรียม slide', 'วางโครง presentation'. Use this even when the user just says 'I need to present X' or pastes content and says 'turn this into slides'. This skill creates the plan — the actual slide generation happens via /gslide afterward."
---

# Storytelling — Presentation Planning Skill

Turn any content into a structured presentation plan with speaker scripts and slide generation prompts. Built on the Storytelling Canvas framework (Kernbach), slide design principles (Duarte, Reynolds, Alley), and AI prompt engineering best practices.

## What This Skill Produces

A `storytelling.json` file containing:
1. **Presentation Blueprint** — shared context for the entire deck (topic, audience, goal, style)
2. **Per-Slide Plan** — for each slide: briefing (for humans) + prompt (for gslide)

This file is the bridge to `/gslide` which generates the actual Google Slides.

## Workflow — 6 Steps

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
| **Duration** | Determines slide count (~1-2 min per slide) |

**Optional inputs (use smart defaults):**

| Field | Default if not specified |
|---|---|
| Tone | "professional" |
| Visual style | "flat vector, clean minimal" |
| Color palette | "navy + accent on white" |
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
Slide Count:    [derived from duration]
Style:          [visual style]
Colors:         [primary / accent / background]
Tone:           [professional / casual / inspiring]
```

**Choosing the storyline type:**
- **Pitch** — user wants approval, budget, buy-in → alternate what-is/what-could-be
- **Explanation** — user wants to teach or inform → progressive complexity
- **Report** — user presents findings/results → data-driven narrative
- **Drama** — user tells a story to inspire → classic hero's journey arc

Show the blueprint to the user for confirmation before proceeding.

### Step 4: Generate Slide Plan

Create a slide-by-slide plan as a table. Read `references/slide-design.md` for detailed guidance on slide types and sequencing.

**Recommended structures by storyline type:**

For **Pitch** (most common):
```
Title → Problem → Data → Unexpected → Divider →
Solution → Process → ROI → S.T.A.R. → Comparison →
Reward → CTA
```

For **Explanation**:
```
Title → Agenda → Concept 1 → Example → Concept 2 →
Example → Concept 3 → Example → Synthesis → Takeaway
```

For **Report**:
```
Title → Executive Summary → Finding 1 → Finding 2 →
Finding 3 → Comparison → Implications → Recommendations → CTA
```

**Display as a table:**

```
| #  | Type      | Story Role       | Sparkline   | Headline (assertion)              | Layout     | ⏱   |
|----|-----------|------------------|-------------|-----------------------------------|------------|------|
| 1  | Title     | Opening          | —           | [presentation title]              | full-bleed | 30s  |
| 2  | Problem   | Start with Why   | What Is     | [full-sentence assertion 8-14 words] | split L-R  | 90s  |
| ...| ...       | ...              | ...         | ...                               | ...        | ...  |
```

**Rules for the plan:**
- **Every headline — including title, divider, and CTA slides — must be a full-sentence assertion** (Alley model) of at least 20 Thai characters or 8 English words. Not a topic label, not a single phrase. Even the title slide needs a full sentence: "IFCG Digital Transformation: ลงทุนวันนี้เพื่อเติบโตอย่างยั่งยืนพร้อมรับอนาคต" not "IFCG Digital Transformation". Even a divider: "ถึงเวลาเปลี่ยนแปลงครั้งสำคัญที่สุดของ IFCG" not "ถึงเวลาเปลี่ยน"
- Each slide has exactly **one idea**
- Alternate between dense slides (data/process) and breathing slides (quote/divider/image) — never more than 3 dense slides in a row
- Total time must fit within the stated duration (use the 80% rule — plan for 80% of available time)

Ask the user: "แก้ไขอะไรไหม? เพิ่ม/ลด/สลับ slide ได้เลย" and iterate until they approve.

### Step 5: Generate Per-Slide Details

Once the plan is approved, generate full details for every slide. Each slide has **3 layers**:

#### Layer 1: Briefing (for humans)

```
Core Takeaway:  [1 sentence — if presenter forgets everything, say this]
Transition IN:  [sentence connecting from previous slide — REQUIRED for every slide except slide 1]
Script:         [what the presenter says — at least 100 Thai characters or 50 English words per slide,
                 even for short slides like dividers and CTAs. Complement, not duplicate the slide]
Transition OUT: [sentence setting up the next slide — REQUIRED for every slide except the last]
```

**Transition and script rules:**
- Slide 1 (title): no transition_in needed, but MUST have transition_out
- Last slide: MUST have transition_in, no transition_out needed
- All other slides: MUST have both transition_in AND transition_out
- Every slide without exception must have a `script` field with substantial content (at least 100 Thai characters). Even a divider slide needs a brief spoken line like "ทีนี้เรามาดูกันว่าทำไมการเปลี่ยนแปลงนี้จึงสำคัญสำหรับทุกคนในห้องนี้ และสิ่งที่เราเตรียมไว้จะช่วยได้อย่างไร"

Read `references/storytelling-canvas.md` Section "SUCCESS Formula" for how to craft each script based on the slide's story role.

#### Layer 2: Slide Spec (structural)

```
Tab:            [infographic / slide / image]
Type:           [title / problem / data / quote / comparison / timeline / CTA / ...]
Layout:         [split-screen / 3-cards / timeline / full-bleed / bento-grid / hub-spoke / ...]
Composition:    [rule-of-thirds / centered / asymmetrical]
Visual Evidence:[chart type / image description / icon set — never bullet points as main content]
Emotional Tone: [alarming / confident / curious / relieved / inspiring]
Duration:       [seconds]
```

#### Layer 3: Generation Prompt (for gslide)

Read `references/prompt-engineering.md` for the complete prompt anatomy. Assemble the prompt following this order (most important first):

```
[Format]      Landscape 16:9 [tab type].
[Layout]      [layout pattern name] layout.
[Style]       [visual style from blueprint].
[Title]       Title: "[exact assertion headline]".
[Content]     [specific data/text/structure to display].
[Color]       [palette from blueprint] on [background].
[Composition] [composition style], generous white space.
[Quality]     Clean, professional, sharp focus.
[Constraints] [negative instructions — no bullets, no decorative elements, text language].
```

The prompt must be self-contained — gslide reads only the prompt, not the rest of the slide spec.

**Show progress to the user** as you generate:
```
กำลังสร้างรายละเอียด 12 slides...
✅ Slide 1/12 — Title
✅ Slide 2/12 — Problem
...
```

### Step 6: Save storytelling.json

Write the complete output to `storytelling.json` in the current working directory.

**Schema:**

```jsonc
{
  "presentation": {
    "topic": "string",
    "audience": "string",
    "goal": {
      "before": "string — audience state before",
      "after": "string — audience state after"
    },
    "one_big_idea": "string — single thesis sentence",
    "storyline": "pitch | explanation | report | drama",
    "sparkline_type": "what_is_vs_what_could_be | progressive | data_driven | hero_journey",
    "visual_style": "string",
    "color_palette": {
      "primary": "#hex",
      "accent": "#hex",
      "background": "#hex"
    },
    "tone": "string",
    "duration_minutes": "number",
    "slide_count": "number",
    "language": "string"
  },
  "slides": [
    {
      "index": 1,
      "tab": "infographic | slide | image",
      "type": "title | problem | data | quote | comparison | timeline | process | divider | reward | cta | ...",
      "story_role": "string — e.g. beginning/start_with_why",
      "sparkline_position": "what_is | what_could_be | shift | neutral",
      "emotional_tone": "string",

      "headline": "string — full-sentence assertion",
      "visual_evidence": "string — what visual supports the assertion",
      "content": ["array of specific data/text items"],
      "core_takeaway": "string — 1 sentence safety net",

      "transition_in": "string",
      "script": "string — 125-300 words",
      "transition_out": "string",
      "duration_seconds": "number",

      "layout": "string — layout pattern name",
      "composition": "string — rule-of-thirds | centered | asymmetrical",
      "quality_modifiers": "string",
      "negative": "string — things to exclude",
      "prompt": "string — complete self-contained prompt for gslide"
    }
  ]
}
```

After saving, tell the user:
```
📄 Saved: storytelling.json (X slides)
👉 Next: use /gslide to generate the actual slides
```

## Important Principles

**On headlines:** Every slide headline is a full-sentence assertion (Michael Alley's model). "ต้นทุนซ่อนเร้นสูงถึง 1.2 ล้านต่อปี" not "ต้นทุน". This is backed by research — audiences understand and remember assertion headlines significantly better than topic labels.

**On content density:** Follow the Glance Test (Nancy Duarte) — if someone can't grasp the slide's point in 3 seconds, there's too much on it. Max 30 words of text per slide. Use visual evidence instead of bullet points.

**On emotional arc:** Presentations that just dump information are forgettable. The Sparkline pattern (Duarte) alternates between "what is" (current reality, problems) and "what could be" (vision, solutions). This creates tension and resolution that keeps audiences engaged. For Pitch storylines, this is essential.

**On prompts:** The generation prompt must be specific and literal. Gemini "Help me visualize" fails on vague prompts and figurative language. Include exact layout names, specific data, color hex codes, and explicit constraints. Read `references/prompt-engineering.md` for the complete guide.

## Reference Files

Read these when you need deeper knowledge:

| File | When to read |
|---|---|
| `references/storytelling-canvas.md` | Step 3 (blueprint) — for SUCCESS formula, story roles, audience types |
| `references/slide-design.md` | Step 4 (plan) — for slide types, sequencing, layout patterns, timing |
| `references/prompt-engineering.md` | Step 5 (detail) — for prompt anatomy, style vocabulary, constraints |
