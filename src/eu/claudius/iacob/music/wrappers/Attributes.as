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
