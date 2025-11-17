-- Add question_started_at column to games table to track when current question choices were revealed
ALTER TABLE games
ADD COLUMN question_started_at timestamp with time zone DEFAULT NULL;
