package eu.claudius.iacob.music.wrappers
{
    import eu.claudius.iacob.music.wrappers.Measure;

    /**
     * Data wrapper for the \<part\> MusicXML element.
     */
    public class PartContent {
        public function PartContent(partId : String,partMeasures : Vector.<Measure>) {
            this._partId = partId;
            this._partMeasures = partMeasures;
        }

        private var _partId : String;
        private var _partMeasures : Vector.<Measure>;

        public function get partId() : String {
            return _partId;
        }

        public function get partMeasures() : Vector.<Measure> {
            return _partMeasures;
        }
    }
}