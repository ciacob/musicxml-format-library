package eu.claudius.iacob.music.wrappers {

    /**
     * Data wrapper for the \<attributes\> node of a MusicXML \<measure\>.
     */
    public class Attributes {
        private var _divisions:String;
        private var _fifths:String;
        private var _mode:String;
        private var _beats:String;
        private var _beatType:String;
        private var _sign:String;
        private var _line:String;

        /**
         * Data wrapper for the \<attributes\> node of a MusicXML \<measure\>.
         * @param   divisions
         *          The divisions of the measure, i.e. the number of divisions a quarter note is divided into.
         * 
         * @param   fifths
         *          The number of sharps or flats in the key signature, negative for flats, positive for sharps, 
         *          e.g.: -1 for one flat (F major), 1 for one sharp (G major); 0 for C major.
         * 
         * @param   mode
         *          The mode of the key signature. Supported values: "major" or "minor".
         * 
         * @param   beats
         *          The number of beats in a measure, e.g. 3 for a 3/4 time signature.
         * 
         * @param   beatType
         *          The type of beat in a measure, e.g. 4 for a 3/4 time signature.
         * 
         * @param   sign
         *          The clef sign, e.g. "G" for treble clef. Supported values: "G", "F", "C", "percussion", "none".
         * 
         * @param   line
         *          The clef line, e.g. 2 for the second line of the staff.
         *
         */
        public function Attributes(
                divisions:String, fifths:String, mode:String, beats:String,
                beatType:String, sign:String, line:String
            ) {
            _divisions = divisions;
            _fifths = fifths;
            _mode = mode;
            _beats = beats;
            _beatType = beatType;
            _sign = sign;
            _line = line;
        }

        public function get divisions():String {
            return _divisions;
        }

        public function get fifths():String {
            return _fifths;
        }

        public function get mode():String {
            return _mode;
        }

        public function get beats():String {
            return _beats;
        }

        public function get beatType():String {
            return _beatType;
        }

        public function get sign():String {
            return _sign;
        }

        public function get line():String {
            return _line;
        }
    }
}
