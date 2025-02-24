package eu.claudius.iacob.music.wrappers {

    /**
     * Data wrapper for the \<creator\> element of \<identification\>.
     */
    public class Creator {

        /**
         * Data wrapper for the \<creator\> element of \<identification\>.
         * @param   creatorType
         *          The type of the creator, e.g. "composer" or "lyricist".
         * 
         * @param   creatorName
         *          The name of the creator, e.g. "Johann Sebastian Bach".
         */
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