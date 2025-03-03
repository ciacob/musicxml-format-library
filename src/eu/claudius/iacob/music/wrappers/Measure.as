package eu.claudius.iacob.music.wrappers {
    
    /**
     * Data wrapper for the \<measure\> MusicXML element.
     */
    public class Measure {

        /**
         * Data wrapper for the \<measure\> MusicXML element.
         * 
         * @param   number
         *          The measure number, 1-based.
         * 
         * @param   notes
         *          A vector of `Note` instances. See `Note` for more information.
         * 
         * @param   attributes
         *          Optional. An `Attributes` instance. See `Attributes` for more information.
         * 
         * @param   direction
         *          Optional. A `Direction` instance. See `Direction` for more information.
         * 
         * @param   barlineType
         *          Optional. The right-hand custom barline to use. Supported values:
         *          "light-light" (section barline) or "light-heavy" (final barline).
         */
        public function Measure(
                number:String, notes:Vector.<Note>,
                attributes:Attributes = null, direction:Direction = null,
                barlineType: String = null
            ) {
            _number = number;
            _notes = notes;
            _attributes = attributes;
            _direction = direction;
            _barlineType = barlineType;
        }

        private var _number:String;
        private var _notes:Vector.<Note>;
        private var _attributes:Attributes;
        private var _direction:Direction;
        private var _barlineType:String;

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

        public function get barlineType(): String {
            return _barlineType;
        }

    }
}