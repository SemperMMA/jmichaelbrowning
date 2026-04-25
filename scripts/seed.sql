-- =============================================================================
-- JMB EmDash Seed — scripts/seed.sql
-- Run via: pnpm seed:remote  (remote D1)
--          pnpm bootstrap    (local dev)
--
-- EmDash's own migrations create the system tables (emdash_collections,
-- emdash_entries, emdash_users, etc.) when you run `pnpm bootstrap`.
-- This file only inserts the collection definitions and seed content.
-- ALWAYS run `pnpm bootstrap` before running this file on a fresh database.
-- =============================================================================

-- -----------------------------------------------------------------------
-- 1. COLLECTION DEFINITIONS
-- Each row in emdash_collections registers a content type with its field
-- schema. EmDash uses this to render the admin UI and validate entries.
-- -----------------------------------------------------------------------

INSERT OR IGNORE INTO emdash_collections (slug, label, singular_label, schema, settings)
VALUES (
  'work',
  'Work',
  'Project',
  json('{
    "fields": [
      { "name": "title",    "type": "text",   "label": "Title",    "required": true },
      { "name": "summary",  "type": "text",   "label": "Summary",  "required": true },
      { "name": "category", "type": "text",   "label": "Category" },
      { "name": "role",     "type": "text",   "label": "Role" },
      { "name": "stack",    "type": "text",   "label": "Stack (comma-separated)" },
      { "name": "year",     "type": "text",   "label": "Year" },
      { "name": "duration", "type": "text",   "label": "Duration" },
      { "name": "outcomes", "type": "json",   "label": "Outcomes (JSON array)" },
      { "name": "order",    "type": "number", "label": "Sort order", "default": 99 },
      { "name": "body",     "type": "rich-text", "label": "Case study body" }
    ]
  }'),
  json('{ "hasSlug": true, "hasStatus": true, "hasDates": true }')
);

INSERT OR IGNORE INTO emdash_collections (slug, label, singular_label, schema, settings)
VALUES (
  'writing',
  'Writing',
  'Essay',
  json('{
    "fields": [
      { "name": "title",        "type": "text",     "label": "Title",       "required": true },
      { "name": "summary",      "type": "text",     "label": "Summary" },
      { "name": "category",     "type": "select",   "label": "Category",    "options": ["Essay","Field note","Notes"] },
      { "name": "tags",         "type": "text",     "label": "Tags (comma-separated)" },
      { "name": "published_at", "type": "datetime", "label": "Published at" },
      { "name": "reading_time", "type": "number",   "label": "Reading time (min)" },
      { "name": "body",         "type": "rich-text","label": "Body" }
    ]
  }'),
  json('{ "hasSlug": true, "hasStatus": true, "hasDates": true }')
);

INSERT OR IGNORE INTO emdash_collections (slug, label, singular_label, schema, settings)
VALUES (
  'notes',
  'Notes',
  'Note',
  json('{
    "fields": [
      { "name": "number",       "type": "number",   "label": "Note number", "required": true },
      { "name": "title",        "type": "text",     "label": "Title",       "required": true },
      { "name": "published_at", "type": "datetime", "label": "Published at" },
      { "name": "body",         "type": "rich-text","label": "Body" }
    ]
  }'),
  json('{ "hasSlug": true, "hasStatus": true, "hasDates": true }')
);

INSERT OR IGNORE INTO emdash_collections (slug, label, singular_label, schema, settings)
VALUES (
  'speaking',
  'Speaking',
  'Speaking event',
  json('{
    "fields": [
      { "name": "title",      "type": "text",     "label": "Title",   "required": true },
      { "name": "venue",      "type": "text",     "label": "Venue" },
      { "name": "format",     "type": "select",   "label": "Format",  "options": ["Keynote","Panel","Lecture","Workshop","Podcast"] },
      { "name": "event_date", "type": "datetime", "label": "Event date" },
      { "name": "summary",    "type": "text",     "label": "Summary" },
      { "name": "href",       "type": "text",     "label": "External link" }
    ]
  }'),
  json('{ "hasSlug": true, "hasStatus": true, "hasDates": true }')
);

INSERT OR IGNORE INTO emdash_collections (slug, label, singular_label, schema, settings)
VALUES (
  'now',
  'Now',
  'Now item',
  json('{
    "fields": [
      { "name": "label",       "type": "text",     "label": "Label (e.g. Working on)", "required": true },
      { "name": "title",       "type": "text",     "label": "Title",   "required": true },
      { "name": "body",        "type": "rich-text","label": "Body" },
      { "name": "sort_order",  "type": "number",   "label": "Sort order", "default": 99 }
    ]
  }'),
  json('{ "hasSlug": true, "hasStatus": true, "hasDates": false }')
);

