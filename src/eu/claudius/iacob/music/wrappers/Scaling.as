package eu.claudius.iacob.music.wrappers {

    /**
     * Data wrapper for the \<scaling\> MusicXML element.
     */
    public class Scaling {

        /**
         * Data wrapper for the \<scaling\> MusicXML element.
         * @param   millimeters
         *          The millimeters attribute of the \<scaling\> element. Represents the
         *          real-world size part of the scaling agreement.
         * 
         * @param   tenths
         *          The tenths attribute of the \<scaling\> element. Represents the
         *          logical size part of the scaling agreement.
         * 
         *          Note:
         *          Between two adjacent lines of a staff there are 10 "tenths" of space.
         *          A full staff is represented by 40 "tenths". If `millimeters` was 8 and
         *          `tenths` was 40, then between each adjacent two lines of the staff
         *          there should be a space equivalent to 2 millimeters.
         */
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