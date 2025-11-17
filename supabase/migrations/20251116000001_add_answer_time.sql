-- Add answer_time_seconds column to games table
ALTER TABLE games
ADD COLUMN answer_time_seconds integer DEFAULT 20 NOT NULL;
