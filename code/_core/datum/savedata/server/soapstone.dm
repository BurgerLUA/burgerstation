/savedata/server/soapstone
	name = "Soapstone Save Data"

/savedata/server/soapstone/get_file(var/folder_id)
	return SOAPSTONE_FILE_FORMAT

/savedata/server/soapstone/proc/quick_write(var/list/data_to_write)
	if(!data_to_write || !length(data_to_write))
		return FALSE

	var/date = data_to_write["date"]
	var/time = data_to_write["time"]
	text2file(",\"[date]_[time]\":" + json_encode(data_to_write),get_file())

	return TRUE

/savedata/server/soapstone/proc/quick_load()
	var/json_data = file2text(get_file())

	if(!json_data)
		return FALSE

	var/list/formatted_data = json_decode("{" + json_data + "}")

	for(var/instance in formatted_data)

		var/x_cord = formatted_data[instance]["x"]
		var/y_cord = formatted_data[instance]["y"]

		world.log << "CORDS: [x_cord].[y_cord]"

		var/turf/desired_loc = locate(x_cord,y_cord,1)

		world.log << "TURF: [desired_loc.name]"

		var/name = formatted_data[instance]["name"]
		var/ckey = formatted_data[instance]["ckey"]
		var/text = formatted_data[instance]["text"]

		var/date = formatted_data[instance]["date"]
		var/time = formatted_data[instance]["time"]

		new/obj/structure/interactive/soapstone_message(desired_loc,name,ckey,text,date,time)