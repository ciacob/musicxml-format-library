package eu.claudius.iacob.music.wrappers {
    import eu.claudius.iacob.music.wrappers.Pitch;

    /**
     * Data wrapper for one \<note\> MusicXML element.
     */
    public class Note {

        /**
         * Data wrapper for one \<note\> MusicXML element.
         * @param   duration
         *          The duration of the note, in divisions of the quarter note. Depends on the current value of
         *         `<divisions>` in the `<attributes>` element. For example, if `<divisions>` is 120, a duration
         *          of 30 means a sixteenth note,  `<divisions>` in the `<attributes>` element.
         *          For example, if `<divisions>` is 120, a duration of 30 means a sixteenth note, and a duration
         *          of 60 means an eighth note.
         * 
         * @param   type
         *          The graphical type of the note when rendered. Supported values: 
         *          "64th", "32nd", "16th", "eighth", "quarter", "half", "whole".
         * 
         * @param   voice
         *          Optional, assumed "1" if missing. The voice of the note, 1-based.
         * 
         * @param   pitch
         *          Optional. A `Pitch` instance, see `Pitch` for more details. Only applicable if the note is 
         *          not a rest.
         * 
         * @param   numDots
         *          Optional, defaults to `0`. The number of dots the note will have. A dot increases the duration
         *          of the note by half of its original value. For example, a quarter note with one dot is
         *          equivalent to a quarter note tied to an eighth note. Supported values: `0`, `1`, `2`.
         * 
         * @param   accidental
         *          Optional. The accidental of the note. Supported values: "sharp", "natural", "flat", "double-sharp",
                    "double-flat", "natural-sharp", "natural-flat". Only applicable if the note is not a rest.

         * @param   inChord
         *          Optional, default `false`. Whether to stack this note on top of the previous one to form a chord.
         * 
         * @param   tie
         *          Optional. The type of tie to use in relation to this note. Supported values: "start", "stop",
         *          "continue", "let-ring". Only applicable if the note is not a rest.
         * 
         *          Note: "continue" is used to signal that a note both stops a tie (from its left neighbor) and
         *          starts a new one (to its right neighbor).
         * 
         *          Note: "let-ring" is used to produce a tie not anchored to an end note. It is used to indicate
         *          that a note should not be "closed", or "chocked", instead be left to sound for as long as its
         *          natural decay allows.
         */
        public function Note(
                duration:String, type:String,
                voice:String = null, pitch:Pitch = null,
                numDots:int = 0, accidental:String = null,
                inChord:Boolean = false, tie:String = null
            ) {

            this._duration = duration;
            this._type = type;
            this._voice = voice;
            this._pitch = pitch;
            this._numDots = numDots;
            this._accidental = accidental;
            this._inChord = inChord;
            this._tie = tie;

        }

        private var _duration:String;
        private var _type:String;
        private var _voice:String;
        private var _pitch:Pitch;
        private var _numDots:int;
        private var _accidental:String;
        private var _inChord:Boolean;
        private var _tie:String;

        public function get duration():String {
            return _duration;
        }

        public function get type():String {
            return _type;
        }

        public function get voice():String {
            return _voice;
        }

        public function get pitch():Pitch {
            return _pitch;
        }

        public function get numDots():int {
            return _numDots;
        }

        public function get accidental():String {
            return _accidental;
        }

        public function get inChord():Boolean {
            return _inChord;
        }

        public function get tie():String {
            return _tie;
        }
    }
}