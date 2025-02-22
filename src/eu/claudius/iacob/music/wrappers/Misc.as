package eu.claudius.iacob.music.wrappers
{

    /**
     * Data wrapper for one \<miscellaneous-field\> MusicXML element.
     */
    public class Misc {
        public function Misc (fieldName : String, fieldValue : String) {
            this._fieldName = fieldName;
            this._fieldValue = fieldValue;
        }

        private var _fieldName:String;

        private var _fieldValue:String;

        public function get fieldName():String {
            return _fieldName;
        }

        public function get fieldValue():String {
            return _fieldValue;
        }
    }
}