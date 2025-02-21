package eu.claudius.iacob.music.wrappers {

    /**
     * PageMargins wrapper class.
     */
    public class PageMargins {
        public function PageMargins(left:String, right:String, top:String, bottom:String,
                type:String) {

            this._left = left;
            this._right = right;
            this._top = top;
            this._bottom = bottom;
            this._type = type;
        }

        public function get left():String {
            return this._left;
        }

        public function get right():String {
            return this._right;
        }

        public function get top():String {
            return this._top;
        }

        public function get bottom():String {
            return this._bottom;
        }

        public function get type():String {
            return this._type;
        }

        private var _left:String;
        private var _right:String;
        private var _top:String;
        private var _bottom:String;
        private var _type:String;
    }
}