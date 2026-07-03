# NexusAI — Design System & UI Guidelines

---

## 1. Design Philosophy

NexusAI follows three core principles:

- **Premium Dark First** — Every surface uses a rich dark palette with depth through gradients and glow accents
- **Mobile First** — Layout is designed from 360px up. Desktop is an enhancement, not the baseline
- **Alive & Responsive** — Nothing is static. Hover states, micro-animations, and transitions make the UI feel tactile

---

## 2. Color Palette

| Token | Value | Usage |
|-------|-------|-------|
| `--bg-primary` | `#0a0e1a` | Main page background |
| `--bg-secondary` | `#0f1629` | Offcanvas / panel background |
| `--bg-card` | `rgba(255,255,255,0.04)` | Cards, input containers |
| `--accent-primary` | `#6c63ff` | Buttons, active borders, glows |
| `--accent-secondary` | `#a855f7` | Gradient endpoints, badges |
| `--text-primary` | `#f0f4ff` | Main readable text |
| `--text-secondary` | `#8b9fc7` | Labels, subtitles |
| `--text-muted` | `#4a5568` | Placeholders, timestamps |
| `--success` | `#10b981` | Online dot, connected status |
| `--danger` | `#ef4444` | Errors, delete actions |
| `--accent-glow` | `rgba(108,99,255,0.3)` | Box-shadow glow effect |

### Background Gradient (Body)
```css
background-image:
  radial-gradient(ellipse 80% 60% at 50% -10%, rgba(108,99,255,0.12), transparent 60%),
  radial-gradient(ellipse 60% 40% at 90% 80%, rgba(168,85,247,0.08), transparent 50%);
background-attachment: fixed;
```

---

## 3. Typography

| Use | Font | Weight | Size |
|-----|------|--------|------|
| Body / UI | Inter (Google Fonts) | 400, 500, 600, 700 | 16px base |
| Code blocks | JetBrains Mono | 400, 500 | 0.8–0.85rem |
| Bot name (navbar) | Inter | 700 | 1.05rem |
| Section labels | Inter | 600 | 0.7rem uppercase |
| Message bubbles | Inter | 400 | 0.9rem |

```html
<!-- Import in HTML head -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700
&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet" />
```

---

## 4. Layout Structure

```
┌─────────────────────────────────────────────────────────┐
│  TOP NAVBAR (fixed, 64px, blur backdrop)                │
│  [🤖 Bot Name · Category]         [🗑️] [⚙️ Settings]   │
└─────────────────────────────────────────────────────────┘
│                                                         │
│  CHAT WINDOW (scrollable, flex column, gap: 1rem)       │
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │  WELCOME SCREEN (shown when no messages)         │  │
│  │  [floating avatar] [title] [subtitle] [chips]    │  │
│  └──────────────────────────────────────────────────┘  │
│                                                         │
│  [👤] ──────────────── User bubble (right)              │
│               Bot bubble (left) ────────── [🤖]         │
│                                                         │
│  [🤖] [...] ← typing indicator                          │
│                                                         │
└─────────────────────────────────────────────────────────┘
│  INPUT BAR (sticky bottom, blur backdrop)               │
│  [ textarea ···················· ] [↺] [➤]              │
│  Enter to send · Shift+Enter for new line               │
└─────────────────────────────────────────────────────────┘

SETTINGS OFFCANVAS (slides from right, 420px max-width)
├── Bot Identity
│   ├── Bot Name (text input)
│   └── Category (select dropdown with emojis)
├── Personality & System Prompt
│   ├── Textarea (6 rows, resizable)
│   └── Quick preset chips
├── Ollama Model
│   ├── Grouped select:
│   │   ├── 🦙 Ollama (Local) — from ollama list
│   │   └── ✨ Google Gemini (API) — when key is set
│   └── Active model badge (green = Ollama, blue = Gemini)
├── Save Configuration (gradient button)
└── API Status indicator
```

