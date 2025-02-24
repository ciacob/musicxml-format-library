package eu.claudius.iacob.music.wrappers {

    /**
     * Data wrapper for the \<identification\> MusicXML element.
     */
    public class Identification {

        /**
         * Data wrapper for the \<identification\> MusicXML element.
         *
         * @param   creators
         *          Vector of `Creator` instances, see `Creator` for more information.
         * 
         * @param   encoder
         *          Free text; the name of the software that encoded the music, e.g. "Finale 2014".
         * 
         * @param   encodingDate
         *          The date when the music was encoded, in the format "YYYY-MM-DD".
         * 
         * @param   miscFields
         *          Vector of `Misc` instances, see `Misc` for more information.
         */
        public function Identification(
                creators:Vector.<Creator>,
                encoder:String,
                encodingDate:String,
                miscFields:Vector.<Misc>
            ) {
            this._creators = creators;
            this._encoder = encoder;
            this._encodingDate = encodingDate;
            this._miscFields = miscFields;
        }

        private var _creators:Vector.<Creator>;
        private var _encoder:String;
        private var _encodingDate:String;
        private var _miscFields:Vector.<Misc>;

        public function get creators():Vector.<Creator> {
            return _creators;
        }

        public function get encoder():String {
            return _encoder;
        }

        public function get encodingDate():String {
            return _encodingDate;
        }

        public function get miscFields():Vector.<Misc> {
            return _miscFields;
        }
    }
}