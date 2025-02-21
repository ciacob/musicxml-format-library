package eu.claudius.iacob.music.builders {
    import ro.ciacob.utils.Strings;
    import eu.claudius.iacob.music.wrappers.Misc;
    import eu.claudius.iacob.music.wrappers.Creator;
    import eu.claudius.iacob.music.wrappers.Identification;
    import eu.claudius.iacob.music.wrappers.PageMargins;
    import eu.claudius.iacob.music.wrappers.Scaling;

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
         * Builds the <work-title> element.
         * @param title: String (The title of the score)
         * @return XML representing the <work-title> element or null for an empty title.
         */
        protected static function buildWorkTitle(title:String):XML {
            const $title:String = Strings.trim(title || '');
            return $title ? <work-title>{$title}</work-title>             : null;
        }

        /**
         * Builds the <creator> element.
         * @param type: String (The type of creator, e.g., "composer")
         * @param name: String (The name of the creator)
         * @return XML representing the <creator> element or null for empty type or name.
         */
        protected static function buildCreator(type:String, name:String):XML {
            const $type:String = Strings.trim(type || '');
            const $name:String = Strings.trim(name || '');
            return ($type && $name) ? <creator type={$type}>{$name}</creator>             : null;
        }

        /**
         * Builds the <encoder> element.
         * @param encoder: String (The name/version of the software that encoded the file)
         * @return XML representing the <encoder> element, or null for an empty encoder.
         */
        protected static function buildEncoder(encoder:String):XML {
            const $encoder:String = Strings.trim(encoder || '');
            return $encoder ? <encoder>{$encoder}</encoder>             : null;
        }

        /**
         * Builds the <encoding-date> element.
         * @param encodingDate: String (The date when the file was encoded, e.g., "YYYY-MM-DD")
         * @return XML representing the <encoding-date> element, or null for an empty date.
         */
        protected static function buildEncodingDate(encodingDate:String):XML {
            const $date:String = Strings.trim(encodingDate || '');
            return $date ? <encoding-date>{$date}</encoding-date>             : null;
        }

        /**
         * Builds a <miscellaneous-field> element.
         * @param miscName: String (The name of the miscellaneous field, e.g., "history", "notes")
         * @param miscVal: String (The textual content of the field)
         * @return XML representing a <miscellaneous-field> element, or null for empty name or value.
         */
        protected static function buildMiscellaneousField(miscName:String, miscVal:String):XML {
            const $name:String = Strings.trim(miscName || '');
            const $value:String = Strings.trim(miscVal || '');
            return ($name && $value) ?
                <miscellaneous-field name={$name}>{$value}</miscellaneous-field>             : null;
        }

        // --------------------------------
        // (ii) INTERMEDIATE NODE BUILDERS
        // --------------------------------

        /**
         * Builds the <work> element containing <work-title>.
         * @param workTitle String (The title of the score)
         * @return XML representing the <work> element. Can be empty if the title is empty.
         */
        protected static function buildWork(workTitle:String):XML {
            var work:XML = <work/>;
            work.appendChild(buildWorkTitle(workTitle));
            return work;
        }

        /**
         * Builds the <encoding> element containing <encoder> and <encoding-date>.
         * @param encoder: String (The name/version of the encoding software).
         * @param encodingDate: String (The encoding date).
         * @return  XML representing the <encoding> element. Can be empty if both
         *          encoder and date are empty.
         */
        protected static function buildEncoding(encoder:String, encodingDate:String):XML {
            var encoding:XML = <encoding/>;
            encoding.appendChild(buildEncoder(encoder));
            encoding.appendChild(buildEncodingDate(encodingDate));
            return encoding;
        }

        /**
         * Builds the <miscellaneous> element containing multiple <miscellaneous-field> elements.
         * @param miscElements: Vector of `Misc` objects, each containing:
         *       - fieldName: String (The name of the field, e.g., "history", "notes")
         *       - fieldValue: String (The textual content of the field)
         * @return XML representing the <miscellaneous> element. Can be empty if no fields are provided.
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
         * Builds the <identification> element containing <creator>, <encoding>, and <miscellaneous>.
         * @param data An object containing:
         *   - creators: Vector of `Creator` objects, each containing:
         *      - creatorType: String (The type of creator, e.g., "composer")
         *      - creatorName: String (The name of the creator)
         
         *   - encoder: String (The encoding software name/version)
         *   - encodingDate: String (The encoding date)
         *
         *   - miscFields: Vector of `Misc` objects, each containing:
         *      - fieldName: String (The name of the field, e.g., "history", "notes")
         *      - fieldValue: String (The textual content of the field)
         * @return XML representing the <identification> element.
         */
        protected static function buildIdentification(data:Identification):XML {
            var identification:XML = <identification/>;

            // Add creators (composer, lyricist, etc.)
            if (data.creators && data.creators.length > 0) {
                for each (var creator:Creator in data.creators) {
                    identification.appendChild(
                            buildCreator(creator.creatorType, creator.creatorName));
                }
            }

            // Add encoding information
            identification.appendChild(buildEncoding(data.encoder, data.encodingDate));

            // Add miscellaneous metadata (history, notes, etc.)
            if (data.miscFields && data.miscFields.length > 0) {
                identification.appendChild(buildMiscellaneous(data.miscFields));
            }

            return identification;
        }

        // -----------------------------
        // (iii) ROOT NODE BUILDER
        // -----------------------------

        /**
         * Builds the entire "Extra-Musical Context" section as XML.
         * @param title: String (The title of the score)
         * @param identification: Identification object containing:
         * - creators: Vector of `Creator` objects, each containing:
         *   - creatorType: String (The type of creator, e.g., "composer")
         *   - creatorName: String (The name of the creator)
         *
         * - encoder: String (The encoding software name/version)
         * - encodingDate: String (The encoding date)
         *
         * - miscFields: Vector of `Misc` objects, each containing:
         *   - fieldName: String (The name of the field, e.g., "history", "notes")
         *   - fieldValue: String (The textual content of the field)
         
         * @return XML representing the <extra-musical-context> section.
         */
        public static function buildExtraMusicalContent(data:Object):XML {
            var extraMusical:XML = <extra-musical-context/>;

            // Add work information
            extraMusical.appendChild(buildWork(data.title));

            // Add identification (creator, encoding, and miscellaneous fields)
            extraMusical.appendChild(buildIdentification(data.identification));

            return extraMusical;
        }

        // =============================
        // PRESENTATION DEFAULTS
        // =============================

        // -----------------------------
        // (i) LEAF NODE BUILDERS
        // -----------------------------

        /**
         * Builds the <scaling> element.
         * @param millimeters: String (Real-world size of a "tenths" unit, e.g., 6.7744)
         * @param tenths: String (Relative unit size in MusicXML, e.g., 40)
         * @return  XML representing the <scaling> element. Can be empty if both values
         *          are empty.
         */
        protected static function buildScaling(millimeters:String, tenths:String):XML {
            const $millimeters:String = Strings.trim(millimeters || '');
            const $tenths:String = Strings.trim(tenths || '');
            const scaling:XML = <scaling/>;
            if ($millimeters) {
                scaling.appendChild(<millimeters>{$millimeters}</millimeters>);
            }
            if ($tenths) {
                scaling.appendChild(<tenths>{$tenths}</tenths>);
            }
            return scaling;
        }

        /**
         * Builds the <page-layout> element (without margins).
         * @param width:String (Width of the page in millimeters, e.g., 1239.96)
         * @param height: Number (Height of the page in millimeters, e.g., 1753.66)
         * @return  XML representing the <page-layout> element (without margins).
         *          Can be empty if both width and height are empty.
         */
        protected static function buildPageLayout(width:String, height:String):XML {
            const pageLayout:XML = <page-layout />;
            const $width:String = Strings.trim(width || '');
            const $height:String = Strings.trim(height || '');
            if ($width && $height) {
                pageLayout.appendChild(<page-width>{$width}</page-width>);
                pageLayout.appendChild(<page-height>{$height}</page-height>);
            }
            return pageLayout;
        }

        /**
         * Builds the <page-margins> element.
         * @param left: String (Margin on the left, e.g., 59.0458)
         * @param right: String (Margin on the right, e.g., 59.0458)
         * @param top: String (Margin on the top, e.g., 206.66)
         * @param bottom: String (Margin at the bottom, e.g., 59.0458)
         * @param type: String (Optional: "both", "odd", "even" to indicate page type)
         * @return  XML representing the <page-margins> element. Can be empty if
         *          any of the margins are empty.
         */
        protected static function buildPageMargins(
                left:String,
                right:String,
                top:String,
                bottom:String,
                type:String = null
            ):XML {
            const pageMargins:XML = <page-margins/>;

            const $left:String = Strings.trim(left || '');
            const $right:String = Strings.trim(right || '');
            const $top:String = Strings.trim(top || '');
            const $bottom:String = Strings.trim(bottom || '');
            if ($left && $right && $top && $bottom) {
                pageMargins.appendChild(<left-margin>{$left}</left-margin>);
                pageMargins.appendChild(<right-margin>{$right}</right-margin>);
                pageMargins.appendChild(<top-margin>{$top}</top-margin>);
                pageMargins.appendChild(<bottom-margin>{$bottom}</bottom-margin>);
                if (type && (type == "both" || type == "odd" || type == "even")) {
                    pageMargins.@type = type;
                }
            }
            return pageMargins;
        }

        // --------------------------------
        // (ii) INTERMEDIATE NODE BUILDERS
        // --------------------------------

        /**
         * Builds the <page-layout> element, including <page-margins>.
         * @param width:String (Width of the page in millimeters, e.g., 1239.96)
         * @param height: Number (Height of the page in millimeters, e.g., 1753.66)
         * @param margins: PageMargins object containing:
         *  - left: String (Margin on the left, e.g., 59.0458)
         * - right: String (Margin on the right, e.g., 59.0458)
         * - top: String (Margin on the top, e.g., 206.66)
         * - bottom: String (Margin at the bottom, e.g., 59.0458)
         * - type: String (Optional: "both", "odd", "even" to indicate page type)
         * @return XML representing the <page-layout> element.
         */
        protected static function buildFullPageLayout(width:String, height:String,
                margins:PageMargins):XML {
            const pageLayout:XML = buildPageLayout(width, height);

            pageLayout.appendChild(buildPageMargins(margins.left, margins.right,
                        margins.top, margins.bottom, margins.type));

            return pageLayout;
        }

        // -----------------------------
        // (iii) ROOT NODE BUILDER
        // -----------------------------

        /**
         * Builds the entire <defaults> section, which contains <scaling> and <page-layout>.
         * @param width : String (Width of the page in millimeters, e.g., 1239.96)
         * @param height: String (Height of the page in millimeters, e.g., 1753.66)
         * 
         * @param margins: PageMargins object containing:
         * - left: String (Margin on the left, e.g., 59.0458)
         * - right: String (Margin on the right, e.g., 59.0458)
         * - top: String (Margin on the top, e.g., 206.66)
         * - bottom: String (Margin at the bottom, e.g., 59.0458)
         * - type: String (Optional: "both", "odd", "even" to indicate page type)
         * 
         * @param scaling: Scaling object containing:
         * - millimeters: String (Real-world size of a "tenths" unit, e.g., 6.7744)
         * - tenths: String (Relative unit size in MusicXML, e.g., 40)
         * 
         * @return XML representing the entire <defaults> section.
         */
        public static function buildPresentationDefaults(width:String, height:String,
                margins:PageMargins, scaling:Scaling):XML {
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
         * Builds a <part-group> element (either start or stop).
         * @param data An object containing:
         *   - id: String (The unique identifier for the group)
         *   - type: String ("start" or "stop")
         *   - symbol: String (Optional, visual representation, e.g., "bracket")
         *   - barlines: Boolean (Optional, whether barlines span across all staves)
         * @return XML representing a <part-group> element.
         */
        protected static function buildPartGroup(data:Object):XML {
            var partGroup:XML = <part-group number={data.id} type={data.type}/>;

            if (data.type == "start") {
                if (data.symbol) {
                    partGroup.appendChild(<group-symbol>{data.symbol}</group-symbol>);
                }
                if (data.barlines) {
                    partGroup.appendChild(<group-barline>yes</group-barline>);
                }
            }

            return partGroup;
        }

        /**
         * Builds a <score-part> element.
         * @param data An object containing:
         *   - id: String (The unique identifier for the part)
         *   - name: String (The full instrument name)
         *   - abbreviation: String (The short instrument name)
         *   - group: String (Optional, the group ID to which this part belongs)
         *   - midi_channel: Number (MIDI playback channel)
         *   - midi_program: Number (MIDI instrument patch number)
         * @return XML representing a <score-part> element.
         */
        protected static function buildScorePart(data:Object):XML {
            var scorePart:XML = <score-part id={data.id}/>;

            scorePart.appendChild(<part-name>{data.name}</part-name>);
            scorePart.appendChild(<part-abbreviation>{data.abbreviation}</part-abbreviation>);
            scorePart.appendChild(<score-instrument id={data.id + "-inst"}/>);

            var midiInstrument:XML = <midi-instrument id={data.id + "-inst"}>
                <midi-channel>{data.midi_channel}</midi-channel>
                <midi-program>{data.midi_program}</midi-program>
            </midi-instrument>;

            scorePart.appendChild(midiInstrument);

            return scorePart;
        }

        // -----------------------------
        // (ii) INTERMEDIATE NODE BUILDERS
        // -----------------------------

        /**
         * Builds the part groups for the score.
         * @param data An object containing:
         *   - groups: Array of Objects
         *       - id: String (The unique identifier for the group)
         *       - symbol: String (Visual representation, e.g., "bracket")
         *       - barlines: Boolean (Whether barlines span across all staves)
         * @return XMLList representing the <part-group> elements.
         */
        protected static function buildPartGroups(data:Object):XMLList {
            var partGroups:XMLList = new XMLList();

            for each (var group:Object in data.groups) {
                partGroups += buildPartGroup({id: group.id, type: "start", symbol: group.symbol, barlines: group.barlines});
                partGroups += buildPartGroup({id: group.id, type: "stop"});
            }

            return partGroups;
        }

        /**
         * Builds the score parts for the score.
         * @param data An object containing:
         *   - parts: Array of Objects
         *       - id: String (The unique identifier for the part)
         *       - name: String (The full instrument name)
         *       - abbreviation: String (The short instrument name)
         *       - group: String (Optional, the group ID to which this part belongs)
         *       - midi_channel: Number (MIDI playback channel)
         *       - midi_program: Number (MIDI instrument patch number)
         * @return XMLList representing the <score-part> elements.
         */
        protected static function buildScoreParts(data:Object):XMLList {
            var scoreParts:XMLList = new XMLList();

            for each (var part:Object in data.parts) {
                scoreParts += buildScorePart(part);
            }

            return scoreParts;
        }

        // -----------------------------
        // (iii) ROOT NODE BUILDER
        // -----------------------------

        /**
         * Builds the entire <part-list> section, correctly inserting <part-group> start/stop markers around grouped parts.
         * @param data An object containing:
         *   - groups: Array of Objects (Defines part groups)
         *       - id: String (The unique identifier for the group)
         *       - symbol: String (Visual representation, e.g., "bracket")
         *       - barlines: Boolean (Whether barlines span across all staves)
         *   - parts: Array of Objects (Defines score parts)
         *       - id: String (The unique identifier for the part)
         *       - name: String (The full instrument name)
         *       - abbreviation: String (The short instrument name)
         *       - group: String (Optional, the group ID to which this part belongs)
         *       - midi_channel: Number (MIDI playback channel)
         *       - midi_program: Number (MIDI instrument patch number)
         * @return XML representing the <part-list> section, with proper group handling.
         */
        public static function buildMusicalContext(data:Object):XML {
            var partList:XML = <part-list/>;

            // If no groups exist, just append all parts without any special handling
            if (!data.groups || data.groups.length == 0) {
                partList.appendChild(buildScoreParts({parts: data.parts}));
                return partList;
            }

            // Sort parts by group, preserving order of ungrouped parts
            data.parts.sort(function (a:Object, b:Object):int {
                    if (!a.group && !b.group)
                        return 0; // Both ungrouped, keep original placement
                    if (!a.group)
                        return 0; // a is ungrouped, keep original placement
                    if (!b.group)
                        return 0; // b is ungrouped, keep original placement
                    return a.group.localeCompare(b.group); // Sort grouped parts together
                });

            // Track group states
            var groupStates:Object = {}; // { "groupID": "started" or "stopped" }
            var currentGroupID:String = null;

            // Loop through parts and handle grouping logic
            for each (var part:Object in data.parts) {
                if (part.group) {
                    // If this part belongs to a group
                    if (currentGroupID !== part.group) {
                        // If switching to a new group
                        if (currentGroupID) {
                            // If a group was open, close it first
                            partList.appendChild(buildPartGroup({id: currentGroupID, type: "stop"}));
                            groupStates[currentGroupID] = "stopped";
                            currentGroupID = null;
                        }
                        if (!groupStates[part.group]) {
                            // Find the group definition by ID
                            var groupData:Object = data.groups.filter(function (g:Object, ...rest):Boolean {
                                    return g.id === part.group;
                                })[0];

                            if (groupData) {
                                // Start a new group
                                partList.appendChild(buildPartGroup({
                                                id: groupData.id,
                                                type: "start",
                                                symbol: groupData.symbol,
                                                barlines: groupData.barlines
                                            }));
                                groupStates[groupData.id] = "started";
                                currentGroupID = groupData.id;
                            }
                        }
                    }
                }

                // Append the part
                partList.appendChild(buildScorePart(part));
            }

            // Close any remaining open groups
            if (currentGroupID) {
                partList.appendChild(buildPartGroup({id: currentGroupID, type: "stop"}));
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
         * Builds the <pitch> element for a note.
         * @param data An object containing:
         *   - step: String (The note name, e.g., "A", "B", "C")
         *   - alter: Number (Optional, 1 = sharp, -1 = flat, 0 or omitted = natural)
         *   - octave: Number (Octave number)
         * @return XML representing the <pitch> element.
         */
        protected static function buildPitch(data:Object):XML {
            var pitch:XML = <pitch>
                <step>{data.step}</step>
                <octave>{data.octave}</octave>
            </pitch>;

            if (data.hasOwnProperty("alter")) {
                pitch.appendChild(<alter>{data.alter}</alter>);
            }

            return pitch;
        }

        /**
         * Builds the <duration> element.
         * @param data An object containing:
         *   - duration: Number (The note duration value, as a number of divisions)
         * @return XML representing the <duration> element.
         */
        protected static function buildDuration(data:Object):XML {
            return <duration>{data.duration}</duration>;
        }

        /**
         * Builds the <type> element.
         * @param data An object containing:
         *   - type: String ("whole", "half", "quarter", "eighth", etc.)
         * @return XML representing the <type> element.
         */
        protected static function buildType(data:Object):XML {
            return <type>{data.type}</type>;
        }

        /**
         * Builds the <tie> element.
         * @param data An object containing:
         *   - tie_type: String ("start" or "stop")
         * @return XML representing the <tie> element.
         */
        protected static function buildTie(data:Object):XML {
            return <tie type={data.tie_type}/>;
        }

        /**
         * Builds the <accidental> element.
         * @param data An object containing:
         *   - accidental: String ("sharp", "flat", "natural", etc.)
         * @return XML representing the <accidental> element.
         */
        protected static function buildAccidental(data:Object):XML {
            return <accidental>{data.accidental}</accidental>;
        }

        /**
         * Builds the <dot> element.
         * @return XML representing the <dot> element.
         */
        protected static function buildDot():XML {
            return <dot/>;
        }

        // -----------------------------
        // (ii) INTERMEDIATE NODE BUILDERS
        // -----------------------------

        /**
         * Builds the <note> element.
         * @param data An object containing:
         *   - pitch: Object (Optional, contains step, alter, octave)
         *   - duration: Number (The note duration value)
         *   - voice: Number (The polyphony layer)
         *   - type: String ("whole", "half", "quarter", "eighth", etc.)
         *   - tie: String (Optional, "start" or "stop")
         *   - accidental: String (Optional, "sharp", "flat", etc.)
         *   - dot: Boolean (Optional, true if dotted note)
         * @return XML representing the <note> element.
         */
        protected static function buildNote(data:Object):XML {
            var note:XML = <note/>;

            if (data.pitch) {
                note.appendChild(buildPitch(data.pitch));
            }
            else {
                note.appendChild(<rest/>);
            }

            note.appendChild(buildDuration({duration: data.duration}));
            note.appendChild(<voice>{data.voice}</voice>);
            note.appendChild(buildType({type: data.type}));

            if (data.dot) {
                note.appendChild(buildDot());
            }
            if (data.tie) {
                note.appendChild(buildTie({tie_type: data.tie}));
            }
            if (data.accidental) {
                note.appendChild(buildAccidental({accidental: data.accidental}));
            }

            return note;
        }

        /**
         * Builds the <attributes> element.
         * @param data An object containing:
         *   - divisions: Number (Rhythmic granularity of the quarter note)
         *   - key: Object (Contains fifths and mode)
         *   - time: Object (Contains beats and beat-type)
         *   - clef: Object (Contains sign and line)
         * @return XML representing the <attributes> element.
         */
        protected static function buildAttributes(data:Object):XML {
            var attributes:XML = <attributes>
                <divisions>{data.divisions}</divisions>
                <key>
                    <fifths>{data.key.fifths}</fifths>
                    <mode>{data.key.mode}</mode>
                </key>
                <time>
                    <beats>{data.time.beats}</beats>
                    <beat-type>{data.time.beat_type}</beat-type>
                </time>
                <clef>
                    <sign>{data.clef.sign}</sign>
                    <line>{data.clef.line}</line>
                </clef>
            </attributes>;

            return attributes;
        }

        /**
         * Builds a <measure> element.
         * @param data An object containing:
         *   - number: Number (The measure number)
         *   - attributes: Object (Optional, contains divisions, key, time, clef)
         *   - directions: Array of Objects (Optional, contains tempo/metronome markings)
         *   - notes: Array of Objects (Contains musical notes)
         * @return XML representing the <measure> element.
         */
        protected static function buildMeasure(data:Object):XML {
            var measure:XML = <measure number={data.number}/>;

            if (data.attributes) {
                measure.appendChild(buildAttributes(data.attributes));
            }

            for each (var noteData:Object in data.notes) {
                measure.appendChild(buildNote(noteData));
            }

            return measure;
        }

        // -----------------------------
        // (iii) ROOT NODE BUILDER
        // -----------------------------

        /**
         * Builds the <part> element, which contains all measures for an instrument.
         * @param data An object containing:
         *   - id: String (The part identifier)
         *   - measures: Array of Objects (Each object represents a measure)
         * @return XML representing the <part> element.
         */
        protected static function buildPart(data:Object):XML {
            var part:XML = <part id={data.id}/>;

            for each (var measureData:Object in data.measures) {
                part.appendChild(buildMeasure(measureData));
            }

            return part;
        }

        /**
         * Builds the entire musical content (all parts).
         * @param data An object containing:
         *   - parts: Array of Objects (Each object represents a part)
         * @return XML representing all <part> elements.
         */
        public static function buildActualMusic(data:Object):XMLList {
            var parts:XMLList = new XMLList();

            for each (var partData:Object in data.parts) {
                parts += buildPart(partData);
            }

            return parts;
        }

        // =====================
        // V. FULL DOCUMENT
        // =====================

        /**
         * Builds the full MusicXML document as a <score-partwise> element.
         * @param data An object containing:
         *   - extraMusical: Object (Metadata such as title, composer, encoding info)
         *   - presentation: Object (Page layout, scaling, margins)
         *   - musicalContext: Object (Part groups and score parts)
         *   - actualMusic: Object (The actual musical content)
         * @return XML representing the entire MusicXML document.
         */
        public static function buildScore(data:Object):XML {
            var score:XML = <score-partwise/>;

            // Attach extra-musical information
            score.appendChild(buildExtraMusicalContent(data.extraMusical));

            // Attach presentation defaults
            score.appendChild(buildPresentationDefaults(data.presentation));

            // Attach musical context (part-list)
            score.appendChild(buildMusicalContext(data.musicalContext));

            // Attach actual music (parts and measures)
            score.appendChild(buildActualMusic(data.actualMusic));

            return score;
        }
    }
}
