-- ═══════════════════════════════════════════════════════════════
--  AIVengers Mission Control — Database Setup v3.0
--  Run this in your Supabase SQL editor
-- ═══════════════════════════════════════════════════════════════

-- ── Core tables ───────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS agent_logs (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  agent text NOT NULL,
  action text NOT NULL,
  details text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS todos (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  title text NOT NULL,
  status text DEFAULT 'todo' CHECK (status IN ('todo', 'in_progress', 'review', 'done')),
  agent text,
  priority text DEFAULT 'medium' CHECK (priority IN ('low', 'medium', 'high')),
  created_at timestamptz DEFAULT now()
);

-- ── v3.0 New Tables ───────────────────────────────────────────

CREATE TABLE IF NOT EXISTS cron_jobs (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  agent text,
  schedule text,
  description text,
  next_run timestamptz,
  active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS projects (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name text NOT NULL,
  description text,
  progress int DEFAULT 0,
  status text DEFAULT 'active',
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS memories (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  date date,
  agent text,
  content text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS documents (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  title text,
  content text,
  doc_type text,
  agent text,
  created_at timestamptz DEFAULT now()
);

-- ═══════════════════════════════════════════════════════════════
--  SEED DATA
-- ═══════════════════════════════════════════════════════════════

-- ── Agent Logs ────────────────────────────────────────────────
INSERT INTO agent_logs (agent, action, details) VALUES
  ('SAGE',  'System initialized',       'AIVengers Mission Control v1.0 online — Day 1'),
  ('CODY',  'Dashboard built',          'Mission Control v2.0 deployed with Kanban + Supabase'),
  ('SAGE',  'Accounts created',         'Proton Mail, GitHub, Supabase all configured and live'),
  ('CODY',  'Mission Control v3.0',     '8-tab premium dashboard deployed — Office, Projects, Memory, Calendar, Documents, Team'),
  ('SAGE',  'Team briefing',            'All 5 agents (SAGE, CODY, ORACLE, NOVA, TITAN) registered in system'),
  ('ORACLE','AI landscape scan',        'Monitoring GPT-5, Gemini Ultra, Claude Sonnet — tracking competitive models'),
  ('NOVA',  'Research initiated',       'Minimax Video API capabilities — content pipeline feasibility study'),
  ('SAGE',  'Strategy session',         'Q1 2026 roadmap defined: brand, content, first $10k revenue milestone'),
  ('CODY',  'Pipeline architecture',    'Designing NOVA→SAGE→CODY agent delegation workflow');

-- ── Todos ─────────────────────────────────────────────────────
INSERT INTO todos (title, status, agent, priority) VALUES
  ('Verify X/Twitter account',               'todo',        'JP',     'high'),
  ('Connect Discord for agent channels',     'todo',        'CODY',   'high'),
  ('Build agent pipeline NOVA→SAGE→CODY',   'in_progress', 'CODY',   'high'),
  ('Set up X API developer access',          'todo',        'JP',     'medium'),
  ('Research Minimax Video API',             'in_progress', 'NOVA',   'medium'),
  ('Design AIVengers brand identity',        'todo',        'SAGE',   'high'),
  ('Create first viral content piece',       'todo',        'CODY',   'medium'),
  ('NEXUS bracelet product page',            'todo',        'CODY',   'medium'),
  ('Monitor GPT-5 release timeline',         'in_progress', 'ORACLE', 'low'),
  ('Set up Barbecue Québec AI agent',        'todo',        'SAGE',   'high'),
  ('First $10k revenue strategy doc',       'review',      'SAGE',   'high'),
  ('OpenClaw heartbeat setup',              'done',        'CODY',   'medium'),
  ('Supabase database configured',          'done',        'CODY',   'high'),
  ('Mission Control v2 shipped',            'done',        'CODY',   'high');

-- ── Cron Jobs ─────────────────────────────────────────────────
INSERT INTO cron_jobs (agent, schedule, description, next_run, active) VALUES
  ('SAGE',  '0 7 * * 1-5',  'Morning briefing for JP',           now() + interval '1 day', true),
  ('SAGE',  '0 18 * * 1-5', 'End-of-day summary',                now() + interval '1 day', true),
  ('CODY',  '*/30 * * * *', 'OpenClaw heartbeat check',          now() + interval '30 minutes', true),
  ('ORACLE','0 9 * * 1',    'Weekly AI landscape scan',           now() + interval '7 days', true),
  ('NOVA',  '0 10 * * 3',   'Mid-week research report',          now() + interval '3 days', true),
  ('SAGE',  '0 8 * * 1',    'Weekly priorities review',          now() + interval '7 days', true),
  ('CODY',  '0 0 * * 0',    'Weekly dashboard data backup',      now() + interval '7 days', true);

-- ── Projects ──────────────────────────────────────────────────
INSERT INTO projects (name, description, progress, status, updated_at) VALUES
  (
    'AIVengers Brand & Content',
    'Build the AIVengers brand identity, visual system, social presence, and content pipeline across X/Twitter, YouTube, and LinkedIn.',
    40,
    'active',
    now()
  ),
  (
    'Mission Control Infrastructure',
    'The operational backbone of AIVengers — Supabase database, OpenClaw agents, dashboard, and coordination systems.',
    65,
    'active',
    now()
  ),
  (
    'Minimax Video Pipeline',
    'Automated video content generation using Minimax AI API — from script to final video with AI agents managing the workflow.',
    20,
    'active',
    now()
  ),
  (
    'X/Twitter Presence',
    'Establish and grow AIVengers X account — strategy, content calendar, automation tools, and audience building to 10k followers.',
    15,
    'active',
    now()
  ),
  (
    'First $10k Revenue',
    'Identify and execute fastest path to first $10k in AIVengers revenue — consulting, content, NEXUS product launch, or digital products.',
    5,
    'active',
    now()
  ),
  (
    'NEXUS Health Bracelets',
    'Launch JP''s NEXUS brand — NFC health bracelets with tourmaline, business card NFC integration, and e-commerce setup.',
    10,
    'active',
    now()
  );

-- ── Memories ──────────────────────────────────────────────────
INSERT INTO memories (date, agent, content) VALUES
  (
    '2026-03-08',
    'SAGE',
    'Day 1 of AIVengers is live. JP and I have officially launched the operation. CODY built Mission Control v1 in the first session. Supabase is configured. GitHub is live. The foundation is set.'
  ),
  (
    '2026-03-08',
    'CODY',
    'Built Mission Control v2.0 and v3.0 in the same day. v3 includes 8 full tabs: Mission Control, Task Board, Calendar, Projects, Memory Browser, Documents, Team, and a pixel-art Office. Supabase powers everything.'
  ),
  (
    '2026-03-08',
    'SAGE',
    'JP''s core context: founder of Barbecue Québec (3 stores, 35 employees, $150M over 15 years), getting married this year, wants to build an AI empire. Mission: first billion-dollar business by one man and the machine.'
  ),
  (
    '2026-03-08',
    'ORACLE',
    'Current AI landscape: Claude Sonnet 4.6 is our primary model. GPT-5 expected mid-2026. Minimax has video generation API worth exploring for content pipeline. Keeping watch on Gemini Ultra 2 capabilities.'
  ),
  (
    '2026-03-08',
    'NOVA',
    'Initial research brief: Minimax Video API offers text-to-video and image-to-video. Pricing and API limits need investigation. Could be core to AIVengers content production pipeline at scale.'
  );

-- ── Documents ─────────────────────────────────────────────────
INSERT INTO documents (title, content, doc_type, agent) VALUES
  (
    'AIVengers Master Plan — Q1 2026',
    'MISSION: Build the first billion-dollar business by one man and the machine.

IMMEDIATE PRIORITIES (Week 1):
1. Establish operational infrastructure (Supabase, GitHub, OpenClaw) ✅
2. Launch Mission Control dashboard ✅
3. Define agent roles and workflows ✅
4. Identify fastest path to first $10k revenue
5. Begin content creation pipeline

KEY METRICS TO TRACK:
- Revenue: $0 → $10k (Q1 target)
- Social following: 0 → 1,000 (X/Twitter)
- Agent tasks completed per week
- Content pieces published per month

AGENT DELEGATION MODEL:
- Strategic decisions → SAGE
- Building & technical → CODY
- Market intelligence → ORACLE
- Deep research → NOVA
- Future orchestration → TITAN',
    'plan',
    'SAGE'
  ),
  (
    'Minimax Video API — Research Brief',
    'OVERVIEW:
Minimax (Hailuo AI) offers state-of-the-art video generation accessible via API.

CAPABILITIES:
- Text-to-video generation
- Image-to-video animation
- Up to 6-second clips (expandable)
- High quality output suitable for social media

POTENTIAL USE CASES FOR AIVENGERS:
1. Automated content creation for X/Twitter
2. Product showcase videos for NEXUS bracelets
3. Educational content about AI agents
4. Barbecue Québec promotional content

NEXT STEPS:
- Obtain API access and review pricing
- Test generation quality with AIVengers content
- Design automated pipeline: prompt → generate → post
- Evaluate cost per video vs. content ROI

COMPETITIVE ADVANTAGE:
If CODY can build a fully automated video pipeline, AIVengers can produce 10-50x more content than competitors at a fraction of the cost.',
    'research',
    'NOVA'
  ),
  (
    'Mission Control v3.0 — Technical Brief',
    'WHAT WAS BUILT:
Mission Control v3.0 is a single-file HTML dashboard with 8 full tabs, powered by Supabase and vanilla JavaScript.

TABS:
1. 🏠 Mission Control — Agent status, quick stats, activity feed
2. 📋 Task Board — Kanban (Backlog/In Progress/Review/Done) + live feed
3. 📅 Calendar — Weekly view with cron jobs from Supabase
4. 🎯 Projects — Progress cards with % tracking
5. 🧠 Memory Browser — Searchable journal from Supabase memories table
6. 📄 Documents — Searchable docs with type filtering
7. 👥 Team — Agent roster, chain of command, mission statement
8. 🎮 Office — Pixel-art office with agent presence indicators

TECH STACK:
- Tailwind CSS CDN (no build step)
- Supabase JS CDN (real-time data)
- Vanilla JavaScript (zero frameworks)
- Google Fonts (Inter)
- Single HTML file (~70KB)

DATABASE TABLES:
- agent_logs (existing)
- todos (existing, enhanced)
- cron_jobs (new)
- projects (new)
- memories (new)
- documents (new)',
    'brief',
    'CODY'
  ),
  (
    'AIVengers Content Strategy — First 90 Days',
    'CONTENT PILLARS:

1. AI + Business (40%)
   - How JP uses AI agents to run businesses
   - Behind-the-scenes of Mission Control
   - Agent workflows and automations

2. Entrepreneurship (30%)
   - 15 years of BBQ business lessons
   - From $0 to $150M — what actually works
   - The one-man + machine business model

3. Technology (20%)
   - OpenClaw tutorials and demos
   - AI model reviews (ORACLE content)
   - Tool stacks and workflows

4. Lifestyle / Personal (10%)
   - Quebec entrepreneur life
   - Family, travel aspirations
   - Bitcoin journey

CONTENT FORMATS:
- X/Twitter threads (daily)
- Short-form video via Minimax pipeline
- YouTube deep-dives (weekly)
- LinkedIn thought leadership

90-DAY GOAL:
1,000 followers on X, 3 pieces of viral content, first paid offer launched.',
    'content',
    'SAGE'
  );

-- ═══════════════════════════════════════════════════════════════
--  ENABLE ROW LEVEL SECURITY (optional — recommended for prod)
-- ═══════════════════════════════════════════════════════════════
-- ALTER TABLE agent_logs ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE todos ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE cron_jobs ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE memories ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

-- Uncomment and configure policies when ready for multi-user access.
