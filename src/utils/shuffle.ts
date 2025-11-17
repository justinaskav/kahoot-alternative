/**
 * Seeded random number generator using a simple LCG (Linear Congruential Generator)
 * Returns a deterministic pseudo-random number between 0 and 1
 */
function seededRandom(seed: number): () => number {
  let state = seed;
  return function() {
    state = (state * 1664525 + 1013904223) % 4294967296;
    return state / 4294967296;
  };
}

/**
 * Shuffles an array using the Fisher-Yates algorithm with a seeded random generator
 * @param array The array to shuffle
 * @param seed A seed value for deterministic randomization (e.g., question ID)
 * @returns A new array with elements in randomized order, and a map of new index to original index
 */
export function seededShuffle<T>(
  array: T[],
  seed: string
): { shuffled: T[]; indexMap: number[] } {
  // Convert string seed to number using a proper hash function
  let numericSeed = 0;
  for (let i = 0; i < seed.length; i++) {
    numericSeed = ((numericSeed << 5) - numericSeed) + seed.charCodeAt(i);
    numericSeed = numericSeed & numericSeed; // Convert to 32-bit integer
  }
  numericSeed = Math.abs(numericSeed);

  const random = seededRandom(numericSeed);
  const shuffled = [...array];
  const indexMap: number[] = array.map((_, i) => i);

  // Fisher-Yates shuffle
  for (let i = shuffled.length - 1; i > 0; i--) {
    const j = Math.floor(random() * (i + 1));
    [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
    [indexMap[i], indexMap[j]] = [indexMap[j], indexMap[i]];
  }

  return { shuffled, indexMap };
}