-- -----------------------------------------------------------------------
-- 2. SEED ENTRIES — Work
-- -----------------------------------------------------------------------

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'work', 'the-trust-layer', 'published',
  json('{
    "title": "The Trust Layer",
    "summary": "Rebuilding the public trust infrastructure for a federal agency''s digital front door — eighteen months, forty-two stakeholders, one unified strategy that shipped on the date.",
    "category": "Federal",
    "role": "Lead strategist · Comms architect",
    "stack": "Discovery, Roadmap, Governance, Live ops",
    "year": "2024 — 2025",
    "duration": "18 months",
    "order": 1,
    "outcomes": [
      { "stat": "38%",   "label": "Complaint volume reduction" },
      { "stat": "14.2M", "label": "Annual unique sessions" },
      { "stat": "0",     "label": "Missed delivery dates" }
    ],
    "body": "<p>When a federal agency calls and says the digital front door isn''t working, what they usually mean is that no two parts of the organization can agree on what that door even is.</p><h2>The brief</h2><p>We started where I always start: a quiet audit. No deliverables for the first six weeks. Just listening. Forty-two stakeholder conversations, structured against a single question — <em>what would have to be true for the next launch to ship cleanly?</em></p><blockquote>The work that mattered most happened in week three, when we admitted in a room full of principals that the strategy on the wall was no longer the strategy we were operating.</blockquote><h2>The system we shipped</h2><p>What we built wasn''t a product — it was a coordination layer. A standing weekly forum with a non-negotiable agenda. A decision log with two columns: <em>decided</em> and <em>still open</em>.</p><h2>What I learned</h2><p>That the most expensive failure inside large organizations is almost never a failure of intelligence. It''s a failure of <em>interface</em> between teams who each did their part correctly.</p>"
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'work', 'operation-dispatch', 'published',
  json('{
    "title": "Operation Dispatch",
    "summary": "Modernization audit and replatforming strategy for a defense logistics organization. Recommended sequence adopted in full.",
    "category": "Defense",
    "role": "Strategy lead",
    "stack": "Audit, Roadmap, Governance",
    "year": "2023",
    "duration": "9 months",
    "order": 2,
    "outcomes": [
      { "stat": "100%", "label": "Recommendations adopted" },
      { "stat": "3x",   "label": "Release cadence improvement" }
    ],
    "body": "<p>A modernization audit that turned into a replatforming roadmap. The story behind the story: the existing systems weren''t broken, they were undocumented.</p>"
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'work', 'civic-frequency', 'published',
  json('{
    "title": "Civic Frequency",
    "summary": "Open-source municipal communications toolkit. Adopted by a dozen cities; still maintained.",
    "category": "Civic-tech · Open source",
    "role": "Creator · Maintainer",
    "stack": "Open source, Municipal",
    "year": "2022",
    "order": 3,
    "outcomes": [],
    "body": "<p>A toolkit that made government communications legible. Built in the open, maintained by the community.</p>"
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'work', 'the-credible-channel', 'published',
  json('{
    "title": "The Credible Channel",
    "summary": "Standing crisis communications operation. Architected the playbook still in use today.",
    "category": "Crisis comms",
    "role": "Communications architect",
    "stack": "Crisis comms, Standing op",
    "year": "2021 — 2024",
    "order": 4,
    "outcomes": [],
    "body": "<p>The playbook is still in active use. Three leadership transitions haven''t changed it.</p>"
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'work', 'atlas-briefings', 'published',
  json('{
    "title": "Atlas Briefings",
    "summary": "Internal briefing platform now used across a multi-thousand-person organization.",
    "category": "Internal platform",
    "role": "Product lead",
    "stack": "Platform, Internal",
    "year": "2020 — 2022",
    "order": 5,
    "outcomes": [],
    "body": "<p>Built because the alternative was another weekly all-hands nobody left with clarity from.</p>"
  }')
);

-- -----------------------------------------------------------------------
-- 3. SEED ENTRIES — Writing
-- -----------------------------------------------------------------------

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'writing', 'shipping-under-scrutiny', 'published',
  json('{
    "title": "The discipline of shipping things that hold up under scrutiny.",
    "summary": "Notes on building for institutional scrutiny — auditors, journalists, citizens. Why the most overlooked craft in modern organizations is the work of being durably correct, in writing, on the record.",
    "category": "Essay",
    "tags": "Leadership, Communications, Craft",
    "published_at": "2026-03-04T12:00:00Z",
    "reading_time": 14,
    "body": "<p>Most of the work that survives long enough to matter is work that was, at some point, held up to a light. Not the light of admiration — the light of audit.</p><h2>What scrutiny is, exactly</h2><p>Scrutiny is the moment a stranger reads your work without your context. The reader does not know what you were trying to do. They do not have the conversation you had in the hallway. They have the memo.</p><blockquote>Scrutiny is the moment a stranger reads your work without your context. Build for that stranger.</blockquote><h2>Three commitments</h2><h3>1. Plain language</h3><p>If a reader has to ask what a sentence means, you''ve already lost the argument.</p><h3>2. Decisions on the record</h3><p>Every decision worth making is worth recording. Who decided. When. With what information.</p><h3>3. Show your work</h3><p>The most credible documents are the ones that explain how the conclusion was reached.</p>"
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'writing', 'trust-system-property', 'published',
  json('{
    "title": "Trust is a system property, not a slogan.",
    "summary": "Why the most overlooked work in modernization is what happens between teams. A short argument for treating coordination as the actual product.",
    "category": "Field note",
    "tags": "Systems, Leadership",
    "published_at": "2026-02-12T12:00:00Z",
    "reading_time": 6,
    "body": "<p>The organizations that compound trust over decades aren''t more virtuous. They''re more disciplined about the interfaces between teams. Trust isn''t a value statement. It''s a system property — observable, measurable, and built deliberately.</p>"
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'writing', 'taxonomy-of-urgency', 'published',
  json('{
    "title": "A taxonomy of urgency.",
    "summary": "Not all deadlines are created equal — and confusing them is how good organizations stop shipping. Six categories, with examples.",
    "category": "Essay",
    "tags": "Operations, Leadership",
    "published_at": "2026-01-18T12:00:00Z",
    "reading_time": 9,
    "body": "<p>There''s the deadline that''s a real consequence in the world, and the deadline that''s a calendar invite. Treating them the same is how teams burn out shipping the wrong thing.</p>"
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'writing', 'inspectors-general', 'published',
  json('{
    "title": "What I learned writing for inspectors general.",
    "summary": "Plain language is a leadership posture. So is the willingness to be wrong on the record.",
    "category": "Field note",
    "tags": "Communications, Craft",
    "published_at": "2025-12-04T12:00:00Z",
    "reading_time": 4,
    "body": "<p>Writing for an audience that will read every word with hostile intent is the best writing education available. It teaches you that clarity is generosity.</p>"
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'writing', 'operating-principles', 'published',
  json('{
    "title": "Operating principles I keep returning to.",
    "summary": "Six rules I use to evaluate decisions when the politics get loud and the room gets small.",
    "category": "Essay",
    "tags": "Leadership",
    "published_at": "2025-11-09T12:00:00Z",
    "reading_time": 11,
    "body": "<p>Clarity is a kindness. Ship the system, not the slide. Trust compounds. Urgency without panic. Write it down. Be the calmest one in the room.</p>"
  }')
);

-- -----------------------------------------------------------------------
-- 4. SEED ENTRIES — Notes
-- -----------------------------------------------------------------------

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'notes', 'note-024', 'published',
  json('{
    "number": 24,
    "title": "The cheapest documentation is a screenshot at 4pm.",
    "published_at": "2026-04-14T16:00:00Z",
    "body": "<p>Saw a team save themselves twelve hours of meeting time this week by sharing a screenshot and a one-line caption. The bar for good enough record is much lower than people think — and the cost of no record is much higher.</p>"
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'notes', 'note-023', 'published',
  json('{
    "number": 23,
    "title": "\"We''ll figure it out in the meeting\" is a cost.",
    "published_at": "2026-04-09T12:00:00Z",
    "body": "<p>When a fifteen-person room becomes the place a question gets answered, you''ve spent something like four hours of organizational attention to do the work of one person and a paragraph.</p>"
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'notes', 'note-022', 'published',
  json('{
    "number": 22,
    "title": "A small case for the standing appendix.",
    "published_at": "2026-04-02T12:00:00Z",
    "body": "<p>Every important document I write now has a what changed appendix at the end. Not a changelog — a narrative paragraph. It''s the cheapest way to keep a moving target legible.</p>"
  }')
);

-- -----------------------------------------------------------------------
-- 5. SEED ENTRIES — Speaking
-- -----------------------------------------------------------------------

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'speaking', 'govt-tech-2026', 'published',
  json('{
    "title": "What survives the transition",
    "venue": "Govt Tech Summit",
    "format": "Keynote",
    "event_date": "2026-05-14T09:00:00Z",
    "summary": "On building things that outlast the administration that authorized them."
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'speaking', 'modernization-conf-2026', 'published',
  json('{
    "title": "Trust as a system property",
    "venue": "Modernization Conference",
    "format": "Panel",
    "event_date": "2026-03-22T10:00:00Z",
    "summary": ""
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'speaking', 'civic-tech-2026', 'published',
  json('{
    "title": "A taxonomy of urgency",
    "venue": "Civic Tech Forum",
    "format": "Lecture",
    "event_date": "2026-01-15T09:00:00Z",
    "summary": ""
  }')
);

-- -----------------------------------------------------------------------
-- 6. SEED ENTRIES — Now
-- -----------------------------------------------------------------------

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'now', 'working-on', 'published',
  json('{
    "label": "Working on",
    "title": "Two engagements, one quiet research thread.",
    "sort_order": 1,
    "body": "<p>A federal modernization roadmap (year two), a standing comms operation for a national nonprofit, and long-running research on coordination failure inside large organizations.</p>"
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'now', 'writing', 'published',
  json('{
    "label": "Writing",
    "title": "A long essay on durability.",
    "sort_order": 2,
    "body": "<p>Working title: <em>What survives the next administration.</em> Slow draft. Aiming for early summer.</p>"
  }')
);

INSERT OR IGNORE INTO emdash_entries (collection_slug, slug, status, data)
VALUES (
  'now', 'not-doing', 'published',
  json('{
    "label": "Not doing",
    "title": "New advisory roles. New podcast appearances.",
    "sort_order": 3,
    "body": "<p>Both will return at some point. For now, the focus is on the engagements I''m in.</p>"
  }')
);
