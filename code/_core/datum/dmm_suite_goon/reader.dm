

//-- Reader for loading DMM files at runtime -----------------------------------
/datum/loadedProperties
	var/info = ""
	var/sourceX = 0
	var/sourceY = 0
	var/sourceZ = 0
	var/maxX = 0
	var/maxY = 0
	var/maxZ = 0

dmm_suite

	/*-- read_map ------------------------------------
	Generates map instances based on provided DMM formatted text. If coordinates
	are provided, the map will start loading at those coordinates. Otherwise, any
	coordinates saved with the map will be used. Otherwise, coordinates will
	default to (1, 1, world.maxz+1)
	*/
	read_map(dmm_text as text, coordX as num, coordY as num, coordZ as num, tag as text, overwrite as num, angleOffset as num)
		if(angleOffset)
			angleOffset = MODULUS(round(angleOffset,90), 360)
		else
			angleOffset = 0
		var/datum/loadedProperties/props = new()
		props.sourceX = coordX
		props.sourceY = coordY
		props.sourceZ = coordZ
		props.info = tag
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
				log_debug("Setting key length to [key_len].")
			var/modelsStart = findtextEx(modelLine, "/") // Skip key and first three characters: "aa" = (
			var/modelContents = copytext(modelLine, modelsStart, length(modelLine)) // Skip last character: )
			grid_models[modelKey] = modelContents //We have now stored the key representing the turf.
			sleep(-1)
		if(!coordX) coordX = 1
		if(!coordY) coordY = 1
		if(!coordZ) coordZ = world.maxz+1
		// Store quoted portions of text in text_strings, and replaces them with an index to that list.
		var/gridText = copytext(dmm_text, startGridPos)
		var/list/gridLevels = list()
		// WIP
		// \(([0-9]*),([0-9]*),([0-9]*)\) = \{"\s*([A-z\s]+)"\}
		var/regex/grid = regex(@{"\(([0-9]*),([0-9]*),([0-9]*)\) = \{"\n((?:[a-z]*\n)*)"\}"}, "g") //Retrieve the coord line thing.
		//Positioned Keys:             1        2        3                  4
		var/regex/newline_remover = regex(@'\n',"g")
		var/list/coordShifts = list()
		if(key_len < 1) CRASH("key_len was impossibly less than 1 ([key_len])!")
		var/maxXFound = 1
		var/maxYFound = 1
		var/maxZFound = 1
		while(grid.Find(gridText))
			grid.group[4] = newline_remover.Replace(grid.group[4],"")
			var/group_4_length = length(grid.group[4]) / key_len
			if(group_4_length > 1000)
				CRASH("Group 4 length was impossibly greater than 1000! ([length(grid.group[4])], Key Length: [key_len], Final: [length(grid.group[4])/key_len]. Example: [grid.group[4][1000]]")
			gridLevels.Add(grid.group[4])
			coordShifts.Add(
				list(
					list(grid.group[1], grid.group[2], grid.group[3])
				)
			)
			maxXFound = max(maxXFound, text2num(grid.group[1])) //x
			maxYFound = max(maxYFound, group_4_length) //y
			maxZFound = max(maxZFound, text2num(grid.group[3])) //z

			if(maxXFound > 1000) CRASH("maxXFound was impossibly greater than 1000 ([maxXFound], [group_4_length])!")
			if(maxYFound > 1000) CRASH("maxYFound was impossibly greater than 1000 ([maxYFound], [group_4_length])!")
			if(maxZFound > 1000) CRASH("maxZFound was impossibly greater than 1000 ([maxZFound], [group_4_length])!")

		log_debug("[tag]: ([maxXFound],[maxYFound],[maxZFound])")
		// Create all Atoms at map location, from model key

		if((coordX+maxXFound-1) > world.maxx)
			world.maxx = coordX+maxXFound-1
			log_debug("X level increased to [world.maxx].")
		if((coordY+maxYFound-1) > world.maxy)
			world.maxy = coordY+maxYFound-1
			log_debug("Y level increased to [world.maxy].")
		if((coordZ+maxZFound-1) > world.maxz)
			world.maxz = coordZ+maxZFound-1
			log_debug("Z levels increased to [world.maxz].")

		props.maxX = maxXFound
		props.maxY = maxYFound
		props.maxZ = maxZFound

		for(var/posZ = 1 to maxZFound)
			CHECK_TICK_SAFE(50,FPS_SERVER)
			var/zGrid = gridLevels[posZ]
			// Reverse Y coordinate
			var/list/yReversed = text2list(zGrid, "\n")
			var/list/yLines = list()
			for(var/posY = yReversed.len to 1 step -1)
				yLines.Add(yReversed[posY])

			var/gridCoordX = text2num(coordShifts[posZ][1]) + coordX - 1
			var/gridCoordY = text2num(coordShifts[posZ][2]) + coordY - 1
			var/gridCoordZ = text2num(coordShifts[posZ][3]) + coordZ - 1

			if(overwrite)
				for(var/posY = 1 to maxXFound)
					for(var/posX = 1 to maxYFound)
						var/grid_x = gridCoordX - 1
						var/grid_y = gridCoordY - 1
						var/offset_x = posX
						var/offset_y = posY
						var/turf/T = locate(grid_x + offset_x,grid_y + offset_y, gridCoordZ)
						for(var/k in T)
							var/datum/x = k
							if(overwrite & DMM_OVERWRITE_OBJS && istype(x, /obj))
								qdel(x)
								if(overwrite & DMM_OVERWRITE_MARKERS && istype(x,/obj/marker/))
									qdel(x)
							else if(overwrite & DMM_OVERWRITE_MOBS && istype(x, /mob))
								qdel(x)
							CHECK_TICK_SAFE(50,FPS_SERVER)

			for(var/posY=1,posY<=maxYFound,posY++)
				for(var/posX=1,posX<=maxXFound,posX++)

					var/grid_x = (gridCoordX - 1) //Origin loc.
					var/grid_y = (gridCoordY - 1) //Origin loc

					var/offset_x = posX
					var/offset_y = posY

					switch(angleOffset)
						if(0)
							offset_x = posX
							offset_y = posY
						if(90)
							offset_x = posY
							offset_y = maxXFound - posX
						if(180) //Works
							offset_x = maxXFound - posX //Negative x
							offset_y = maxYFound - posY //Negative y

						if(270)
							offset_x = maxYFound - posY
							offset_y = posX

					var/keyPos = ((posX-1)*key_len)+1
					var/modelKey = copytext(maxYFound, keyPos, keyPos+key_len)
					var/turf/location = locate(grid_x + offset_x,grid_y + offset_y,gridCoordZ)
					parse_grid(
						grid_models[modelKey],
						location,
						angleOffset,
						overwrite
					)
					CHECK_TICK_SAFE(50,FPS_SERVER)

		if(tag)
			log_debug("dmm_suite loaded: [tag].")
		//
		return props

