package eu.claudius.iacob.music.wrappers {

    /**
     * Wrapping class for the scaling element. Specifies the relationship between
     * MusicXML’s "tenths" unit and real-world measurements in millimeters.
     * @param   `millimeters`: Defines the length of one staff space in millimeters.
     *
     * @param   `tenths`: Defines the length of one staff space in tenths (MusicXML’s
     *          internal unit for positioning elements).
     *
     * ## Example:
     * If `<millimeters>7.0</millimeters>` and `<tenths>40</tenths>`, the
     * resulting scaling factor is `7.0 / 40 = 0.175 mm per tenth`.
     * 
     * A higher `tenths` value makes the score appear smaller, while a larger 
     * `millimeters` value makes it appear larger.
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