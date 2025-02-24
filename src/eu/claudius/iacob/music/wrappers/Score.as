package eu.claudius.iacob.music.wrappers {

    /**
     * Data wrapper for the \<score-partwise\> MusicXML element.
     */
    public class Score {

        /**
         * Data wrapper for the \<score-partwise\> MusicXML element.
         *
         * @param   title
         *          The title of the score, free text.
         * 
         * @param   identification
         *          An Identification instance, see the Identification class for more details.
         * 
         * @param   width
         *          The width of the score, in "tenths", the internal MusicXML space unit.
         * 
         * @param   height
         *          The height of the score, in "tenths", the internal MusicXML space unit.
         * 
         * @param   margins
         *          A vector of PageMargins instances, see the PageMargins class for more details.
         * 
         * @param   scaling
         *          A Scaling instance, see the Scaling class for more details.
         * 
         * @param   partsInfo
         *          A vector of PartInfo instances, see the PartInfo class for more details.
         * 
         * @param   partsContent
         *          A vector of PartContent instances, see the PartContent class for more details.
         * 
         * @param   groupsInfo
         *          A vector of Group instances, see the Group class for more details.
         */
        public function Score(
                title:String,
                identification:Identification,
                width:String,
                height:String,
                margins:Vector.<PageMargins>,
                scaling:Scaling,
                partsInfo:Vector.<PartInfo>,
                partsContent:Vector.<PartContent>,
                groupsInfo:Vector.<Group> = null
            ) {
            _title = title;
            _identification = identification;
            _width = width;
            _height = height;
            _margins = margins;
            _scaling = scaling;
            _partsInfo = partsInfo;
            _groupsInfo = groupsInfo;
            _partsContent = partsContent;

        }

        private var _title:String;
        private var _identification:Identification;
        private var _width:String;
        private var _height:String;
        private var _margins:Vector.<PageMargins>;
        private var _scaling:Scaling;
        private var _partsInfo:Vector.<PartInfo>;
        private var _groupsInfo:Vector.<Group>;
        private var _partsContent:Vector.<PartContent>;

        public function get title():String {
            return _title;
        }

        public function get identification():Identification {
            return _identification;
        }

        public function get width():String {
            return _width;
        }

        public function get height():String {
            return _height;
        }

        public function get margins():Vector.<PageMargins> {
            return _margins;
        }

        public function get scaling():Scaling {
            return _scaling;
        }

        public function get partsInfo():Vector.<PartInfo> {
            return _partsInfo;
        }

        public function get groupsInfo():Vector.<Group> {
            return _groupsInfo;
        }

        public function get partsContent():Vector.<PartContent> {
            return _partsContent;
        }

    }
}