/client/AllowUpload(filename,filelength)

	if(filelength > 128000) //This is in bytes
		to_chat(span("warning","[filename] is too large to upload! Limit: 128kb, File: [CEILING(filelength/1000,1)]kb."))
		return FALSE

	. = ..()

/client/proc/upload_icon()

	var/icon/desired_file = input("Choose an icon to upload for your spray. Must be less than 32x32 pixels in size, and under 128kb.","Upload Spray") as null|icon

	if(!icon_request_details || !icon_request_details["proc"] || !icon_request_details["proc_src"])
		icon_request_details.Cut()
		icon_request_details = null
		return FALSE

	if(!desired_file)
		icon_request_details.Cut()
		icon_request_details = null
		return FALSE

	desired_file = new/icon(desired_file)

	if(icon_request_details["width_limit"] && icon_request_details["height_limit"] && (icon_request_details["width_limit"] < desired_file.Width() || icon_request_details["height_limit"] < desired_file.Height()))
		to_chat(span("warning","Failed to upload file. Maximium dimensions is [icon_request_details["width_limit"]]xicon_request_details["height_limit"]"))
		icon_request_details.Cut()
		icon_request_details = null
		return FALSE

	call(icon_request_details["proc_src"],icon_request_details["proc"])(src,desired_file)
	icon_request_details.Cut()
	icon_request_details = null