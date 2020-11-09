#define POLY "data/server/poly.txt"

SUBSYSTEM_DEF(poly)
	name = "Poly Subsystem"
	desc = "Poly says some shit."
	priority = SS_ORDER_PRELOAD
	var/list/old_poly_text = list(
		"PACKETS"
	)
	var/list/new_poly_text = list()

/subsystem/poly/Initialize()

	var/data_read = rustg_file_read(POLY)
	if(data_read)
		data_read = trim(data_read)
		old_poly_text = splittext(data_read,"\n")
		log_subsystem(name,"Loaded [old_poly_text] different poly phrases.")
	else
		log_subsystem(name,"Could not find any poly phrases to load.")

/subsystem/poly/proc/save_existing_text()

	if(!length(new_poly_text))
		return FALSE

	var/text_to_save = jointext(new_poly_text,"\n")
	rustg_file_append(text_to_save,POLY)

	old_poly_text += new_poly_text

	return TRUE


/subsystem/poly/proc/add_new_text(var/text_to_add)
	if(!text_to_add)
		return FALSE
	if(length(text_to_add) > 144)
		return FALSE
	var/list/split = splittext(text_to_add," ")
	if(length(split) > 10)
		return FALSE
	new_poly_text += text_to_add
	return TRUE
