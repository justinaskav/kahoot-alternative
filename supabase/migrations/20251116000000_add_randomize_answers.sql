-- Add randomize_answers column to games table
ALTER TABLE games
ADD COLUMN randomize_answers boolean DEFAULT false NOT NULL;
