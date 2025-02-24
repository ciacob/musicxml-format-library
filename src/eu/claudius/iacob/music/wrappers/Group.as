package eu.claudius.iacob.music.wrappers {

    /**
     * Data wrapper for a \<part-group\> MusicXML element.
     */
    public class Group {

        /**
         * Data wrapper for a \<part-group\> MusicXML element.
         * 
         * @param   id
         *          The group's id. Must be unique within the part-list.
         * 
         * @param   symbol
         *          The group's symbol, i.e., the graphical form the grouping should take in the score.
         *          Supported values: "brace", "bracket", "line", "none", "square".
         * 
         * @param   fullBarlines
         *          Optional, default `false`. Whether to draw full barlines across the group,
         *          i.e., both on the staves themselves and in-between them. If false, barlines
         *          are only drawn on the staves.
         */
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