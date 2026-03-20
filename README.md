# storytelling

Claude Code skill สำหรับวางแผน presentation ด้วย Storytelling Canvas framework — จาก content ดิบ ไปจนถึง slide plan พร้อม speaker script และ AI generation prompt

## ทำอะไรได้

```
/storytelling ช่วยทำ slide เรื่อง digital transformation ให้ board อนุมัติงบ 15 นาที
```

ได้ `storytelling.json` ที่มี:
- **Presentation Blueprint** — topic, audience, goal, storyline, visual style, color palette
- **Per-slide plan** — headline, script, transitions, layout, gslide prompt

ใช้คู่กับ [`/gslide`](https://github.com/ChampPABA/gslide) เพื่อสร้าง Google Slides จริง

## Install

```bash
git clone https://github.com/ChampPABA/storytelling.git
cd storytelling
bash skills.sh
```

## Flow

```
/storytelling (วางแผน)          /gslide (สร้างจริง)
      │                              │
      ├─ รับ content                  ├─ อ่าน storytelling.json
      ├─ ถามสิ่งที่ขาด                ├─ สร้าง/เลือก presentation
      ├─ สร้าง blueprint             ├─ gen slides ทีละอัน
      ├─ สร้าง slide plan            └─ report link
      ├─ user approve
      ├─ gen detail ทุก slide
      └─ บันทึก storytelling.json
```

## Frameworks

สร้างจากการผสมผสาน:

| แหล่งความรู้ | ใช้ทำอะไร |
|---|---|
| **Storytelling Canvas** (Kernbach) | โครงสร้างเรื่อง 3-Act, SUCCESS formula |
| **Sparkline** (Nancy Duarte) | What Is ↔ What Could Be emotional arc |
| **Assertion-Evidence Model** (Michael Alley) | Headline เป็นประโยคสมบูรณ์ + visual evidence |
| **Presentation Zen** (Garr Reynolds) | Simplicity, white space, picture superiority |
| **AI Prompt Engineering** | 9-component prompt anatomy สำหรับ Gemini |

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
    "headline": "ประโยคสมบูรณ์ที่สรุปข้อความหลักของ slide นี้",
    "script": "สิ่งที่ผู้พูดจะพูด...",
    "transition_in": "...",
    "transition_out": "...",
    "prompt": "Landscape 16:9 infographic. Split-screen layout..."
  }]
}
```

## License

MIT
