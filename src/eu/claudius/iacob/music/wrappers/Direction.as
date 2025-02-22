package eu.claudius.iacob.music.wrappers {

    /**
     * Data wrapper for the \<direction\> element of a MusicXML \<measure\>.
     */
    public class Direction {
        public function Direction(placement:String, textLines:Vector.<String>,
                beatUnit:String, perMinute:String) {

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