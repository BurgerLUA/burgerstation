SUBSYSTEM_DEF(soapstone)
	name = "Soapstone Subsystem"
	desc = "Subsystem dedicated to loading and saving soapstone messages."
	priority = SS_ORDER_NORMAL

	var/savedata/server/soapstone/save_soapstone

/subsystem/soapstone/Initialize()
	save_soapstone = new
	save_soapstone.quick_load()
	return ..()

/subsystem/soapstone/proc/create_new_soapstone(var/turf/desired_loc,desired_dir,desired_color,desired_owner,desired_ckey,desired_text,desired_date,desired_time)

	var/list/data_to_write = list()
	data_to_write["name"] = desired_owner
	data_to_write["ckey"] = desired_ckey
	data_to_write["text"] = desired_text
	data_to_write["date"] = desired_date
	data_to_write["time"] = desired_time
	data_to_write["x"] = desired_loc.x
	data_to_write["y"] = desired_loc.y
	data_to_write["z"] = desired_loc.z
	data_to_write["dir"] = desired_dir
	data_to_write["color"] = desired_color
	save_soapstone.quick_write(data_to_write)

	return new/obj/structure/interactive/soapstone_message(desired_loc,desired_dir,desired_color,desired_owner,desired_ckey,desired_text,desired_date,desired_time)
