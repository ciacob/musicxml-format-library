package eu.claudius.iacob.music.wrappers {

    /**
     * Data wrapper for the \<page-margins\> MusicXML element.
     */
    public class PageMargins {

        /**
         * Data wrapper for the \<page-margins\> MusicXML element.
         *
         * @param   left
         *          The left margin, in "tenths", the MusicXML internal unit, representing the
         *          tenth of the distance between two adjacent staff lines. The actual (real world)
         *          value will be calculated based on the `\<scaling\>` element.
         *          
         * @param   right
         *          The right margin.
         * 
         * @param   top
         *          The top margin.
         * 
         * @param   bottom
         *          The bottom margin.
         * 
         * @param   type
         *          The type of the margins. How to apply the margins with respect to left and
         *          right pagination. Supported values: "both", "odd", "even".
         */
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