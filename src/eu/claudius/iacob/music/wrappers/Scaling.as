package eu.claudius.iacob.music.wrappers {

    /**
     * Data wrapper for the \<scaling\> MusicXML element.
     */
    public class Scaling {
        public function Scaling(millimeters:String, tenths:String) {
            this._millimeters = millimeters;
            this._tenths = tenths;
        }

        private var _millimeters:String;
        private var _tenths:String;

        public function get millimeters():String {
            return this._millimeters;
        }

        public function get tenths():String {
            return this._tenths;
        }
    }
}