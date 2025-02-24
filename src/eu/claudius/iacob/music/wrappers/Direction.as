package eu.claudius.iacob.music.wrappers {

    /**
     * Data wrapper for the \<direction\> element of a MusicXML \<measure\>.
     */
    public class Direction {

        /**
         * Data wrapper for the \<direction\> element of a MusicXML \<measure\>.
         *
         * @param   placement
         *          The placement of the _direction_ in relation to the staff. Supported values: "above" or "below".
         *
         * @param   textLines
         *          Optional. Vector of Strings, representing one line of text each. They will be placed above
         *          or below the staff, depending on the `placement` parameter.
         *
         * @param   beatUnit
         *          Optional. The beat unit of the _direction_, if displaying a metronome mark is required (if so, the
         *          `perMinute` parameter must also be set). Example: "quarter".
         * 
         * @param   perMinute
         *          The beats per minute of the _direction_, if displaying a metronome mark is required (if so, the
         *          `beatUnit` parameter must also be set). Example: "120".
         */
        public function Direction(placement:String, textLines:Vector.<String> = null,
                beatUnit:String = null, perMinute:String = null) {

            _placement = placement;
            _textLines = textLines;
            _beatUnit = beatUnit;
            _perMinute = perMinute;

        }

        private var _placement:String;
        private var _textLines:Vector.<String>;
        private var _beatUnit:String;
        private var _perMinute:String;

        public function get placement():String {
            return _placement;
        }

        public function get textLines():Vector.<String> {
            return _textLines;
        }

        public function get beatUnit():String {
            return _beatUnit;
        }

        public function get perMinute():String {
            return _perMinute;
        }

    }
}