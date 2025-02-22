package eu.claudius.iacob.music.wrappers {
    
    /**
     * Data wrapper for the \<measure\> MusicXML element.
     */
    public class Measure {
        public function Measure(
                number:String, notes:Vector.<Note>,
                attributes:Attributes = null, direction:Direction = null
            ) {
            _number = number;
            _notes = notes;
            _attributes = attributes;
            _direction = direction;
        }

        private var _number:String;
        private var _notes:Vector.<Note>;
        private var _attributes:Attributes;
        private var _direction:Direction;

        public function get number():String {
            return _number;
        }

        public function get notes():Vector.<Note> {
            return _notes;
        }

        public function get attributes():Attributes {
            return _attributes;
        }

        public function get direction():Direction {
            return _direction;
        }

    }
}