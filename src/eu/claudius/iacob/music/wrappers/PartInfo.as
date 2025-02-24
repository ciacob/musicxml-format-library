package eu.claudius.iacob.music.wrappers {

    /**
     * Data wrapper for the \<score-part\> MusicXML element.
     */
    public class PartInfo {

        /**
         * Data wrapper for the \<score-part\> MusicXML element.
         * @param   id
         *          The part id. Must be unique within the score.
         * 
         * @param   name
         *          The part name, such as "Piano", "Violin", etc.
         * 
         * @param   abbreviation
         *          The part abbreviation, such as "Pno.", "Vln.", etc.
         * 
         * @param   groupId
         *          The part group id. If the part is part of a group,
         *          this is the id of the group.
         * 
         * @param   midiChannel
         *          Optional. The MIDI channel to use for this part.
         * 
         * @param   midiPatch
         *          Optional. The MIDI patch to use for this part, such as "1"
         *          for "Acoustic Grand Piano", or "41" for "Violin".
         */
        public function PartInfo(
                id:String, name:String, abbreviation:String, groupId:String = null,
                midiChannel:String = null, midiPatch:String = null
            ) {
            this._id = id;
            this._name = name;
            this._abbreviation = abbreviation;
            this._groupId = groupId;
            this._midiChannel = midiChannel;
            this._midiPatch = midiPatch;
        }

        private var _id:String;
        public function get id():String {
            return _id;
        }

        private var _name:String;
        public function get name():String {
            return _name;
        }

        private var _abbreviation:String;
        public function get abbreviation():String {
            return _abbreviation;
        }

        private var _groupId:String;
        public function get groupId():String {
            return _groupId;
        }

        private var _midiChannel:String;
        public function get midiChannel():String {
            return _midiChannel;
        }

        private var _midiPatch:String;
        public function get midiPatch():String {
            return _midiPatch;
        }
    }
}