---

## 5. Component Specs

### Top Navbar
- Height: `64px`
- Background: `rgba(10,14,26,0.85)` + `backdrop-filter: blur(20px)`
- Border bottom: `1px solid rgba(255,255,255,0.08)`
- Bot avatar: 38×38px circle, gradient fill, glow box-shadow

### Chat Bubbles
| Property | User | Bot |
|----------|------|-----|
| Background | `linear-gradient(135deg, #6c63ff, #a855f7)` | `rgba(255,255,255,0.06)` |
| Border | none | `1px solid rgba(255,255,255,0.08)` |
| Border radius | 20px, bottom-right 4px | 20px, bottom-left 4px |
| Max width | `min(75%, 520px)` | `min(75%, 520px)` |
| Font size | 0.9rem | 0.9rem |

### Typing Indicator
- Three 7px dots
- Color: `--accent-primary`
- Animation: `translateY(-6px)` bounce, staggered 0.2s delays

### Input Bar
- Container: pill-shaped (`border-radius: 28px`)
- Background: `rgba(255,255,255,0.04)` with focus glow
- Send button: 40×40px circle, gradient background, scale on hover
- Textarea: auto-growing, max-height 130px

### Settings Offcanvas
- Width: `min(420px, 100vw)`
- All inputs: custom dark styled (`form-control-custom`)
- Save button: full-width gradient, scale/glow on hover

---

## 6. Animations & Motion

| Element | Animation | Duration |
|---------|-----------|----------|
| Bot avatar (welcome) | `float` — translateY(0 → -8px → 0) | 3s infinite ease-in-out |
| Welcome screen | `fade-up` — opacity 0→1, Y 12px→0 | 0.6s ease |
| New messages | `fade-up` | 0.3s ease |
| Online dot | `pulse-dot` — scale + opacity | 2s infinite |
| Typing dots | `typing-bounce` | 1.2s infinite, staggered |
| Hover buttons | `transform: scale(1.08)` | 0.25s cubic-bezier |
| Toast notification | translateX(-50%) translateY(20px→0) + opacity | 0.35s ease |

---

## 7. Responsive Breakpoints

| Breakpoint | Changes |
|------------|---------|
| `> 576px` | Full layout, "Settings" text visible in navbar button |
| `≤ 576px` | "Settings" text hidden (icon only), reduced padding, bubbles at 88% width |
| `≤ 360px` | Avatars hidden, bubbles at 94% width |

---

## 8. Icon Library

**Bootstrap Icons 1.11.3** — loaded via CDN

| Icon | Usage |
|------|-------|
| `bi-sliders` | Settings button |
| `bi-trash3` | Clear chat (navbar) |
| `bi-send-fill` | Send message |
| `bi-arrow-counterclockwise` | Clear chat (input bar) |
| `bi-robot` | Settings panel header |
| `bi-check2-circle` | Save button |
| `bi-circle-fill` | Active model badge dot |

---

## 9. Category Emoji Map

| Category | Emoji |
|----------|-------|
| General | 🌐 |
| Medical | 🏥 |
| Coding | 💻 |
| Finance | 💰 |
| Education | 📚 |
| Legal | ⚖️ |
| HR & Recruitment | 👔 |
| Customer Support | 🎧 |
| Fitness & Health | 🏋️ |
| Travel | ✈️ |
| Science | 🔬 |
| Creative Writing | ✍️ |
| Custom | ⚙️ |

---

## 10. Glassmorphism Pattern

Used on all interactive surfaces:

```css
background: rgba(255, 255, 255, 0.04);
border: 1px solid rgba(255, 255, 255, 0.08);
backdrop-filter: blur(20px);
-webkit-backdrop-filter: blur(20px);
```

On focus/hover:
```css
background: rgba(108, 99, 255, 0.07);
border-color: rgba(108, 99, 255, 0.5);
box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.15);
```
