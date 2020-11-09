var/global/list/all_telecomms = list()

/obj/structure/interactive/telecomms
	name = "telecommunications"
	desc = "Controls radios."
	icon = 'icons/obj/structure/telecomms.dmi'
	icon_state = "comm_server"

	var/list/queued_data = list()

/obj/structure/interactive/telecomms/Finalize()

	var/area/A = get_area(src)
	if(A.area_identifier)
		if(!all_telecomms[A.area_identifier])
			all_telecomms[A.area_identifier] = list()
		all_telecomms[A.area_identifier] += src

	return ..()

/obj/structure/interactive/telecomms/Destroy()
	var/area/A = get_area(src)
	if(all_telecomms[A.area_identifier])
		all_telecomms[A.area_identifier] -= src
	return ..()

/obj/structure/interactive/telecomms/proc/add_data(var/data_identifier,var/list/data_to_add)
	ASSERT(data_identifier)
	ASSERT(data_to_add)
	queued_data[data_identifier] = data_to_add
	return TRUE


/obj/structure/interactive/telecomms/proc/process_all_data()
	for(var/id in queued_data)
		var/v = queued_data[id]
		process_data(v)
	queued_data.Cut()
	return TRUE

/*
	var/list/radio_data = list(
		"speaker" = speaker,
		"source" = source,
		"text_to_say" = text_to_say,
		"text_type" = text_type,
		"frequency" = frequency,
		"language" = language
	)
*/


/obj/structure/interactive/telecomms/proc/process_data(var/list/data_to_process = list())

	for(var/k in all_radios)
		var/obj/item/device/radio/R = k
		use_ears(data_to_process["speaker"],R,data_to_process["text_to_say"],data_to_process["text_type"],data_to_process["frequency"],data_to_process["language"],R.broadcasting_range)



	return TRUE