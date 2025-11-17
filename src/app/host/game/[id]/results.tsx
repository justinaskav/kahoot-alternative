import {
  Answer,
  GameResult,
  Participant,
  Question,
  QuizSet,
  supabase,
} from '@/types/types'
import { useEffect, useState } from 'react'
import Confetti from 'react-confetti'
import useWindowSize from 'react-use/lib/useWindowSize'

export default function Results({
  quizSet,
  gameId,
}: {
  participants: Participant[]
  quizSet: QuizSet
  gameId: string
}) {
  const [gameResults, setGameResults] = useState<GameResult[]>([])
  const [scoringMode, setScoringMode] = useState('points')

  const { width, height } = useWindowSize()

  useEffect(() => {
    const getResults = async () => {
      // Fetch game settings to get scoring mode
      const { data: gameData } = await supabase
        .from('games')
        .select('scoring_mode')
        .eq('id', gameId)
        .single()

      if (gameData) {
        setScoringMode(gameData.scoring_mode)
      }

      // Fetch results
      const { data, error } = await supabase
        .from('game_results')
        .select()
        .eq('game_id', gameId)

      if (error) {
        return alert(error.message)
      }

      // Sort based on scoring mode
      const sortedData = [...data].sort((a, b) => {
        if (gameData?.scoring_mode === 'correct_count') {
          return (b.correct_answers || 0) - (a.correct_answers || 0)
        } else {
          return (b.total_score || 0) - (a.total_score || 0)
        }
      })

      setGameResults(sortedData)
    }
    getResults()
  }, [gameId])

  return (
    <div className="min-h-screen bg-black">
      <div className="text-center">
        <h1 className="text-3xl my-4 py-4 px-12 bg-white inline-block rounded font-bold">
          {quizSet.name}
        </h1>
      </div>
      <div className="flex justify-center items-stretch">
        <div>
          {gameResults.map((gameResult, index) => (
            <div
              key={gameResult.participant_id}
              className={`flex justify-between items-center bg-white py-2 px-4 rounded my-4 max-w-2xl w-full ${
                index < 3 ? 'shadow-xl font-bold' : ''
              }`}
            >
              <div className={`pr-4 ${index < 3 ? 'text-3xl' : 'text-l'}`}>
                {index + 1}
              </div>
              <div
                className={`flex-grow font-bold ${
                  index < 3 ? 'text-5xl' : 'text-2xl'
                }`}
              >
                {gameResult.nickname}
              </div>
              <div className="pl-2">
                {scoringMode === 'correct_count' && (
                  <>
                    <span className="text-xl font-bold">
                      {gameResult.correct_answers}
                    </span>
                    <span> correct</span>
                  </>
                )}
                {scoringMode === 'points' && (
                  <>
                    <span className="text-xl font-bold">
                      {gameResult.total_score}
                    </span>
                    <span> pts</span>
                  </>
                )}
                {scoringMode === 'both' && (
                  <>
                    <span className="text-xl font-bold">
                      {gameResult.correct_answers}
                    </span>
                    <span> correct / </span>
                    <span className="text-xl font-bold">
                      {gameResult.total_score}
                    </span>
                    <span> pts</span>
                  </>
                )}
              </div>
            </div>
          ))}
        </div>
      </div>
      <Confetti width={width} height={height} recycle={true} />
    </div>
  )
}
