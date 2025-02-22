package eu.claudius.iacob.music.wrappers {

    /**
     * Data wrapper for the \<score-partwise\> MusicXML element.
     */
    public class Score {
        public function Score(
                title:String,
                identification:Identification,
                width:String,
                height:String,
                margins:PageMargins,
                scaling:Scaling,
                partsInfo:Vector.<PartInfo>,
                groupsInfo:Vector.<Group>,
                partsContent:Vector.<PartContent>
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
        private var _margins:PageMargins;
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

        public function get margins():PageMargins {
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