package eu.claudius.iacob.music.wrappers {

    /**
     * Data wrapper for a \<part-group\> MusicXML element.
     */
    public class Group {
        public function Group(id:String, symbol:String, fullBarlines:Boolean = false) {
            this._id = id;
            this._symbol = symbol;
            this._fullBarlines = fullBarlines;
        }

        private var _id:String;
        private var _symbol:String;
        private var _fullBarlines:Boolean;

        public function get id():String {
            return _id;
        }

        public function get symbol():String {
            return _symbol;
        }

        public function get fullBarlines():Boolean {
            return _fullBarlines;
        }
    }
}