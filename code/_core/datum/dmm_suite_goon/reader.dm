dmm_suite

	/*-- read_map ------------------------------------
	Generates map instances based on provided DMM formatted text. If coordinates
	are provided, the map will start loading at those coordinates. Otherwise, any
	coordinates saved with the map will be used. Otherwise, coordinates will
	default to (1, 1, world.maxz+1)
	*/
	read_map(dmm_text as text, coordX as num, coordY as num, coordZ as num, tag as text, overwrite as num, angleOffset as num)
		. = 0
		if(angleOffset)
			angleOffset = MODULUS(round(angleOffset,90), 360)
		else
			angleOffset = 0
		// Split Key/Model list into lines
		var/key_len
		var/list/grid_models[0]
		var/startGridPos = findtext(dmm_text, "\n\n(1,1,") // Safe because \n not allowed in strings in dmm
		var/startData = findtext(dmm_text, "\"")
		var/linesText = copytext(dmm_text, startData + 1, startGridPos)
		var/list/modelLines = splittext(linesText, regex(@{"\n\""}))
		//Go through all the map keys and set them up properly.
		for(var/modelLine in modelLines) // "aa" = (/path{key = value; key = value},/path,/path)\n
			var/endQuote = findtext(modelLine, quote, 2, 0)
			if(endQuote <= 1)
				continue
			var/modelKey = copytext(modelLine, 1, endQuote)
			if(!key_len)
				key_len = length(modelKey)
			var/modelsStart = findtextEx(modelLine, "/") // Skip key and first three characters: "aa" = (
			var/modelContents = copytext(modelLine, modelsStart, length(modelLine)) // Skip last character: )
			grid_models[modelKey] = modelContents //We have now stored the key representing the turf.
			CHECK_TICK_HARD
		if(!coordX) coordX = 1
		if(!coordY) coordY = 1
		if(!coordZ) coordZ = world.maxz+1
		// Store quoted portions of text in text_strings, and replaces them with an index to that list.
		var/gridText = copytext(dmm_text, startGridPos)
		if(key_len < 1) CRASH("key_len was impossibly less than 1 ([key_len])!")
		var/maxXFound = 0
		var/maxYFound = 0
		var/maxZFound = 0
		//TGM AND DMM ARE NOT THE SAME IN TERMS OF (1,1,1) COORDS. GOD HELP ME.
		//Below 3 vars help with determining the format.
		/*
		var/tgm_format = TRUE
		var/last_x
		var/last_z
		*/
		var/list/gridLevels = list()
		var/list/coordShifts = list()
		var/regex/grid = regex(@{"\(([0-9]*),([0-9]*),([0-9]*)\) = \{"\n((?:[A-z]*\n)*)"\}"}, "g") //Retrieve the coord line thing.
		//Positioned Keys:             1        2        3                    4
		while(grid.Find(gridText))
			grid.group[1] = text2num(grid.group[1]) - 1
			grid.group[2] = text2num(grid.group[2]) - 1
			grid.group[3] = text2num(grid.group[3]) - 1
			gridLevels.Add(copytext(grid.group[4], 1, -1)) // Strip last \n.
			coordShifts.Add(
				list(
					list(grid.group[1], grid.group[2], grid.group[3])
				)
			)
			maxZFound = max(maxZFound, grid.group[3]+1)
			CHECK_TICK_HARD

		if(maxZFound+(coordZ-1) > world.maxz)
			world.maxz = maxZFound+(coordZ-1)
			log_debug("Z levels increased to [world.maxz].")

		var/debug_x = 0
		var/debug_y = 0
		var/debug_z = 0
		for(var/posZ=1,posZ<=length(gridLevels),posZ++)
			debug_z = max(debug_z,posZ)
			var/zGrid = reverseList(text2list(gridLevels[posZ], "\n"))

			maxXFound = max(length(pick(zGrid))/key_len,length(gridLevels))
			if(world.maxx < maxXFound+(coordX-1))
				world.maxx = maxXFound+(coordX-1)
				log_debug("X level increased to [world.maxx].")

			maxYFound = length(zGrid)
			if(world.maxy < maxYFound+(coordY-1))
				world.maxy = maxYFound+(coordY-1)
				log_debug("Y level increased to [world.maxy].")

			var/coord_shift_x = coordShifts[posZ][1]
			var/coord_shift_y = coordShifts[posZ][2]
			var/coord_shift_z = coordShifts[posZ][3]

			//posX and posY represent the location WITHIN THE DMM GRID SYSTEM and NOT the actual location
			for(var/posY=1,posY<=length(zGrid),posY++)
				var/y_line = zGrid[posY]
				debug_y = max(debug_y,posY)
				for(var/posX=1,posX<=length(y_line)/key_len,posX++)
					debug_x = max(debug_x,posX)

					var/offset_x = 0
					var/offset_y = 0
					var/offset_z = coord_shift_z

					switch(angleOffset)
						if(0)
							offset_x = posX + coord_shift_x
							offset_y = posY + coord_shift_y
						if(90)
							offset_x = posY + coord_shift_y
							offset_y = maxXFound - (posX + coord_shift_x) + 1
						if(180)
							offset_x = maxXFound - (posX + coord_shift_x) + 1
							offset_y = maxYFound - (posY + coord_shift_y) + 1
						if(270)
							offset_x = maxYFound - (posY + coord_shift_y) + 1
							offset_y = posX + coord_shift_x
						else
							log_error("WARNING: Incorrect angleOffset of [angleOffset]!")
							break

					var/keyPos = ((posX-1)*key_len)+1
					var/modelKey = copytext(y_line, keyPos, keyPos+key_len)

					var/loc_x = (coordX-1) + offset_x
					var/loc_y = (coordY-1) + offset_y
					var/loc_z = (coordZ) + offset_z


					var/turf/location = locate(
						loc_x,
						loc_y,
						loc_z
					)
					if(!location)
						CRASH("dmm_suite: Invalid location! ([loc_x],[loc_y],[loc_z])")
					var/result = parse_grid(
						grid_models[modelKey],
						location,
						angleOffset,
						overwrite

					)
					if(!result)
						log_error("Could not parse modelKey \"[html_encode(modelKey)]\" in coords ([posX],[posY],[posZ])!\nLine: \"[y_line]\"")
						break
					else
						. += result
					CHECK_TICK_HARD

		return .

