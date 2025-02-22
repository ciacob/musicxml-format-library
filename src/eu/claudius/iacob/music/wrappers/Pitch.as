/**
 * Data wrapper for the \<pitch\> MusicXML element.
 */
package eu.claudius.iacob.music.wrappers
{
    public class Pitch {
        private var _step:String;
        private var _octave:String;
        private var _alteration:String;

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
    }
}