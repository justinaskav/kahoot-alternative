import { Participant, supabase } from '@/types/types'
import { useQRCode } from 'next-qrcode'
import { useState } from 'react'

export default function Lobby({
  participants: participants,
  gameId,
}: {
  participants: Participant[]
  gameId: string
}) {
  const { Canvas } = useQRCode()
  const baseUrl = process.env.NEXT_PUBLIC_BASE_URL || 'https://kavo.lt'
  const [randomizeAnswers, setRandomizeAnswers] = useState(true)
  const [answerTimeSeconds, setAnswerTimeSeconds] = useState(20)
  const [scoringMode, setScoringMode] = useState('points')

  const onClickStartGame = async () => {
    const { data, error } = await supabase
      .from('games')
      .update({
        phase: 'quiz',
        randomize_answers: randomizeAnswers,
        answer_time_seconds: answerTimeSeconds,
        scoring_mode: scoringMode
      })
      .eq('id', gameId)
    if (error) {
      return alert(error.message)
    }
  }

  return (
    <div className="flex justify-center items-center min-h-screen">
      <div className="flex justify-between m-auto bg-black p-12">
        <div className="w-96">
          <div className="flex justify-start flex-wrap pb-4">
            {participants.map((participant) => (
              <div
                className="text-xl m-2 p-2 bg-green-500"
                key={participant.id}
              >
                {participant.nickname}
              </div>
            ))}
          </div>

          <div className="mb-4 space-y-4">
            <label className="flex items-center text-white cursor-pointer">
              <input
                type="checkbox"
                checked={randomizeAnswers}
                onChange={(e) => setRandomizeAnswers(e.target.checked)}
                className="mr-2 w-5 h-5 cursor-pointer"
              />
              <span className="text-lg">Randomize answer order</span>
            </label>

            <div>
              <label className="block text-white text-lg mb-2">
                Answer time per question
              </label>
              <select
                value={answerTimeSeconds}
                onChange={(e) => setAnswerTimeSeconds(Number(e.target.value))}
                className="w-full p-2 text-lg rounded cursor-pointer"
              >
                <option value={10}>10 seconds</option>
                <option value={20}>20 seconds (default)</option>
                <option value={30}>30 seconds</option>
                <option value={45}>45 seconds</option>
                <option value={60}>60 seconds</option>
              </select>
            </div>

            <div>
              <label className="block text-white text-lg mb-2">
                Scoring mode
              </label>
              <select
                value={scoringMode}
                onChange={(e) => setScoringMode(e.target.value)}
                className="w-full p-2 text-lg rounded cursor-pointer"
              >
                <option value="points">Points (time-based)</option>
                <option value="correct_count">Correct answers only</option>
                <option value="both">Both points and correct answers</option>
              </select>
            </div>
          </div>

          <button
            className="mx-auto bg-white py-4 px-12 block text-black"
            onClick={onClickStartGame}
          >
            Start Game
          </button>
        </div>
        <div className="pl-4">
          {/* <img src="/qr.png" alt="QR code" /> */}
          <Canvas
            text={`${baseUrl}/game/${gameId}`}
            options={{
              errorCorrectionLevel: 'M',
              margin: 3,
              scale: 4,
              width: 400,
            }}
          />
        </div>
      </div>
    </div>
  )
}
