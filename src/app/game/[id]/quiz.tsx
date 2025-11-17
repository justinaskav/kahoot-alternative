import { QUESTION_ANSWER_TIME, TIME_TIL_CHOICE_REVEAL } from '@/constants'
import { Choice, Question, supabase } from '@/types/types'
import { useState, useEffect, useMemo } from 'react'
import { ColorFormat, CountdownCircleTimer } from 'react-countdown-circle-timer'
import { seededShuffle } from '@/utils/shuffle'

export default function Quiz({
  question: question,
  questionCount: questionCount,
  participantId: playerId,
  isAnswerRevealed,
  randomizeAnswers = false,
  answerTimeSeconds = 20,
  scoringMode = 'points',
  gameId,
}: {
  question: Question
  questionCount: number
  participantId: string
  isAnswerRevealed: boolean
  randomizeAnswers?: boolean
  answerTimeSeconds?: number
  scoringMode?: string
  gameId: string
}) {
  const [chosenChoice, setChosenChoice] = useState<Choice | null>(null)

  const [hasShownChoices, setHasShownChoices] = useState(false)

  const [questionStartTime, setQuestionStartTime] = useState(Date.now())

  // Compute shuffled choices with index mapping (colors stay with original indices)
  const { displayChoices, indexMap } = useMemo(() => {
    if (!randomizeAnswers) {
      return {
        displayChoices: question.choices,
        indexMap: question.choices.map((_, i) => i)
      }
    }
    const { shuffled, indexMap } = seededShuffle(question.choices, `${gameId}-${question.id}`)
    return { displayChoices: shuffled, indexMap }
  }, [question.choices, question.id, randomizeAnswers, gameId])

  useEffect(() => {
    const fetchExistingAnswer = async () => {
      // Try to fetch player's existing answer for this question
      const { data, error } = await supabase
        .from('answers')
        .select('choice_id, choices(*)')
        .eq('participant_id', playerId)
        .eq('question_id', question.id)
        .maybeSingle()

      if (data && data.choices) {
        // Player has already answered this question
        setChosenChoice(data.choices as Choice)
      } else {
        // No existing answer
        setChosenChoice(null)
      }

      setHasShownChoices(false)
      setQuestionStartTime(Date.now())
    }

    fetchExistingAnswer()
  }, [question.id, playerId])

  const answer = async (choice: Choice) => {
    setChosenChoice(choice)

    const now = Date.now()
    const questionAnswerTime = answerTimeSeconds * 1000
    const startTime = questionStartTime || now

    let score: number
    if (scoringMode === 'correct_count' || scoringMode === 'both') {
      // For correct count mode, just count 1 for correct, 0 for incorrect
      score = choice.is_correct ? 1 : 0
    } else {
      // For points mode, use time-based scoring
      score = !choice.is_correct
        ? 0
        : 1000 -
          Math.round(
            Math.max(
              0,
              Math.min((now - startTime) / questionAnswerTime, 1)
            ) * 1000
          )
    }

    const { error } = await supabase.from('answers').insert({
      participant_id: playerId,
      question_id: question.id,
      choice_id: choice.id,
      score,
    })
    if (error) {
      setChosenChoice(null)
      alert(error.message)
    }
  }

  return (
    <div className="h-screen flex flex-col items-stretch bg-slate-900 relative">
      <div className="text-center">
        <h2 className="pb-4 text-2xl bg-white font-bold mx-4 my-12 p-4 rounded inline-block md:text-3xl md:px-24">
          {question.body}
        </h2>
      </div>

      {!isAnswerRevealed && chosenChoice && (
        <div className="flex-grow flex justify-center items-center">
          <div className="text-white text-2xl text-center p-4">
            Wait for others to answer...
          </div>
        </div>
      )}

      {!hasShownChoices && !isAnswerRevealed && (
        <div className="flex-grow text-transparent flex justify-center">
          <CountdownCircleTimer
            key={`countdown-${question.id}`}
            onComplete={() => {
              setHasShownChoices(true)
            }}
            isPlaying
            duration={TIME_TIL_CHOICE_REVEAL / 1000}
            colors={['#fff', '#fff', '#fff', '#fff']}
            trailColor={'transparent' as ColorFormat}
            colorsTime={[7, 5, 2, 0]}
          >
            {({ remainingTime }) => remainingTime}
          </CountdownCircleTimer>
        </div>
      )}

      {hasShownChoices && !isAnswerRevealed && !chosenChoice && (
        <div className="flex-grow flex flex-col items-stretch">
          <div className="flex-grow"></div>
          <div className="flex justify-between flex-wrap p-4">
            {displayChoices.map((choice, index) => (
                <div key={choice.id} className="w-1/2 p-1">
                  <button
                    onClick={() => answer(choice)}
                    disabled={chosenChoice !== null || isAnswerRevealed}
                    className={`px-4 py-6 w-full text-xl rounded text-white flex justify-between md:text-2xl md:font-bold
                ${
                  index === 0
                    ? 'bg-red-500'
                    : index === 1
                    ? 'bg-blue-500'
                    : index === 2
                    ? 'bg-yellow-500'
                    : 'bg-green-500'
                }
                ${isAnswerRevealed && !choice.is_correct ? 'opacity-60' : ''}
               `}
                  >
                    <div>{choice.body}</div>
                    {isAnswerRevealed && (
                      <div>
                        {choice.is_correct && (
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            fill="none"
                            viewBox="0 0 24 24"
                            strokeWidth={5}
                            stroke="currentColor"
                            className="w-6 h-6"
                          >
                            <path
                              strokeLinecap="round"
                              strokeLinejoin="round"
                              d="m4.5 12.75 6 6 9-13.5"
                            />
                          </svg>
                        )}
                        {!choice.is_correct && (
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            fill="none"
                            viewBox="0 0 24 24"
                            strokeWidth={5}
                            stroke="currentColor"
                            className="w-6 h-6"
                          >
                            <path
                              strokeLinecap="round"
                              strokeLinejoin="round"
                              d="M6 18 18 6M6 6l12 12"
                            />
                          </svg>
                        )}
                      </div>
                    )}
                  </button>
                </div>
            ))}
          </div>
        </div>
      )}

      {isAnswerRevealed && (
        <div className="flex-grow flex justify-center items-center flex-col">
          <h2 className="text-white text-2xl text-center pb-2">
            {chosenChoice?.is_correct ? 'Correct' : 'Incorrect'}
          </h2>
          <div
            className={`text-white rounded-full p-4  ${
              chosenChoice?.is_correct ? 'bg-green-500' : 'bg-red-500'
            }`}
          >
            {chosenChoice?.is_correct && (
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={5}
                stroke="currentColor"
                className="w-6 h-6"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="m4.5 12.75 6 6 9-13.5"
                />
              </svg>
            )}
            {!chosenChoice?.is_correct && (
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={5}
                stroke="currentColor"
                className="w-6 h-6"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M6 18 18 6M6 6l12 12"
                />
              </svg>
            )}
          </div>
        </div>
      )}

      <div className="flex text-white py-2 px-4 items-center bg-black">
        <div className="text-2xl">
          {question.order + 1}/{questionCount}
        </div>
      </div>
    </div>
  )
}
