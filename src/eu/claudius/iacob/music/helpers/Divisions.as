package eu.claudius.iacob.music.helpers {
    import ro.ciacob.math.Fraction;
    import ro.ciacob.utils.NumberUtil;

    public class Divisions {
        // Not used
        public function Divisions() {
            // Empty
        }

        /**
         * The safest default value for MusicXML `divisions`.
         *
         * This value (110,880) is the least common multiple (LCM) of all typical note durations
         * and common tuplet divisions, ensuring that all standard and tuplets (up to 11-tuplets)
         * are evenly represented without rounding errors.
         *
         * Covered divisions:
         * - Regular notes: 1, 2, 4, 8, 16, 32
         * - Triplets: 3, 6, 12, 24
         * - Quintuplets: 5, 10, 20
         * - Septuplets: 7, 14, 28
         * - Nonuplets: 9, 18, 36
         * - 11-tuplets: 11, 22, 44
         *
         * Modern CPUs can handle this value efficiently, making it a safe default choice for
         * MusicXML processing.
         */
        public static const WHOLE_NUM_DIVISIONS:Number = 110880;
        public static const QUARTER_NUM_DIVISIONS:Number = (WHOLE_NUM_DIVISIONS / 4);

        /**
         * Determines the closest downward power-of-2 fraction for a given tuplet fraction.
         *
         * This function ensures that tuplet notes are graphically represented using the
         * nearest conventional note value (whole, half, quarter, eighth, sixteenth, etc.).
         *
         * We use bitwise logic to efficiently compute the largest power of 2 ≤ the denominator
         * of the given fraction.
         *
         * If the denominator is already a power of 2, the function returns it unchanged.
         *
         * @param tupletFraction The actual fraction representing the tuplet's real duration.
         * @return The closest downward power-of-2 fraction.
         */
        public static function getGraphicalTupletFraction(tupletFraction:Fraction):Fraction {
            var denominator:int = tupletFraction.denominator;

            // If denominator is already a power of 2, return fraction as-is
            if (NumberUtil.isPowerOfTwo(denominator)) {
                return tupletFraction;
            }

            // Compute the largest power of 2 ≤ denominator
            var closestPowerOfTwo:int = 1 << (31 - _leadingZeroCount(denominator));

            // Construct the final graphical fraction
            return new Fraction(1, closestPowerOfTwo);
        }

        /**
         * Finds the smallest number of divisions that can represent all given musical durations.
         * @param durations A vector of IFraction objects representing the musical durations.
         * @return The smallest number of divisions, or 0 if the durations vector is empty.
         */
        public static function getLeastDivisionsFor(durations:Vector.<Fraction>):uint {
            if (durations.length == 0) {
                trace("The durations vector must not be empty.");
                return 0;
            }

            var denominators:Vector.<int> = new Vector.<int>();
            for each (var fraction:Fraction in durations) {
                denominators.push(fraction.denominator);
            }

            // The logic is actually rooted on the _whole_, not the _quarter_ (as the MusicXML spec requires).
            // Adding the `4` denominator works this around, while still letting us leverage the `lcm` function.
            // The price we pay is that computed divisions will generally exceed the needs of the current score,
            // but this is purely notional.
            if (!denominators.includes(4)) {
                denominators.push(4);
            }

            var leastDivisions:int = denominators[0];
            for (var i:int = 1; i < denominators.length; i++) {
                leastDivisions = NumberUtil.lcm(leastDivisions, denominators[i]);
            }

            return leastDivisions;
        }

        /**
         * Calculates the number of divisions for a given fraction based on the available divisions.
         * @param availableDivisions The total number of available divisions.
         * @param fraction The fraction to calculate divisions for.
         * @return The number of divisions that correspond to the given fraction.
         */
        public static function getDivisionsFor(availableDivisions:uint, fraction:Fraction):uint {
            return Math.floor((availableDivisions * fraction.numerator) / fraction.denominator) as uint;
        }

        /**
         * Computes the number of leading zeros in a 32-bit integer.
         * This helps find the largest power of 2 ≤ n efficiently.
         *
         * @param n The input integer.
         * @return The number of leading zeros.
         */
        private static function _leadingZeroCount(n:int):int {
            var count:int = 0;
            while (n > 1) {
                n >>= 1;
                count++;
            }
            return 31 - count;
        }
    }
}