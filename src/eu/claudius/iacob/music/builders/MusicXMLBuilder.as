package eu.claudius.iacob.music.builders {
    import ro.ciacob.utils.Strings;
    import eu.claudius.iacob.music.wrappers.Misc;
    import eu.claudius.iacob.music.wrappers.Creator;
    import eu.claudius.iacob.music.wrappers.Identification;
    import eu.claudius.iacob.music.wrappers.PageMargins;
    import eu.claudius.iacob.music.wrappers.Scaling;
    import eu.claudius.iacob.music.wrappers.Group;
    import eu.claudius.iacob.music.wrappers.PartInfo;
    import eu.claudius.iacob.music.wrappers.Note;
    import eu.claudius.iacob.music.wrappers.Pitch;
    import eu.claudius.iacob.music.wrappers.Attributes;
    import eu.claudius.iacob.music.wrappers.Direction;
    import eu.claudius.iacob.music.wrappers.PartContent;
    import eu.claudius.iacob.music.wrappers.Measure;
    import eu.claudius.iacob.music.wrappers.Score;

    /**
     * A utility class for building the Extra-Musical Context section of a MusicXML file using E4X.
     */
    public class MusicXMLBuilder {

        public function MusicXMLBuilder() {
            // Constructor (not used, since all functions are static)
        }

        // =============================
        // I. EXTRA-MUSICAL CONTEXT
        // =============================

        // -----------------------------
        // (i) LEAF NODE BUILDERS
        // -----------------------------

        /**
         * Builds the \<work-title\> element.
         * @param title: String (The title of the score)
         * @return XML representing the \<work-title\> element or null for an empty title.
         */
        protected static function buildWorkTitle(title:String):XML {
            const $title:String = Strings.trim(title || '');
            return $title ? <work-title>{$title}</work-title>                                                      : null;
        }

        /**
         * Builds the \<creator\> element.
         * @param type: String (The type of creator, e.g., "composer")
         * @param name: String (The name of the creator)
         * @return XML representing the \<creator\> element or null for empty type or name.
         */
        protected static function buildCreator(type:String, name:String):XML {
            const $type:String = Strings.trim(type || '');
            const $name:String = Strings.trim(name || '');
            return ($type && $name) ? <creator type={$type}>{$name}</creator>                                                      : null;
        }

        /**
         * Builds the \<encoder\> element.
         * @param encoder: String (The name/version of the software that encoded the file)
         * @return XML representing the \<encoder\> element, or null for an empty encoder.
         */
        protected static function buildEncoder(encoder:String):XML {
            const $encoder:String = Strings.trim(encoder || '');
            return $encoder ? <encoder>{$encoder}</encoder>                                                      : null;
        }

        /**
         * Builds the \<encoding-date\> element.
         * @param encodingDate: String (The date when the file was encoded, e.g., "YYYY-MM-DD")
         * @return XML representing the \<encoding-date\> element, or null for an empty date.
         */
        protected static function buildEncodingDate(encodingDate:String):XML {
            const $date:String = Strings.trim(encodingDate || '');
            return $date ? <encoding-date>{$date}</encoding-date>                                                      : null;
        }

        /**
         * Builds a \<miscellaneous-field\> element.
         * @param miscName: String (The name of the miscellaneous field, e.g., "history", "notes")
         * @param miscVal: String (The textual content of the field)
         * @return XML representing a \<miscellaneous-field\> element, or null for empty name or value.
         */
        protected static function buildMiscellaneousField(miscName:String, miscVal:String):XML {
            const $name:String = Strings.trim(miscName || '');
            const $value:String = Strings.trim(miscVal || '');
            return ($name && $value) ?
                <miscellaneous-field name={$name}>{$value}</miscellaneous-field>                                                      : null;
        }

        // --------------------------------
        // (ii) INTERMEDIATE NODE BUILDERS
        // --------------------------------

        /**
         * Builds the \<work\> element containing \<work-title\>.
         * @param workTitle String (The title of the score)
         * @return XML representing the \<work\> element. Can be empty for missing/invalid input.
         */
        protected static function buildWork(workTitle:String):XML {
            var work:XML = <work/>;
            work.appendChild(buildWorkTitle(workTitle));
            return work;
        }

        /**
         * Builds the \<encoding\> element containing \<encoder\> and \<encoding-date\>.
         * @param encoder: String (The name/version of the encoding software).
         * @param encodingDate: String (The encoding date).
         * @return  XML representing the \<encoding\> element. Can be empty for missing/invalid input.
         */
        protected static function buildEncoding(encoder:String, encodingDate:String):XML {
            var encoding:XML = <encoding/>;
            encoding.appendChild(buildEncoder(encoder));
            encoding.appendChild(buildEncodingDate(encodingDate));
            return encoding;
        }

        /**
         * Builds the \<miscellaneous\> element containing multiple \<miscellaneous-field\> elements.
         * @param miscElements: Vector of `Misc` instances.
         * @return XML representing the \<miscellaneous\> element. Can be empty for missing/invalid input.
         */
        protected static function buildMiscellaneous(miscElements:Vector.<Misc>):XML {
            var miscellaneous:XML = <miscellaneous/>;

            for each (var element:Misc in miscElements) {
                miscellaneous.appendChild(
                        buildMiscellaneousField(element.fieldName, element.fieldValue));
            }

            return miscellaneous;
        }

        /**
         * Builds the \<identification\> element containing \<creator\>, \<encoding\>, and \<miscellaneous\>.
         * @param iData - An Identification instance.
         * @return XML representing the \<identification\> element.
         */
        protected static function buildIdentification(iData:Identification):XML {
            var identification:XML = <identification/>;

            // Add creators (composer, lyricist, etc.)
            if (iData.creators && iData.creators.length > 0) {
                for each (var creator:Creator in iData.creators) {
                    identification.appendChild(
                            buildCreator(creator.creatorType, creator.creatorName));
                }
            }

            // Add encoding information
            identification.appendChild(buildEncoding(iData.encoder, iData.encodingDate));

            // Add miscellaneous metadata (history, notes, etc.)
            if (iData.miscFields && iData.miscFields.length > 0) {
                identification.appendChild(buildMiscellaneous(iData.miscFields));
            }

            return identification;
        }

        // -----------------------------
        // (iii) ROOT NODE BUILDER
        // -----------------------------

        /**
         * Builds the entire "Extra-Musical Context" section as XML.
         * @param root: XML (The root element of the MusicXML document)
         * @param title: String (The title of the score)
         * @param identification: Identification instance.
         *
         * Note: does not return a value. Operates directly on the provided XML root.
         */
        public static function addExtraMusicalContent(root:XML, title:String, identification:Identification):void {

            if (!root) {
                return;
            }

            // Add work information
            root.appendChild(buildWork(title));

            // Add identification (creator, encoding, and miscellaneous fields)
            root.appendChild(buildIdentification(identification));
        }

        // =============================
        // PRESENTATION DEFAULTS
        // =============================

        // -----------------------------
        // (i) LEAF NODE BUILDERS
        // -----------------------------

        /**
         * Builds the \<scaling\> element.
         * @param millimeters: String (Real-world size of a "tenths" unit, e.g., 6.7744)
         * @param tenths: String (Relative unit size in MusicXML, e.g., 40)
         * @return  XML representing the <scaling> element. Can be empty for missing/invalid input.
         */
        protected static function buildScaling(millimeters:String, tenths:String):XML {
            const $millimeters:String = Strings.trim(millimeters || '');
            const $tenths:String = Strings.trim(tenths || '');

            if (!$millimeters || !$tenths ||
                    !Strings.isNumeric($millimeters) || !Strings.isNumeric($tenths)) {
                trace("Invalid scaling values: [" + $millimeters + ", " + $tenths + "]");
                return null;
            }

            const scaling:XML = <scaling/>;
            scaling.appendChild(<millimeters>{$millimeters}</millimeters>);
            scaling.appendChild(<tenths>{$tenths}</tenths>);

            return scaling;
        }

        /**
         * Builds the \<page-layout\> element (without margins).
         * @param width:String (Width of the page in millimeters, e.g., 1239.96)
         * @param height: Number (Height of the page in millimeters, e.g., 1753.66)
         * @return  XML representing the \<page-layout\> element (without margins).
         *          Can be empty for missing/invalid input.
         */
        protected static function buildPageLayout(width:String, height:String):XML {
            const $width:String = Strings.trim(width || '');
            const $height:String = Strings.trim(height || '');
            if (!$width || !$height ||
                    !Strings.isNumeric($width) || !Strings.isNumeric($height)) {
                trace("Invalid page layout values: [" + $width + ", " + $height + "]");
                return null;
            }

            const pageLayout:XML = <page-layout />;
            pageLayout.appendChild(<page-width>{$width}</page-width>);
            pageLayout.appendChild(<page-height>{$height}</page-height>);

            return pageLayout;
        }

        /**
         * Builds the \<page-margins\> element.
         * @param left: String (Margin on the left, e.g., 59.0458)
         * @param right: String (Margin on the right, e.g., 59.0458)
         * @param top: String (Margin on the top, e.g., 206.66)
         * @param bottom: String (Margin at the bottom, e.g., 59.0458)
         * @param type: String (Optional: "both", "odd", "even" to indicate page type)
         * @return  XML representing the \<page-margins\> element. Can be empty for missing/invalid input.
         */
        protected static function buildPageMargins(
                left:String,
                right:String,
                top:String,
                bottom:String,
                type:String = null
            ):XML {
            const $left:String = Strings.trim(left || '');
            const $right:String = Strings.trim(right || '');
            const $top:String = Strings.trim(top || '');
            const $bottom:String = Strings.trim(bottom || '');
            if (!$left || !$right || !$top || !$bottom ||
                    !Strings.isNumeric($left) || !Strings.isNumeric($right) ||
                    !Strings.isNumeric($top) || !Strings.isNumeric($bottom)) {
                trace("Invalid page margins: [" + $left + ", " + $right + ", " + $top + ", " + $bottom + "]");
                return null;
            }

            const pageMargins:XML = <page-margins/>;
            pageMargins.appendChild(<left-margin>{$left}</left-margin>);
            pageMargins.appendChild(<right-margin>{$right}</right-margin>);
            pageMargins.appendChild(<top-margin>{$top}</top-margin>);
            pageMargins.appendChild(<bottom-margin>{$bottom}</bottom-margin>);
            if (type && (type == "both" || type == "odd" || type == "even")) {
                pageMargins.@type = type;
            }

            return pageMargins;
        }

        // --------------------------------
        // (ii) INTERMEDIATE NODE BUILDERS
        // --------------------------------

        /**
         * Builds the \<page-layout\> element, including <page-margins>.
         * @param width:String (Width of the page in millimeters, e.g., 1239.96)
         * @param height: Number (Height of the page in millimeters, e.g., 1753.66)
         * @param margins: PageMargins instance.
         * @return XML representing the \<page-layout\> element.
         */
        protected static function buildFullPageLayout(width:String, height:String,
                margins:Vector.<PageMargins>):XML {
            const pageLayout:XML = buildPageLayout(width, height);

            for each (var margin:PageMargins in margins){
                pageLayout.appendChild(buildPageMargins(margin.left, margin.right,
                        margin.top, margin.bottom, margin.type));
            }
            
            return pageLayout;
        }

        // -----------------------------
        // (iii) ROOT NODE BUILDER
        // -----------------------------

        /**
         * Builds the entire \<defaults\> section, which contains \<scaling\> and \<page-layout\>.
         * @param width : String (Width of the page in millimeters, e.g., 1239.96)
         * @param height: String (Height of the page in millimeters, e.g., 1753.66)
         * @param margins: PageMargins instance.
         * @param scaling: Scaling instance.
         *
         * @return XML representing the entire <defaults> section.
         */
        public static function buildPresentationDefaults(width:String, height:String,
                margins:Vector.<PageMargins>, scaling:Scaling):XML {
            const defaults:XML = <defaults/>;

            // Add scaling
            defaults.appendChild(buildScaling(scaling.millimeters, scaling.tenths));

            // Add full page layout including margins
            defaults.appendChild(buildFullPageLayout(width, height, margins));

            return defaults;
        }

        // =============================
        // III: Musical Context
        // =============================

        // -----------------------------
        // (i) LEAF NODE BUILDERS
        // -----------------------------

        /**
         * Builds a \<part-group\> element (either start or stop).
         * @param id: String (The unique identifier for the group)
         * @param type: String ("start" or "stop")
         * @param symbol: String (Optional, visual representation, one of "brace", "bracket", "line", "none", "square")
         * @param fullBarlines: Boolean (Optional, whether barlines span across all staves)
         * @return XML representing a <part-group> element.
         */
        protected static function buildPartGroup(id:String, type:String,
                symbol:String = null, fullBarlines:Boolean = false):XML {

            const $id:String = Strings.trim(id || '');
            const $type:String = Strings.trim(type || '');
            if (!$id || !$type) {
                trace("Invalid part group: [" + $id + ", " + $type + "]");
                return null;
            }
            if ($type != "start" && $type != "stop") {
                trace("Invalid part group type: [" + $type + "]");
                return null;
            }

            var partGroup:XML = <part-group number={$id} type={$type}/>;

            if ($type == "start") {
                const $symbol:String = Strings.trim(symbol || '');
                if ($symbol && ['brace', 'bracket', 'line', 'none', 'square'].includes($symbol)) {
                    partGroup.appendChild(<group-symbol>{$symbol}</group-symbol>);
                }
                if (fullBarlines) {
                    partGroup.appendChild(<group-barline>yes</group-barline>);
                }
            }

            return partGroup;
        }

        /**
         * Builds a \<score-part\> element.
         * @param id: String (The unique identifier for the part)
         * @param name: String (The full instrument name)
         * @param abbreviation: String (The short instrument name)
         * @param midiChannel: String (Optional, the MIDI playback channel)
         * @param midiPatch: String (Optional, the MIDI instrument patch number)
         * @return XML representing a <score-part> element. Can be empty for missing/invalid input.
         */
        protected static function buildScorePart(
                id:String, name:String, abbreviation:String,
                midiChannel:String = null, midiPatch:String = null
            ):XML {
            const $id:String = Strings.trim(id || '');
            const $name:String = Strings.trim(name || '');
            const $abbreviation:String = Strings.trim(abbreviation || '');
            if (!$id || !$name || !$abbreviation) {
                trace("Invalid score part: [" + $id + ", " + $name + ", " + $abbreviation + "]");
                return null;
            }
            var scorePart:XML = <score-part id={$id}/>;

            scorePart.appendChild(<part-name>{$name}</part-name>);
            scorePart.appendChild(<part-abbreviation>{$abbreviation}</part-abbreviation>);
            scorePart.appendChild(<score-instrument id={$id + "-inst"}/>);

            const $midiChannel:String = Strings.trim(midiChannel || '');
            const $midiPatch:String = Strings.trim(midiPatch || '');
            if ($midiChannel && $midiPatch &&
                    Strings.isNumeric($midiChannel) && Strings.isNumeric($midiPatch)) {
                var midiInstrument:XML = <midi-instrument id={$id + "-inst"}/>;
                midiInstrument.appendChild(<midi-channel>{$midiChannel}</midi-channel>);
                midiInstrument.appendChild(<midi-program>{$midiPatch}</midi-program>);
                scorePart.appendChild(midiInstrument);
            }
            return scorePart;
        }

        // -----------------------------
        // (ii) INTERMEDIATE NODE BUILDERS
        // -----------------------------

        /**
         * Builds the part groups for the score.
         * @param groups: Vector of `Group` instances.
         * @return XMLList representing the \<part-group\> elements. Can be empty for missing/invalid input.
         */
        protected static function buildPartGroups(groups:Vector.<Group>):XMLList {
            var partGroups:XMLList = new XMLList();

            for each (var group:Group in groups) {
                partGroups += buildPartGroup(group.id, "start", group.symbol, group.fullBarlines);
                partGroups += buildPartGroup(group.id, "stop");
            }

            return partGroups;
        }

        /**
         * Builds the score parts for the score.
         * @param parts: Vector of `ScorePart` instances.
         * @return XMLList representing the \<score-part\> elements. Can be empty for missing/invalid input.
         */
        protected static function buildScoreParts(parts:Vector.<PartInfo>):XMLList {
            var scoreParts:XMLList = new XMLList();

            for each (var part:PartInfo in parts) {
                scoreParts += buildScorePart(part.id, part.name, part.abbreviation,
                        part.midiChannel, part.midiPatch);
            }

            return scoreParts;
        }

        // -----------------------------
        // (iii) ROOT NODE BUILDER
        // -----------------------------

        /**
         * Builds the entire \<part-list\> section, correctly inserting \<part-group\> start/stop markers around grouped parts.
         * @param parts: Vector of `ScorePart` instances.
         * @param groups: Optional, Vector of `Group` instances.
         *
         * @return XML representing the \<part-list\> section, with proper group handling.
         */
        public static function buildMusicalContext(parts:Vector.<PartInfo>, groups:Vector.<Group> = null):XML {
            const partList:XML = <part-list/>;

            // If no groups exist, just append all parts without any special handling
            if (!groups || groups.length == 0) {
                partList.appendChild(buildScoreParts(parts));
                return partList;
            }

            // Sort parts by group, preserving order of ungrouped parts
            parts.sort(function (a:PartInfo, b:PartInfo):int {
                    if (!a.groupId && !b.groupId)
                        return 0; // Both ungrouped, keep original placement
                    if (!a.groupId)
                        return 0; // a is ungrouped, keep original placement
                    if (!b.groupId)
                        return 0; // b is ungrouped, keep original placement
                    return a.groupId.localeCompare(b.groupId); // Sort grouped parts together
                });

            // Track group states
            const groupStates:Object = {}; // { "<groupID>": "started" or "stopped" }
            var currentGroupID:String = null;

            // Loop through parts and handle grouping logic
            for each (var part:PartInfo in parts) {
                if (part.groupId) {
                    // If this part belongs to a group
                    if (currentGroupID !== part.groupId) {
                        // If switching to a new group
                        if (currentGroupID) {
                            // If a group was open, close it first
                            partList.appendChild(buildPartGroup(currentGroupID, "stop"));
                            groupStates[currentGroupID] = "stopped";
                            currentGroupID = null;
                        }
                        if (!groupStates[part.groupId]) {
                            // Find the group definition by ID
                            var groupData:Group = groups.filter(function (g:Group, ...rest):Boolean {
                                    return g.id === part.groupId;
                                })[0];

                            if (groupData) {
                                // Start a new group
                                partList.appendChild(buildPartGroup(groupData.id, "start", groupData.symbol, groupData.fullBarlines));
                                groupStates[groupData.id] = "started";
                                currentGroupID = groupData.id;
                            }
                        }
                    }
                }

                // Append the part
                partList.appendChild(buildScorePart(part.id, part.name, part.abbreviation,
                            part.midiChannel, part.midiPatch));
            }

            // Close any remaining open groups
            if (currentGroupID) {
                partList.appendChild(buildPartGroup(currentGroupID, "stop"));
                groupStates[currentGroupID] = "stopped";
            }

            return partList;
        }

        // =============================
        // IV: ACTUAL MUSIC
        // =============================

        // -----------------------------
        // (i) LEAF NODE BUILDERS
        // -----------------------------

        /**
         * Builds the \<pitch\> element for a note.
         * @param step: String (The note name, e.g., "A", "B", "C")
         * @param octave: String (The octave number)
         * @param alteration: String (Optional, e.g., "1", "-1", "0", etc.)
         * @return XML representing the \<pitch\> element. Can be empty for missing/invalid input.
         */
        protected static function buildPitch(step:String, octave:String, alteration:String = null):XML {
            const pitch:XML = <pitch/>;

            const $step:String = Strings.trim(step || '').toUpperCase();
            const $octave:String = Strings.trim(octave || '');
            if (!$step || !$octave || !Strings.isNumeric($octave)) {
                trace("Invalid pitch: [" + $step + ", " + $octave + "]");
                return null;
            }
            if (!["C", "D", "E", "F", "G", "A", "B"].includes($step)) {
                trace("Invalid pitch step: [" + $step + "]");
                return null;
            }
            if (!['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].includes($octave)) {
                trace("Invalid pitch octave: [" + $octave + "]");
                return null;
            }
            pitch.appendChild(<step>{$step}</step>);
            pitch.appendChild(<octave>{$octave}</octave>);

            const $alter:String = Strings.trim(alteration || '');
            if ($alter && $alter != "0" && Strings.isNumeric($alter)) {
                pitch.appendChild(<alter>{$alter}</alter>);
            }
            return pitch;
        }

        /**
         * Builds the \<duration\> element.
         * @param duration: String (The note duration value, as a number of divisions)
         * @return XML representing the \<duration\> element. Can be empty for missing/invalid input.
         */
        protected static function buildDuration(duration:String):XML {
            const $duration:String = Strings.trim(duration || '');
            if (!$duration || !Strings.isNumeric($duration)) {
                trace("Invalid duration: [" + $duration + "]");
                return null;
            }

            return <duration>{duration}</duration>;
        }

        /**
         * Builds the \<type\> element.
         * @param type: String ("whole", "half", "quarter", "eighth", etc.)
         * @return XML representing the \<type\> element. Can be empty for missing/invalid input.
         */
        protected static function buildType(type:String):XML {
            const $type:String = Strings.trim(type || '');
            if (!$type) {
                trace("Invalid note type: [" + $type + "]");
                return null;
            }
            const noteTypes:Array = [
                    "64th", "32nd", "16th", "eighth", "quarter", "half", "whole"
                ];
            if (!noteTypes.includes($type)) {
                trace("Invalid note type: [" + $type + "]");
                return null;
            }

            return <type>{type}</type>;
        }

        /**
         * Builds the \<tie\> element.
         * @param tieType: String (e.g., "start" or "stop")
         * @return XML representing the \<tie\> element. Can be empty for missing/invalid input.
         */
        protected static function buildTie(tieType:String):XML {
            const $tieType:String = Strings.trim(tieType || '');
            if (!$tieType) {
                trace("Invalid tie type: [" + $tieType + "]");
                return null;
            }
            const tieTypes:Array = ["start", "stop", "continue", "let-ring"];
            if (!tieTypes.includes($tieType)) {
                trace("Invalid tie type: [" + $tieType + "]");
                return null;
            }
            return <tie type={tieType}/>;
        }

        /**
         * Builds the \<accidental\> element.
         * @param accidental: String (e.g., "sharp", "flat", "natural", etc.)
         * @return XML representing the \<accidental\> element. Can be empty for missing/invalid input.
         */
        protected static function buildAccidental(accidental:String):XML {
            const $accidental:String = Strings.trim(accidental || '');
            if (!$accidental) {
                trace("Invalid accidental: [" + $accidental + "]");
                return null;
            }
            const accidentalTypes:Array = [
                    "sharp", "natural", "flat", "double-sharp",
                    "double-flat", "natural-sharp", "natural-flat"
                ];
            if (!accidentalTypes.includes($accidental)) {
                trace("Invalid accidental: [" + $accidental + "]");
                return null;
            }

            return <accidental>{accidental}</accidental>;
        }

        /**
         * Builds the \<divisions\> element.
         * @param divisions: String (Rhythmic granularity of the quarter note)
         * @return XML representing the \<divisions\> element. Can be empty for missing/invalid input.
         */
        protected static function buildDivisions(divisions:String):XML {
            const $divisions:String = Strings.trim(divisions || '');
            if (!$divisions || !Strings.isNumeric($divisions)) {
                trace("Invalid divisions: [" + $divisions + "]");
                return null;
            }

            return <divisions>{divisions}</divisions>;
        }

        /**
         * Builds the \<fifths\> element.
         * @param fifths: String (Number of fifths in the key signature)
         * @return XML representing the \<fifths\> element. Can be empty for missing/invalid input.
         */
        protected static function buildFifths(fifths:String):XML {
            const $fifths:String = Strings.trim(fifths || '');
            if (!$fifths || !Strings.isNumeric($fifths)) {
                trace("Invalid fifths: [" + $fifths + "]");
                return null;
            }

            return <fifths>{fifths}</fifths>;
        }

        /**
         * Builds the \<mode\> element.
         * @param mode: String (The mode of the key signature, e.g., "major" or "minor")
         * @return XML representing the \<mode\> element. Can be empty for missing/invalid input.
         */
        protected static function buildMode(mode:String):XML {
            const $mode:String = Strings.trim(mode || '');
            if (!$mode) {
                trace("Invalid mode: [" + $mode + "]");
                return null;
            }
            const modes:Array = ["major", "minor"];
            if (!modes.includes($mode)) {
                trace("Invalid mode: [" + $mode + "]");
                return null;
            }

            return <mode>{mode}</mode>;
        }

        /**
         * Builds the \<beats\> element.
         * @param beats: String (The number of beats in a measure)
         * @return XML representing the \<beats\> element. Can be empty for missing/invalid input.
         */
        protected static function buildBeats(beats:String):XML {
            const $beats:String = Strings.trim(beats || '');
            if (!$beats || !Strings.isNumeric($beats)) {
                trace("Invalid beats: [" + $beats + "]");
                return null;
            }

            return <beats>{beats}</beats>;
        }

        /**
         * Builds the \<beat-type\> element.
         * @param beatType: String (The note value that receives the beat, e.g., "4" for a quarter note)
         * @return XML representing the \<beat-type\> element. Can be empty for missing/invalid input.
         */
        protected static function buildBeatType(beatType:String):XML {
            const $beatType:String = Strings.trim(beatType || '');
            if (!$beatType || !Strings.isNumeric($beatType)) {
                trace("Invalid beat type: [" + $beatType + "]");
                return null;
            }

            return <beat-type>{beatType}</beat-type>;
        }

        /**
         * Builds the \<sign\> element.
         * @param sign: String (The clef sign, e.g., "G", "F", "C", "percussion", "none")
         * @return The XML representing the <sign> element. Can be empty for missing/invalid input.
         */
        protected static function buildSign(sign:String):XML {
            const $sign:String = Strings.trim(sign || '');
            if (!$sign) {
                trace("Invalid clef sign: [" + $sign + "]");
                return null;
            }
            const clefSigns:Array = ["G", "F", "C", "percussion", "none"];
            if (!clefSigns.includes($sign)) {
                trace("Invalid clef sign: [" + $sign + "]");
                return null;
            }

            return <sign>{$sign}</sign>;
        }

        /**
         * Builds the \<line\> element.
         * @param line: String (The clef line number, e.g., "1", "2", "3", etc.)
         * @return XML representing the \<line\> element. Can be empty for missing/invalid input.
         */
        protected static function buildLine(line:String):XML {
            const $line:String = Strings.trim(line || '');
            if (!$line || !Strings.isNumeric($line)) {
                trace("Invalid clef line: [" + $line + "]");
                return null;
            }
            const clefLines:Array = ["1", "2", "3", "4", "5"];
            if (!clefLines.includes($line)) {
                trace("Invalid clef line: [" + $line + "]");
                return null;
            }

            return <line>{$line}</line>;
        }

        /**
         * Builds the \<dot\> element.
         * @return XML representing the \<dot\> element.
         */
        protected static function buildDot():XML {
            return <dot/>;
        }

        /**
         * Builds the \<sound\> element.
         * @param tempo: String (The tempo of the note, e.g., "120")
         * @return XML representing the \<sound\> element. Can be empty for missing/invalid input.
         */
        protected static function buildSound(tempo:String):XML {
            const $tempo:String = Strings.trim(tempo || '');
            if (!$tempo || !Strings.isNumeric($tempo)) {
                trace("Invalid tempo: [" + $tempo + "]");
                return null;
            }
            return <sound tempo={$tempo}/>;
        }

        /**
         * Builds the \<beat-unit\> element.
         * @param beatUnit: String (The type of the beat unit, e.g., "quarter")
         * @return XML representing the \<beat-unit\> element. Can be empty for missing/invalid input.
         */
        protected static function buildBeatUnit(beatUnit:String):XML {
            const $beatUnit:String = Strings.trim(beatUnit || '');
            if (!$beatUnit) {
                trace("Invalid beat unit: [" + $beatUnit + "]");
                return null;
            }
            const beatUnits:Array = ["whole", "half", "quarter", "eighth", "16th", "32nd", "64th", "128th"];
            if (!beatUnits.includes($beatUnit)) {
                trace("Invalid beat unit: [" + $beatUnit + "]");
                return null;
            }

            return <beat-unit>{$beatUnit}</beat-unit>;
        }

        /**
         * Builds the \<per-minute\> element.
         * @param perMinute String (How many beat units to play in a minute, e.g., "120")
         * @return XML representing the \<per-minute\> element. Can be empty for missing/invalid input.
         */
        protected static function buildPerMinute(perMinute:String):XML {
            const $perMinute:String = Strings.trim(perMinute || '');
            if (!$perMinute || !Strings.isNumeric($perMinute)) {
                trace("Invalid per-minute: [" + $perMinute + "]");
                return null;
            }
            return <per-minute>{$perMinute}</per-minute>;
        }

        /**
         * Builds the \<words\> element.
         * @param words: String (Text to display as part of a <direction-type> element).
         * @return XML representing the \<words\> element. Can be empty for missing/invalid input.
         */
        protected static function buildWords(words:String):XML {
            const $words:String = Strings.trim(words || '');
            if (!$words) {
                trace("Invalid words: [" + $words + "]");
                return null;
            }
            return <words>{$words}</words>;
        }

        // -----------------------------
        // (ii) INTERMEDIATE NODE BUILDERS
        // -----------------------------

        /**
         * Builds the \<key\> element.
         * @param fifths: String (Number of fifths in the key signature)
         * @param mode: String (The mode of the key signature, e.g., "major" or "minor")
         * @return XML representing the \<key\> element. Can be empty for missing/invalid input.
         */
        protected static function buildKey(fifths:String, mode:String):XML {
            var key:XML = <key/>;

            key.appendChild(buildFifths(fifths));
            key.appendChild(buildMode(mode));

            return key;
        }

        /**
         * Builds the \<time\> element.
         * @param beats: String (The number of beats in a measure)
         * @param beatType: String (The note value that receives the beat, e.g., "4")
         * @return XML representing the \<time\> element. Can be empty for missing/invalid input.
         */
        protected static function buildTime(beats:String, beatType:String):XML {
            var time:XML = <time/>;

            time.appendChild(buildBeats(beats));
            time.appendChild(buildBeatType(beatType));

            return time;
        }

        /**
         * Builds the \<clef\> element.
         * @param sign: String (The clef sign, e.g., "G", "F", "C", "percussion", "none")
         * @param line: String (The clef line number, e.g., "1", "2", "3", etc.)
         * @return XML representing the \<clef\> element. Can be empty for missing/invalid input.
         */
        protected static function buildClef(sign:String, line:String):XML {
            var clef:XML = <clef/>;

            clef.appendChild(buildSign(sign));
            clef.appendChild(buildLine(line));

            return clef;
        }

        /**
         * Builds the \<note\> element.
         * @param noteData - a Note instance.
         *
         * @return XML representing the \<note\> element. Can be empty for missing/invalid input.
         */
        protected static function buildNote(noteData:Note):XML {
            if (!noteData) {
                trace("Invalid note data: [" + noteData + "]");
                return null;
            }

            const note:XML = <note/>;

            const $pitch:Pitch = noteData.pitch;
            if ($pitch) {
                if (noteData.inChord) {
                    note.appendChild(<chord/>);
                }
                note.appendChild(buildPitch($pitch.step, $pitch.octave, $pitch.alteration));
            }
            else {
                note.appendChild(<rest/>);
            }

            note.appendChild(buildDuration(noteData.duration));
            note.appendChild(<voice>{noteData.voice || "1"}</voice>);
            note.appendChild(buildType(noteData.type));

            for (var i:int = 0; i < noteData.numDots; i++) {
                note.appendChild(buildDot());
            }
            if (noteData.tie) {
                note.appendChild(buildTie(noteData.tie));
            }
            if (noteData.accidental) {
                note.appendChild(buildAccidental(noteData.accidental));
            }

            return note;
        }

        /**
         * Builds the \<attributes\> element.
         * @param aData An Attributes instance.
         *
         * @return XML representing the \<attributes\> element.
         */
        protected static function buildAttributes(aData:Attributes):XML {
            var attributes:XML = <attributes/>;
            attributes.appendChild(buildDivisions(aData.divisions));
            attributes.appendChild(buildKey(aData.fifths, aData.mode));
            attributes.appendChild(buildTime(aData.beats, aData.beatType));
            attributes.appendChild(buildClef(aData.sign, aData.line));
            return attributes;
        }

        /**
         * Builds the \<metronome\> element.
         * @param beatUnit: String (The type of the beat unit, e.g., "quarter")
         * @param perMinute: String (How many beat units to play in a minute, e.g., "120")
         * @return XML representing the \<metronome\> element.
         */
        protected static function buildMetronome(beatUnit:String, perMinute:String):XML {
            var metronome:XML = <metronome/>;
            metronome.appendChild(buildBeatUnit(beatUnit));
            metronome.appendChild(buildPerMinute(perMinute));
            return metronome;
        }

        /**
         * Builds the \<direction-type\> element.
         * @param payload: XML (The payload of the direction-type element, e.g., a <metronome> or `words` element).
         * @return XML representing the \<direction-type\> element.
         */
        protected static function buildDirectionType(payload:XML):XML {
            var directionType:XML = <direction-type/>;
            if (!payload) {
                trace("Invalid direction type payload: [" + payload + "]");
                return null;
            }

            directionType.appendChild(payload);
            return directionType;
        }

        /**
         * Builds the \<direction\> element.
         * @param placement: String (Optional, "above" or "below", default "above")
         * @param words: Vector of XML (Optional. Each XML element represents a <words> element packed in a \<direction-type\> element)
         * @param metronome: XML (Optional. A \<metronome\> element packed in a \<direction-type\> element).
         *
         * Notes:
         * - only \<metronome\> or \<words\> XML \<direction-type\> elements are supported for the time being
         * - you must provide at least one of `metronome` or `words` to create a \<direction\> element.
         *
         * @return XML representing the \<direction\> element. Can be empty for missing/invalid input.
         */
        protected static function buildDirection(placement:String, words:Vector.<XML>, metronome:XML):XML {
            if (!metronome && !words) {
                trace("Invalid direction: [" + placement + ", " + words + ", " + metronome + "]");
                return null;
            }

            var direction:XML = <direction/>;
            const $placement:String = Strings.trim(placement || '');
            if ($placement && ["above", "below"].includes($placement)) {
                direction.@placement = placement;
            }
            else {
                direction.@placement = "above";
            }

            if (metronome) {
                direction.appendChild(buildDirectionType(metronome));
                direction.appendChild(<sound tempo={metronome["per-minute"]}/>);
            }
            if (words && words.length > 0) {
                for each (var wordsEl:XML in words) {
                    direction.appendChild(buildDirectionType(wordsEl));
                }
            }

            return direction;
        }

        /**
         * Builds the \<measure\> element.
         * @param number: String (The measure number)
         * @param notes: Vector of Note objects (Each object represents a note)
         * @param attributes: Attributes object (Optional, the attributes for the measure)
         * @param direction: Direction object (Optional, the direction (additional indications, such as tempo, for the measure)
         * @return XML representing the \<measure\> element. Can be empty for missing/invalid input.
         */
        protected static function buildMeasure(
                number:String, notes:Vector.<Note>,
                attributes:Attributes = null, direction:Direction = null
            ):XML {

            if (!number || !notes || notes.length == 0) {
                trace("Invalid measure: [" + number + ", " + notes + "]");
                return null;
            }

            var measure:XML = <measure number={number}/>;

            if (direction) {
                var $words:Vector.<XML> = null;
                if (direction.textLines) {
                    $words = new Vector.<XML>();
                    for each (var textLine:String in direction.textLines) {
                        $words.push(buildWords(textLine));
                    }
                }

                var $metronome:XML = null;
                if (direction.beatUnit && direction.perMinute) {
                    $metronome = buildMetronome(direction.beatUnit, direction.perMinute);
                }

                measure.appendChild(buildDirection(direction.placement, $words, $metronome));
            }

            if (attributes) {
                measure.appendChild(buildAttributes(attributes));
            }

            for each (var noteData:Note in notes) {
                measure.appendChild(buildNote(noteData));
            }

            return measure;
        }

        // -----------------------------
        // (iii) ROOT NODE BUILDER
        // -----------------------------

        /**
         * Builds the \<part\> element, which contains all measures for an instrument.
         * @param pcData A Part instance.
         *
         * @return XML representing the \<part\> element.
         */
        protected static function buildPart(pcData:PartContent):XML {
            var part:XML = <part id={pcData.partId}/>;

            for (var i:int = 0; i < pcData.partMeasures.length; i++) {
                var measureData:Measure = pcData.partMeasures[i];
                part.appendChild(buildMeasure(
                            (i + 1).toString(),
                            measureData.notes, measureData.attributes,
                            measureData.direction
                        ));
            }

            return part;
        }

        /**
         * Builds the entire musical content (all parts).
         * @param parts A Vector of PartContent instances.
         * @return XML representing all \<part\> elements.
         */
        public static function buildActualMusic(parts:Vector.<PartContent>):XMLList {
            var $parts:XMLList = new XMLList();

            for each (var partData:PartContent in parts) {
                $parts += buildPart(partData);
            }

            return $parts;
        }

        // =====================
        // V. FULL DOCUMENT
        // =====================

        /**
         * Builds the full MusicXML document as a <score-partwise> element.
         * @param scoreData A Score instance.
         * @return XML representing the entire MusicXML document.
         */
        public static function buildScore(scoreData:Score):XML {
            var score:XML = <score-partwise/>;

            addExtraMusicalContent(score, scoreData.title, scoreData.identification);

            score.appendChild(buildPresentationDefaults(scoreData.width, scoreData.height,
                        scoreData.margins, scoreData.scaling));

            score.appendChild(buildMusicalContext(scoreData.partsInfo, scoreData.groupsInfo));

            score.appendChild(buildActualMusic(scoreData.partsContent));

            return score;
        }
    }
}
