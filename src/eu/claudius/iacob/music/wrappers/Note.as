package eu.claudius.iacob.music.wrappers {
    import eu.claudius.iacob.music.wrappers.Pitch;

    /**
     * Data wrapper for one \<note\> MusicXML element.
     */
    public class Note {
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