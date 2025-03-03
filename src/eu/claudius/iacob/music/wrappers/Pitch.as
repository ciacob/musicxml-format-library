package eu.claudius.iacob.music.wrappers
{
    /**
     * Data wrapper for the \<pitch\> MusicXML element.
     */
    public class Pitch {
        private var _step:String;
        private var _octave:String;
        private var _alteration:String;

        /**
         * Data wrapper for the \<pitch\> MusicXML element.
         * @param   step
         *          The step of the pitch, e.g. "C".
         * 
         * @param   octave
         *          The octave of the pitch, e.g. "4".
         * 
         * @param   alteration
         *          The alteration of the pitch, in number of semitones, e.g. "-1" for a flat.
         */
        public function Pitch (step:String, octave:String, alteration:String = null) {
            _step = step;
            _octave = octave;
            _alteration = alteration;
        }

        public function get step():String {
            return _step;
        }

        public function get octave():String {
            return _octave;
        }

        public function get alteration():String {
            return _alteration;
        }

        public function toJSON (...ignore) : Object {
            return {
                type: 'Pitch',
                step:step,
                octave:octave,
                alteration:alteration
            };
        }

        public function toString () : String {
            return JSON.stringify (toJSON());
        }
    }
}