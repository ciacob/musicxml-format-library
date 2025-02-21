package eu.claudius.iacob.music.wrappers {

    /**
     * The Creator class is a wrapper for the MusicXML Creator element.
     */
    public class Creator {
        public function Creator(creatorType:String, creatorName:String) {
            this._creatorType = creatorType;
            this._creatorName = creatorName;
        }

        private var _creatorType:String;
        private var _creatorName:String;

        public function get creatorType():String {
            return _creatorType;
        }

        public function get creatorName():String {
            return _creatorName;
        }
    }
}