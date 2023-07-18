#define FILE_SIZE_LIMIT 8

/client/AllowUpload(filename,filelength)

	if(filelength > FILE_SIZE_LIMIT*1000) //This is in bytes
		to_chat(span("warning","[filename] is too large to upload! Limit: [FILE_SIZE_LIMIT]kb, File: [CEILING(filelength/1000,1)]kb."))
		return FALSE

	. = ..()

/client/proc/upload_icon()

	if(!icon_request_details["width_limit"] || !icon_request_details["height_limit"])
		return FALSE

	var/icon/desired_file = input("Choose an icon to upload for your spray. Must be less than [icon_request_details["width_limit"]]x[icon_request_details["height_limit"]] pixels in size, and under [FILE_SIZE_LIMIT]kb.","Upload Spray") as null|icon

	if(!icon_request_details || !icon_request_details["proc"] || !icon_request_details["proc_src"])
		icon_request_details.Cut()
		icon_request_details = null
		return FALSE

	if(!desired_file)
		icon_request_details.Cut()
		icon_request_details = null
		return FALSE

	desired_file = new/icon(desired_file)

	var/icon_height = desired_file.Height()
	var/icon_width = desired_file.Width()

	if(!icon_height || !icon_width)
		to_chat(span("warning","Failed to upload file. There was an error reading the file."))
		return FALSE

	if(icon_request_details["width_limit"] && icon_request_details["height_limit"] && (icon_request_details["width_limit"] < icon_width || icon_request_details["height_limit"] < icon_height))
		to_chat(span("warning","Failed to upload file. Maximium dimensions is [icon_request_details["width_limit"]]x[icon_request_details["height_limit"]]"))
		icon_request_details.Cut()
		icon_request_details = null
		return FALSE

	call(icon_request_details["proc_src"],icon_request_details["proc"])(src,desired_file)
	icon_request_details.Cut()
	icon_request_details = null

	return TRUE