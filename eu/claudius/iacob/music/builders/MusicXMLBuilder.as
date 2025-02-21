package eu.claudius.iacob.music.builders {
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
         * @param data An object containing:
         *   - title: String (The title of the score)
         * @return XML representing the <work-title> element.
         */
        protected static function buildWorkTitle(data:Object):XML {
            return <work-title>{data.title}</work-title>;
        }

        /**
         * Builds the <creator> element.
         * @param data An object containing:
         *   - type: String (The type of creator, e.g., "composer")
         *   - name: String (The name of the creator)
         * @return XML representing the <creator> element.
         */
        protected static function buildCreator(data:Object):XML {
            return <creator type={data.type}>{data.name}</creator>;
        }

        /**
         * Builds the <encoder> element.
         * @param data An object containing:
         *   - encoder: String (The name/version of the software that encoded the file)
         * @return XML representing the <encoder> element.
         */
        protected static function buildEncoder(data:Object):XML {
            return <encoder>{data.encoder}</encoder>;
        }

        /**
         * Builds the <encoding-date> element.
         * @param data An object containing:
         *   - encoding_date: String (The date when the file was encoded, e.g., "YYYY-MM-DD")
         * @return XML representing the <encoding-date> element.
         */
        protected static function buildEncodingDate(data:Object):XML {
            return <encoding-date>{data.encoding_date}</encoding-date>;
        }

        /**
         * Builds a <miscellaneous-field> element.
         * @param data An object containing:
         *   - name: String (The name of the miscellaneous field, e.g., "history", "notes")
         *   - value: String (The textual content of the field)
         * @return XML representing a <miscellaneous-field> element.
         */
        protected static function buildMiscellaneousField(data:Object):XML {
            return <miscellaneous-field name={data.name}>{data.value}</miscellaneous-field>;
        }

        // --------------------------------
        // (ii) INTERMEDIATE NODE BUILDERS
        // --------------------------------

        /**
         * Builds the <work> element containing <work-title>.
         * @param data An object containing:
         *   - work: Object
         *       - title: String (The title of the score)
         * @return XML representing the <work> element.
         */
        protected static function buildWork(data:Object):XML {
            var work:XML = <work/>;
            work.appendChild(buildWorkTitle({title: data.work.title}));
            return work;
        }

        /**
         * Builds the <encoding> element containing <encoder> and <encoding-date>.
         * @param data An object containing:
         *   - encoder: String (The name/version of the encoding software)
         *   - encoding_date: String (The encoding date)
         * @return XML representing the <encoding> element.
         */
        protected static function buildEncoding(data:Object):XML {
            var encoding:XML = <encoding/>;
            encoding.appendChild(buildEncoder({encoder: data.encoder}));
            encoding.appendChild(buildEncodingDate({encoding_date: data.encoding_date}));
            return encoding;
        }

        /**
         * Builds the <miscellaneous> element containing multiple <miscellaneous-field> elements.
         * @param data An object containing:
         *   - miscellaneous_fields: Array of Objects
         *       - name: String (The name of the field, e.g., "history", "notes")
         *       - value: String (The textual content of the field)
         * @return XML representing the <miscellaneous> element.
         */
        protected static function buildMiscellaneous(data:Object):XML {
            var miscellaneous:XML = <miscellaneous/>;

            for each (var field:Object in data.miscellaneous_fields) {
                miscellaneous.appendChild(buildMiscellaneousField(field));
            }

            return miscellaneous;
        }

        /**
         * Builds the <identification> element containing <creator>, <encoding>, and <miscellaneous>.
         * @param data An object containing:
         *   - creator: Object
         *       - name: String (The name of the composer)
         *   - encoder: String (The encoding software name/version)
         *   - encoding_date: String (The encoding date)
         *   - miscellaneous_fields: Array of Objects
         *       - name: String (Field name, e.g., "history", "notes")
         *       - value: String (Field content)
         * @return XML representing the <identification> element.
         */
        protected static function buildIdentification(data:Object):XML {
            var identification:XML = <identification/>;

            // Add composer (creator)
            identification.appendChild(buildCreator({type: "composer", name: data.creator.name}));

            // Add encoding information
            identification.appendChild(buildEncoding({encoder: data.encoder, encoding_date: data.encoding_date}));

            // Add miscellaneous metadata (history, notes, etc.)
            if (data.miscellaneous_fields.length > 0) {
                identification.appendChild(buildMiscellaneous({miscellaneous_fields: data.miscellaneous_fields}));
            }

            return identification;
        }

        // -----------------------------
        // (iii) ROOT NODE BUILDER
        // -----------------------------

        /**
         * Builds the entire "Extra-Musical Context" section as XML.
         * @param data An object containing:
         *   - work: Object
         *       - title: String (The title of the score)
         *   - creator: Object
         *       - name: String (The name of the composer)
         *   - encoder: String (The encoding software name/version)
         *   - encoding_date: String (The encoding date)
         *   - miscellaneous_fields: Array of Objects
         *       - name: String (Field name, e.g., "history", "notes")
         *       - value: String (Field content)
         * @return XML representing the <extra-musical-context> section.
         */
        public static function buildExtraMusicalContent(data:Object):XML {
            var extraMusical:XML = <extra-musical-context/>;

            // Add work information
            extraMusical.appendChild(buildWork({work: {title: data.work.title}}));

            // Add identification (creator, encoding, and miscellaneous fields)
            extraMusical.appendChild(buildIdentification({
                            creator: {name: data.creator.name},
                            encoder: data.encoder,
                            encoding_date: data.encoding_date,
                            miscellaneous_fields: data.miscellaneous_fields
                        }));

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
         * @param data An object containing:
         *   - millimeters: Number (Real-world size of a "tenths" unit, e.g., 6.7744)
         *   - tenths: Number (Relative unit size in MusicXML, e.g., 40)
         * @return XML representing the <scaling> element.
         */
        protected static function buildScaling(data:Object):XML {
            return <scaling>
                <millimeters>{data.millimeters}</millimeters>
                <tenths>{data.tenths}</tenths>
            </scaling>;
        }

        /**
         * Builds the <page-layout> element (without margins).
         * @param data An object containing:
         *   - page_height: Number (Height of the page in millimeters, e.g., 1753.66)
         *   - page_width: Number (Width of the page in millimeters, e.g., 1239.96)
         * @return XML representing the <page-layout> element (without margins).
         */
        protected static function buildPageLayout(data:Object):XML {
            var pageLayout:XML = <page-layout>
                <page-height>{data.page_height}</page-height>
                <page-width>{data.page_width}</page-width>
            </page-layout>;

            return pageLayout;
        }

        /**
         * Builds the <page-margins> element.
         * @param data An object containing:
         *   - left_margin: Number (Margin on the left, e.g., 59.0458)
         *   - right_margin: Number (Margin on the right, e.g., 59.0458)
         *   - top_margin: Number (Margin on the top, e.g., 206.66)
         *   - bottom_margin: Number (Margin at the bottom, e.g., 59.0458)
         *   - type: String (Optional: "both", "odd", or "even" to indicate page type)
         * @return XML representing the <page-margins> element.
         */
        protected static function buildPageMargins(data:Object):XML {
            var pageMargins:XML = <page-margins/>;

            // Add type attribute if provided
            if (data.type) {
                pageMargins.@type = data.type;
            }

            pageMargins.appendChild(<left-margin>{data.left_margin}</left-margin>);
            pageMargins.appendChild(<right-margin>{data.right_margin}</right-margin>);
            pageMargins.appendChild(<top-margin>{data.top_margin}</top-margin>);
            pageMargins.appendChild(<bottom-margin>{data.bottom_margin}</bottom-margin>);

            return pageMargins;
        }

        // --------------------------------
        // (ii) INTERMEDIATE NODE BUILDERS
        // --------------------------------

        /**
         * Builds the <page-layout> element, including <page-margins>.
         * @param data An object containing:
         *   - page_height: Number (Height of the page in millimeters)
         *   - page_width: Number (Width of the page in millimeters)
         *   - page_margins: Object
         *       - left_margin: Number (Margin on the left)
         *       - right_margin: Number (Margin on the right)
         *       - top_margin: Number (Margin on the top)
         *       - bottom_margin: Number (Margin at the bottom)
         *       - type: String (Optional: "both", "odd", "even")
         * @return XML representing the <page-layout> element.
         */
        protected static function buildFullPageLayout(data:Object):XML {
            var pageLayout:XML = buildPageLayout({page_height: data.page_height, page_width: data.page_width});

            if (data.page_margins) {
                pageLayout.appendChild(buildPageMargins(data.page_margins));
            }

            return pageLayout;
        }

        // -----------------------------
        // (iii) ROOT NODE BUILDER
        // -----------------------------

        /**
         * Builds the entire <defaults> section, which contains <scaling> and <page-layout>.
         * @param data An object containing:
         *   - scaling: Object
         *       - millimeters: Number (Scaling unit size)
         *       - tenths: Number (Relative unit size)
         *   - page_layout: Object
         *       - page_height: Number (Height of the page)
         *       - page_width: Number (Width of the page)
         *       - page_margins: Object
         *           - left_margin: Number (Margin on the left)
         *           - right_margin: Number (Margin on the right)
         *           - top_margin: Number (Margin on the top)
         *           - bottom_margin: Number (Margin at the bottom)
         *           - type: String (Optional: "both", "odd", "even")
         * @return XML representing the entire <defaults> section.
         */
        public static function buildPresentationDefaults(data:Object):XML {
            var defaults:XML = <defaults/>;

            // Add scaling
            defaults.appendChild(buildScaling(data.scaling));

            // Add full page layout including margins
            defaults.appendChild(buildFullPageLayout(data.page_layout));

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
