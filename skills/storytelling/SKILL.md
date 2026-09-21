---
name: storytelling
description: "Build a Storytelling Canvas (Kernbach) for any presentation, pitch, talk, or message: guides the user through Topic, Audience, Goal, Before and After, then fills the 12 story boxes (Beginning / SUCCESS middle / End) and saves storytelling-canvas.json plus a spoken summary. Use this whenever the user wants to plan what a presentation or pitch should say, figure out the story or key message before making slides, prepare a talk, or says '/storytelling', 'storytelling canvas', 'วางแผน presentation', 'วางโครง presentation', 'คิด story', 'เตรียม pitch', 'จะไป present เรื่อง X'. Use it even when the user just pastes content and says 'turn this into a presentation': the canvas comes first. This skill decides the story only; slide layout, beats, and scripts belong to a presentation-planner or slide skill that reads the canvas afterward."
---

# Storytelling Canvas

Turn raw content into a filled **Storytelling Canvas** (Sebastian Kernbach, see `references/storytelling-canvas.md`). The canvas answers *what story are we telling, to whom, and why*. It does not decide slides, beats, or scripts; a downstream skill does that from the canvas.

The canvas has 17 boxes:

```
Frame (asked):   Topic · Audience · Goal · Before · After
Beginning:       Start with Why · Common Ground · One Big Idea
Middle:          Simplicity · Unexpectedness · Concreteness · Credibility · Emotions · Storylines · S.T.A.R. moment
End:             Call to Action · Reward
```

The 5 frame boxes come from the user. The 12 story boxes you write from the content, shaped by the frame.

## Step 1: Take in the content

Content can arrive as pasted text, a file path, a URL, or a NotebookLM notebook. Read it all. Don't ask the user to restructure it.

## Step 2: Guide the user through the frame

The frame is where stories go wrong, and it's where users get confused, especially between **Goal** and **After**. Your job is to make each box easy to answer correctly.

**Draft first, then ask.** From the content and conversation, draft your best answer for every frame box. Then show the drafts and ask the user to confirm or fix them. Correcting a draft is much easier than answering a blank question. Only ask open questions for boxes you genuinely can't draft.

**Ask in two rounds**, because Before/After depend on who the audience is:
- Round 1: Topic, Audience, Goal
- Round 2: Before, After

For each box, show: the question, your draft, and the common mistake to avoid. Use this guide:

| Box | The question | Good answer | Common mistake |
|---|---|---|---|
| **Topic** | What is this story about, in one sentence? | "Why our sales team needs a CRM before Q1" | Too broad: "CRM", "AI" |
| **Audience** | Who is listening, what hurts them (pains), and what do they want (gains)? | "Board of 5. Pain: margins down 3 quarters. Gain: growth without adding headcount" | Only a job title, no pains/gains |
| **Goal** | What do **you** (the presenter) want to walk away with? | "Board approves 2M THB budget this meeting" | Describing the audience's feelings: that belongs in After |
| **Before** | Right now, what does the audience **think / feel / know / want**? | Think: "CRM is a nice-to-have". Feel: skeptical. Know: nothing about the cost of lost leads. Want: to cut spending | One blob instead of 4 separate lenses |
| **After** | When the story ends, what should they **think / feel / know / want**? | Think: "Lost leads cost more than the CRM". Feel: urgent. Know: 18-month payback. Want: to approve today | Pasting your Goal here |

**Goal vs After, explained for the user** (say this when they mix them up): Goal is *your* outcome. After is *what must change in their heads* so they give you that outcome. The Goal only happens if the After happens first.

**Check the frame before moving on.** These checks catch a broken frame early, when it's cheap to fix:
- Goal is written about the presenter; After is written about the audience. If a Goal sentence is really about audience feelings, move it to After.
- After.want leads directly to the Goal. If the audience "wants" something that doesn't get you your Goal, the story will end in the wrong place.
- Before and After differ in at least one lens. If they're the same, the story has no job to do.
- Audience has pains or gains. Start with Why is built from them.

If a check fails, point it out in plain words, suggest a fix, and let the user decide.

Tone and language default to "professional" and the language of the input; don't ask unless it matters.

When all 5 boxes pass the checks, show the full frame once and get a yes before Step 3.

## Step 3: Fill the 12 story boxes

Read `references/storytelling-canvas.md` for what each box needs and how to write it well. The short version:

- **Beginning** earns attention. *Start with Why* answers "why should I care?" using the audience's pains/gains. *Common Ground* is a shared past experience or a shared future vision. *One Big Idea* is one complete sentence that states the unique perspective and what's at stake.
- **Middle** makes the point with the right mix of information and emotion. Fill every SUCCESS box; a box you skip is a dimension the story is missing. *Storylines* is where you pick report / explanation / pitch / drama and say why.
- **End** lands it. *Call to Action* is a concrete ask matched to the audience type (doer / supplier / influencer / innovator). *Reward* covers personal, sphere (people around them), and humanity.

Everything must trace back to the frame: Start with Why comes from Audience pains/gains, the Middle moves them from Before to After, and the Call to Action is the step that turns After into the Goal.

**Don't invent evidence.** If the content has no statistic, quote, or case for Credibility or Concreteness, don't make one up. Write what kind of evidence is needed and add it to `gaps`. A canvas with honest gaps is useful; a canvas with fake numbers is dangerous once it reaches a slide.

## Step 4: Save and summarize

Write `storytelling-canvas.json` to the current working directory:

```jsonc
{
  "topic": "string",
  "audience": {
    "who": "string",
    "pains": ["string"],
    "gains": ["string"]
  },
  "goal": "string, the presenter's outcome",
  "before": { "think": "string", "feel": "string", "know": "string", "want": "string" },
  "after":  { "think": "string", "feel": "string", "know": "string", "want": "string" },

  "beginning": {
    "start_with_why": "string",
    "common_ground": "string",
    "one_big_idea": "string, one complete sentence"
  },
  "middle": {
    "simplicity": { "key_point": "string", "supports": ["string", "string", "string"] },
    "unexpectedness": "string",
    "concreteness": "string",
    "credibility": "string",
    "emotions": "string",
    "storyline": { "type": "report | explanation | pitch | drama", "why": "string" },
    "star_moment": "string"
  },
  "end": {
    "call_to_action": {
      "audience_type": "doer | supplier | influencer | innovator",
      "ask": "string, concrete and specific"
    },
    "reward": { "personal": "string", "sphere": "string", "humanity": "string" }
  },

  "gaps": ["string, evidence or facts still needed"],
  "tone": "string",
  "language": "string"
}
```

Then tell the story back to the user in chat, in the canvas language, as a short spoken walkthrough (about 8 to 15 lines): how it opens, what the middle proves, where it lands, and what you're asking for. This lets them hear whether the story works without reading JSON. List any `gaps` after it, then the file path.

Finish with:
```
📄 storytelling-canvas.json พร้อมแล้ว: ส่งต่อให้ presentation planner หรือ slide skill ได้เลย
```
