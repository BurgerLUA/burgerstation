//Here lies dead code.
//They never scored.


/*
for(var/atom_segment in found_data_as_list)
	modifiers_regex.Find(atom_segment)
	var/modifiers = modifiers_regex.match
	if(modifiers) //Optional. Don't panic.
		atom_segment = copytext(atom_segment,1,modifiers_regex.index)
		var/list/modifiers_as_list = splittext(modifiers,",")
		if(!length(modifiers_as_list)) CRASH("Error when trying to convert modifiers into a list: [matched_text]")
		key_to_data[found_key]["object_vars"][atom_segment] = modifiers_as_list
	key_to_data[found_key]["objects"] += atom_segment
*/

//Key stuff.
var/global/regex/data_regex = regex(@'\([^)]+\)')
var/global/regex/key_regex = regex(@'"[A-z]+" ')
var/global/regex/modifiers_regex = regex(@'{[^}]+}') //Optional!

//Content stuff
var/global/regex/coords_regex = regex(@'\(\d+,\d+,\d+\) ')
var/global/regex/tiles_regex = regex(@'"[^"]+"')



/proc/parse_map(var/map_file,var/base_x=0,var/base_y=0,var/base_z = world.maxz+1,var/angle_offset=0,var/map_tag)

	set background = 1

	if(!map_file) CRASH("Did not provide a map_file!")

	var/map_text = file2text(map_file)

	if(!map_text || length(map_text) <= 0) CRASH("Invalid map_file!")

	var/regex/regex_map_key = regex(@'"[A-z]+" = [^)]+\)',"g")

	//Setup keys.
	/*
		What the list should look like.
		key_to_data["aaa"] = list(
			"/turf/",
			"/obj/",
			"/mob{name="mobber";desc="hi"}"
		)
	*/
	var/largest_key_length = 0
	var/list/key_to_data = list()
	var/next_find_result = 1
	while(TRUE)
		regex_map_key.Find(map_text,next_find_result)
		var/find_result = regex_map_key.index
		if(!find_result)
			break
		//It begins.
		next_find_result = regex_map_key.next
		var/matched_text = regex_map_key.match

		key_regex.Find(matched_text) //Try to find the keys.

		if(!key_regex.match) CRASH("Error when trying to find key via regex in text: [matched_text]")

		var/found_key = copytext(key_regex.match,2,-2)

		if(!found_key) CRASH("Error when trying to find key via copytext in text: [matched_text]")

		largest_key_length = max(largest_key_length,length(found_key))

		data_regex.Find(matched_text) //Try to find the data that represents the keys.

		if(!data_regex.match) CRASH("Error when trying to find data via regex in text: [matched_text]")

		var/found_data = copytext(data_regex.match,2,-1) //as a string

		if(!found_data) CRASH("Error when trying to find data via copytext in text: [matched_text]")

		var/list/found_data_as_list = splittext(found_data,",")

		if(!length(found_data_as_list)) CRASH("Error when trying to convert found_data into a list: [matched_text]")

		key_to_data[found_key] = found_data_as_list
		sleep(-1)
	//Keys done. Now onto the map.
	next_find_result = 1

	if(largest_key_length <= 0) CRASH("Something went terribly wrong.")

	var/global/regex/regex_map_data = regex(@'\(\d+,\d+,\d+\) = \{[^\}]*\}',"g")

	var/max_x = 0
	var/max_y = 0

	var/list/final_turf_data = list()

	while(TRUE)
		regex_map_data.Find(map_text,next_find_result)
		var/find_result = regex_map_data.index
		if(!find_result)
			break
		//It begins (again)
		next_find_result = regex_map_data.next
		var/matched_text = regex_map_data.match

		coords_regex.Find(matched_text)

		if(!coords_regex.match) CRASH("Error when trying to find coords via regex in text: [matched_text]")

		var/found_coords = copytext(coords_regex.match,2,-2)

		if(!found_coords) CRASH("Error when trying to find coords via copytext in text: [matched_text]")

		var/list/found_coords_as_list = splittext(found_coords,",") //Try to find the coords.

		if(!length(found_coords_as_list)) CRASH("Error when trying to convert coords into a list: [matched_text]")

		tiles_regex.Find(matched_text) //Try to find the tiles.

		if(!tiles_regex.match) CRASH("Error when trying to find tiles via regex in text: [matched_text]")

		var/found_tiles = copytext(coords_regex.match,2,-1) //Trim the "s

		if(!found_tiles) CRASH("Error when trying to find tiles via copytext in text: [matched_text]")

		var/found_tiles_length = length(found_tiles) //NOT THE LENGTH OF X, ITS THE NUMBER OF CHARACTERS PER ROW.

		var/list/final_list = list()
		for(var/i=1,i<=found_tiles_length,i+=largest_key_length)
			final_list += copytext(i,i+found_tiles_length)
		max_y = max(max_y,length(final_list))
		final_turf_data += list(final_list)
		max_x = max(max_x,text2num(found_coords_as_list[1]))
		sleep(-1)

	for(var/y=1,y<=length(final_turf_data),y++)
		var/list/list_of_x = final_turf_data[y]
		for(var/x=1,x<=length(list_of_x),x++)
			var/turf/T = locate(base_x+x,base_y+y,base_z)
			var/key = list_of_x[x]
			var/list/key_data = key_to_data[key]
			for(var/k in key_data)
				var/a = text2path(k)
				if(a) new a(T)
				sleep(-1)



































