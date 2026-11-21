# ⚡ Deve-To-S Circuit
> **The Direct Mentorship, Recruiting & Innovation Bridge Connecting Degree/B.Tech Students with Developers & Entrepreneurs.**  
> *Engineered for IQX 24 Hackathon | White & Royal Blue Futuristic Architecture*

---

## 🚀 Quick Start (Run in VS Code in 60 Seconds)

```bash
# 1. Navigate to the project directory
cd deve-to-s-circuit

# 2. Install all dependencies
npm install

# 3. Launch local development server
npm run dev
```

Visit **`http://localhost:3000`** in your browser.

---

## 🎯 What is Deve-To-S Circuit?

Unlike **LinkedIn** (noisy corporate flex, paywalled InMails, cold DMs ignored), **Internshala/Naukri** (transactional employer-employee portals with no dev interaction), or **Telegram groups** (unverified, chaotic, riddled with fake internship scams):

**Deve-To-S Circuit** provides a dedicated, verified ecosystem with:
1. **Direct Mentorship Messenger**: 1st-year students and degree freshers can message senior engineers directly & freely without connection fees or writer's block (using 1-click icebreaker prompts).
2. **Daily Tech Pulse**: A curated, live community feed covering what is happening today in tech (AI breakthroughs, framework releases, cloud changes, and cybersecurity alerts).
3. **1-on-1 Mock Interview Arena**: Students schedule mock technical and HR rounds with senior engineers; mentors evaluate them against clear rubrics.
4. **Talent Scout & Recruitment Board**: Engineers and tech startups discover and recruit vetted freshers based on real GitHub code and hackathon credentials.
5. **Founder Launchpad**: BBA students and non-technical entrepreneurs pitch startup concepts directly to developers to build MVPs with equity/stipends.
6. **Supabase Real Registration & Database**: Production PostgreSQL schema with Row-Level Security (RLS) for Auth, Posts, DMs, Mock Slots, and Startup Pitches.

---

## 👥 6-Member Team Division of Labor (12-13 Hour Hackathon Plan)

| Member | Focus Area | 12-Hour Deliverables |
| :--- | :--- | :--- |
| **Member 1 (Lead - Laxmisairam)** | **Architecture & Integration** | VS Code workspace orchestration, state flow, testing, and pitch narration. |
| **Member 2** | **Direct Messenger & Icebreakers** | Polish chat threads, typing simulations, and real-time mentor responses. |
| **Member 3** | **Daily Tech Pulse Feed** | Curate daily breaking tech news, upvote state, and category filtering. |
| **Member 4** | **Mock Interview System** | Booking slot calendar, rubric ratings, and video room link generator. |
| **Member 5** | **Supabase DB & Authentication** | Supabase project creation, running `supabase-schema.sql`, linking `.env`. |
| **Member 6** | **Founder Arena & Pitch Deck** | Startup pitch cards, 3-minute live pitch slides, and demo script testing. |

---

## 🗄️ Supabase Setup (3 Minutes)

The app is **100% functional out-of-the-box** in prototype mode with pre-loaded demo accounts! To connect your team's live Supabase database:

1. Create a free project at [supabase.com](https://supabase.com).
2. Open the **SQL Editor** in Supabase and paste the contents of `supabase-schema.sql`. Click **Run**.
3. Create a `.env` file in the root folder:
   ```env
   VITE_SUPABASE_URL=https://your-project-id.supabase.co
   VITE_SUPABASE_ANON_KEY=your-anon-public-key
   ```
4. Restart your Vite dev server (`npm run dev`). The top bar will show `🟢 Live Supabase Database Connected`.

---

## 🏆 Key Features Demonstrated in the UI

- **Role Switcher in Navbar**: Instantly toggle between **Student**, **Senior Developer**, and **Founder** views to show judges how each persona experiences the platform.
- **Icebreaker Quick Prompts**: Eliminates fresher shyness with instant prompts for 1st-year roadmaps, project feedback, and resume checks.
- **Glassmorphic Circuit Aesthetics**: Custom white + royal blue design with circuit borders, neon accents, and responsive layout.