//-- Supplemental Methods ------------------------------------------------------

	var
		quote = "\""
		regex/comma_delim = new("\[\\s\\r\\n\]*,\[\\s\\r\\n\]*")
		regex/semicolon_delim = new("\[\\s\\r\\n\]*;\[\\s\\r\\n\]*")
		regex/key_value_regex = new("^\[\\s\\r\\n\]*(\[^=\]*?)\[\\s\\r\\n\]*=\[\\s\\r\\n\]*(.*?)\[\\s\\r\\n\]*$")

	proc
		parse_grid(models as text, var/turf/location, angleOffset, overwrite, debug)
			if(debug)
				log_debug("Parsing grid: \"[models]\" at [location ? location.get_debug_name() : "NULL"]")
			. = 0
			/* Method parse_grid() - Accepts a text string containing a comma separated list
				of type paths of the same construction as those contained in a .dmm file, and
				instantiates them.*/
			// Store quoted portions of text in text_strings, and replace them with an index to that list.
			var/list/originalStrings = list()
			var/regex/noStrings = regex("(\[\"\])(?:(?=(\\\\?))\\2(.|\\n))*?\\1")
			var/stringIndex = 1
			var/found
			do
				found = noStrings.Find(models, noStrings.next)
				if(found)
					var/indexText = {""[stringIndex]""}
					stringIndex++
					var/match = copytext(noStrings.match, 2, -1) // Strip quotes
					models = noStrings.Replace(models, indexText, found)
					originalStrings[indexText] = (match)
				CHECK_TICK_HARD
			while(found)
			// Identify each object's data, instantiate it, & reconstitues its fields.
			for(var/atomModel in splittext(models, comma_delim))
				var/bracketPos = findtext(atomModel, "{")
				var/atomPath = text2path(copytext(atomModel, 1, bracketPos))
				var/list/attributes
				if(bracketPos)
					attributes = new()
					var/attributesText = copytext(atomModel, bracketPos+1, -1)
					var/list/paddedAttributes = splittext(attributesText, semicolon_delim) // "Key = Value"
					for(var/paddedAttribute in paddedAttributes)
						key_value_regex.Find(paddedAttribute)
						attributes[key_value_regex.group[1]] = key_value_regex.group[2]
				. += loadModel(atomPath, attributes, originalStrings, location, angleOffset, debug)
				CHECK_TICK_HARD

		loadModel(atomPath, list/attributes, list/strings, var/turf/location, angleOffset, debug)
			if(!atomPath) //Sometimes dmm_suite can have invalid models.
				if(debug) log_debug("Invalid/null atomPath!")
				return 0
			// Cancel if atomPath is a placeholder (DMM_IGNORE flags used to write file)
			if(atomPath == /turf/dmm_suite/clear_turf || atomPath == /area/dmm_suite/clear_area)
				if(debug) log_debug("Canceling due to clear area/turf...")
				return 1
			// Parse all attributes and create preloader
			if(!location)
				CRASH("Invalid loadModel location!")
				return 0
			var/list/attributesMirror = list()
			for(var/attributeName in attributes)
				attributesMirror[attributeName] = loadAttribute(attributes[attributeName], strings)
			// Begin Instanciation
			// Handle Areas (not created every time)
			var/atom/instance
			if(ispathcache(atomPath, /area)) //Don't set instances for areas.
				if(ispathcache(atomPath,/area/shuttle))
					location.transit_area = location.loc.type //Old area type.
				new atomPath(location)
				location.dmm_preloader = null
				return 1
			var/dmm_suite/preloader/preloader = new(location, attributesMirror)
			// Handle Underlay Turfs
			if(ispathcache(atomPath, /turf))
				if(atomPath == /turf/dmm_suite/no_wall)
					if(is_simulated(location))
						var/turf/simulated/S = location
						if(S.density)
							if(S.destruction_turf)
								instance = new S.destruction_turf(location)
							else
								instance = new /turf/simulated/floor/cave_dirt(location)
					else if(is_generation(location))
						var/turf/unsimulated/generation/G = location
						G.density = FALSE
					else
						instance = new /turf/simulated/floor/cave_dirt(location)
				else
					var/turf/old_turf_type = location.type
					instance = new atomPath(location)
					if(instance.plane == PLANE_SHUTTLE)
						location.transit_turf = old_turf_type
			else
				instance = new atomPath(location)

			if(instance)
				if(preloader) // Atom could delete itself in New(), or the instance could be an area.
					preloader.load(instance)
				if(angleOffset)
					instance.dir = turn(instance.dir,-angleOffset)
					instance.on_dmm_suite_rotate(angleOffset)
				instance.map_spawn = TRUE

			return TRUE

		loadAttribute(value, list/strings)
			//Check for string
			if(copytext(value, 1, 2) == "\"")
				return strings[value]
			//Check for number
			var/num = text2num(value)
			if(isnum(num))
				return num
			//Check for file
			else if(copytext(value,1,2) == "'")
				return get_cached_file(copytext(value,2,length(value)))
				// return file(copytext(value,2,length(value)))
			// Check for lists
				// To Do


//-- Preloading ----------------------------------------------------------------

turf
	var
		dmm_suite/preloader/dmm_preloader

/atom/New(turf/newLoc)
    if(is_turf(newLoc))
        var/dmm_suite/preloader/preloader = newLoc.dmm_preloader
        if(preloader)
            newLoc.dmm_preloader = null
            preloader.load(src)
    . = ..()

dmm_suite
	preloader
		parent_type = /datum
		var
			list/attributes
		New(turf/loadLocation, list/_attributes)
			loadLocation.dmm_preloader = src
			attributes = _attributes
			. = ..()
		proc
			load(atom/newAtom)
				var/list/attributesMirror = attributes // apparently this is faster
				for(var/attributeName in attributesMirror)
					newAtom.vars[attributeName] = attributesMirror[attributeName]