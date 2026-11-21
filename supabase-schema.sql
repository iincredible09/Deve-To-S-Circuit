-- ====================================================================
-- DEVE-TO-S CIRCUIT: SUPABASE PRODUCTION DATABASE SCHEMA
-- Hackathon: IQX 24 | Architecture: PostgreSQL with Row-Level Security
-- ====================================================================

-- 1. Enable UUID Extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. User Profiles Table (Linked to Supabase Auth)
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT UNIQUE NOT NULL,
    full_name TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('student', 'developer', 'entrepreneur')),
    avatar_url TEXT,
    headline TEXT,
    bio TEXT,
    degree TEXT,
    college TEXT,
    graduation_year INT,
    company TEXT,
    job_title TEXT,
    skills TEXT[] DEFAULT '{}',
    github_url TEXT,
    linkedin_url TEXT,
    verified BOOLEAN DEFAULT FALSE,
    open_for_mentorship BOOLEAN DEFAULT TRUE,
    open_for_hiring BOOLEAN DEFAULT FALSE,
    open_for_projects BOOLEAN DEFAULT TRUE,
    karma_points INT DEFAULT 100,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 3. Daily Tech Updates & Community Posts
CREATE TABLE IF NOT EXISTS public.tech_posts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    summary TEXT NOT NULL,
    content TEXT NOT NULL,
    category TEXT NOT NULL CHECK (category IN ('AI & ML', 'Frameworks & Dev', 'Cloud & DevOps', 'Cybersecurity', 'Industry News', 'Career & Growth')),
    author_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    author_name TEXT NOT NULL,
    author_role TEXT NOT NULL,
    tags TEXT[] DEFAULT '{}',
    source_name TEXT,
    source_url TEXT,
    upvotes INT DEFAULT 1,
    verified_news BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 4. Direct Mentorship Messages (Student <-> Developer)
CREATE TABLE IF NOT EXISTS public.direct_messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    receiver_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    icebreaker TEXT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 5. Mock Interview & Mentorship Slots
CREATE TABLE IF NOT EXISTS public.mock_interviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    mentor_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    student_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    topic TEXT NOT NULL,
    duration TEXT DEFAULT '45 mins',
    date TEXT NOT NULL,
    time_slot TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'available' CHECK (status IN ('available', 'booked', 'completed', 'cancelled')),
    meet_platform TEXT DEFAULT 'Deve-To-S Circuit Call',
    meet_link TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 6. Entrepreneur / BBA Startup Idea Pitches
CREATE TABLE IF NOT EXISTS public.startup_pitches (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    founder_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    founder_name TEXT NOT NULL,
    title TEXT NOT NULL,
    tagline TEXT NOT NULL,
    problem TEXT NOT NULL,
    solution TEXT NOT NULL,
    target_audience TEXT NOT NULL,
    stage TEXT NOT NULL CHECK (stage IN ('Idea Validation', 'Prototype / MVP', 'Seed Stage', 'Pre-Launch')),
    looking_for TEXT[] DEFAULT '{}',
    compensation TEXT,
    likes INT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- ====================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ====================================================================

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tech_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.direct_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.mock_interviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.startup_pitches ENABLE ROW LEVEL SECURITY;

-- Profiles: Anyone can view profiles, users can update their own
CREATE POLICY "Public profiles are viewable by everyone" ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Users can insert their own profile" ON public.profiles FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "Users can update their own profile" ON public.profiles FOR UPDATE USING (auth.uid() = id);

-- Tech Posts: Anyone can view, verified users can insert
CREATE POLICY "Tech posts are viewable by everyone" ON public.tech_posts FOR SELECT USING (true);
CREATE POLICY "Authenticated users can create tech posts" ON public.tech_posts FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Direct Messages: Only participants can read their messages
CREATE POLICY "Users can see messages they sent or received" ON public.direct_messages FOR SELECT 
USING (auth.uid() = sender_id OR auth.uid() = receiver_id);
CREATE POLICY "Authenticated users can send messages" ON public.direct_messages FOR INSERT 
WITH CHECK (auth.uid() = sender_id);

-- Mock Interviews: Anyone can view slots, students can book
CREATE POLICY "Mock slots viewable by everyone" ON public.mock_interviews FOR SELECT USING (true);
CREATE POLICY "Mentors can manage their slots" ON public.mock_interviews FOR ALL USING (auth.uid() = mentor_id);
CREATE POLICY "Students can update slot to book" ON public.mock_interviews FOR UPDATE USING (auth.role() = 'authenticated');

-- Startup Pitches: Anyone can view, founders can post
CREATE POLICY "Startup pitches viewable by everyone" ON public.startup_pitches FOR SELECT USING (true);
CREATE POLICY "Authenticated founders can post pitches" ON public.startup_pitches FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- ====================================================================
-- AUTO-TRIGGER: Create Profile Row On Supabase Signup
-- ====================================================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, role, headline, karma_points)
  VALUES (
    new.id,
    new.email,
    COALESCE(new.raw_user_meta_data->>'full_name', 'Circuit Member'),
    COALESCE(new.raw_user_meta_data->>'role', 'student'),
    COALESCE(new.raw_user_meta_data->>'headline', 'Tech Explorer on Deve-To-S Circuit'),
    150
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();
