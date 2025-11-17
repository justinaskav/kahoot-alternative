-- Update game_results view to include correct answer counts
-- Drop the existing view first to avoid column order issues
DROP VIEW IF EXISTS game_results;

-- Recreate the view with new columns
CREATE VIEW game_results AS
SELECT
    participants.id AS participant_id,
    participants.nickname,
    SUM(answers.score) AS total_score,
    COUNT(CASE WHEN choices.is_correct THEN 1 END) AS correct_answers,
    COUNT(*) AS total_answers,
    games.id AS game_id
FROM games
INNER JOIN quiz_sets ON games.quiz_set_id = quiz_sets.id
INNER JOIN questions ON quiz_sets.id = questions.quiz_set_id
INNER JOIN answers ON questions.id = answers.question_id
LEFT JOIN choices ON answers.choice_id = choices.id
INNER JOIN participants ON answers.participant_id = participants.id
    AND games.id = participants.game_id
GROUP BY games.id, participants.id;
