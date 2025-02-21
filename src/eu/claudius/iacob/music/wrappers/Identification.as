package eu.claudius.iacob.music.wrappers {

    /**
     * The Identification class is a wrapper for the MusicXML Identification element.
     */
    public class Identification {
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