//-- Supplemental Methods ------------------------------------------------------

	var
		quote = "\""
		regex/comma_delim = new("\[\\s\\r\\n\]*,\[\\s\\r\\n\]*")
		regex/semicolon_delim = new("\[\\s\\r\\n\]*;\[\\s\\r\\n\]*")
		regex/key_value_regex = new("^\[\\s\\r\\n\]*(\[^=\]*?)\[\\s\\r\\n\]*=\[\\s\\r\\n\]*(.*?)\[\\s\\r\\n\]*$")

	proc
		parse_grid(models as text, var/turf/location, angleOffset, overwrite)
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
				loadModel(atomPath, attributes, originalStrings, location, angleOffset)

		loadModel(atomPath, list/attributes, list/strings, var/turf/location, angleOffset)
			// Cancel if atomPath is a placeholder (DMM_IGNORE flags used to write file)
			if(ispath(atomPath, /turf/dmm_suite/clear_turf) || ispath(atomPath, /area/dmm_suite/clear_area))
				return
			// Parse all attributes and create preloader
			var/list/attributesMirror = list()
			if(!location)
				return

			for(var/attributeName in attributes)
				attributesMirror[attributeName] = loadAttribute(attributes[attributeName], strings)
			var/dmm_suite/preloader/preloader = new(location, attributesMirror)
			// Begin Instanciation
			// Handle Areas (not created every time)
			var/atom/instance
			if(ispath(atomPath, /area)) //Don't set instances for areas.
				new atomPath(location)
				location.dmm_preloader = null
			// Handle Underlay Turfs
			else if(ispath(atomPath, /turf))
				if(ispath(atomPath, /turf/dmm_suite/no_wall))
					if(is_simulated(location))
						var/turf/simulated/S = location
						if(S.density)
							if(S.destruction_turf)
								instance = new S.destruction_turf(location)
							else
								instance = new /turf/simulated/floor/cave_dirt(location)
					else if(istype(location,/turf/unsimulated/generation))
						var/turf/unsimulated/generation/G = location
						G.density = FALSE
					else
						instance = new /turf/simulated/floor/cave_dirt(location)
				else
					instance = new atomPath(location)
			else if(atomPath)
				instance = new atomPath(location)
				if(angleOffset)
					instance.dir = turn(instance.dir,-angleOffset)
			if(preloader && instance) // Atom could delete itself in New(), or the instance could be an area.
				preloader.load(instance)
			//
			return instance

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

atom/New(turf/newLoc)
    if(isturf(newLoc))
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