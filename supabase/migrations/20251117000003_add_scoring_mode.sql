-- Add scoring_mode column to games table
ALTER TABLE games
ADD COLUMN scoring_mode text DEFAULT 'points' NOT NULL;

-- Add constraint to ensure valid values
ALTER TABLE games
ADD CONSTRAINT check_scoring_mode
CHECK (scoring_mode IN ('points', 'correct_count', 'both'));
