#define value_or_null(the_list,key) the_list[key] ? the_list[key] : null



/savedata/
	var/name = "savedata"
	var/desc = "Data for a user."

	var/list/loaded_data = list()

/savedata/proc/reset_data()
	loaded_data = list()






/savedata/proc/get_folder(var/list/data)
	return ""