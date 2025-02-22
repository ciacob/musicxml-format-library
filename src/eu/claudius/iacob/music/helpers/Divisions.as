package eu.claudius.iacob.music.helpers {
    import ro.ciacob.math.Fraction;
    import ro.ciacob.utils.NumberUtil;

    public class Divisions {
        // Not used
        public function Divisions() {}

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
                denominators.push (4);
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
            return (availableDivisions * fraction.numerator) / fraction.denominator;
        }
    }
}