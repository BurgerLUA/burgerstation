#define CARGO_DIR "data/server/cargo_items.txt"
#define CARGO_VALUE_MULTIPLIER 3


SUBSYSTEM_DEF(cargo)
	name = "Cargo Subsystem"
	desc = "Store all possible items to load from cargo."
	priority = SS_ORDER_LAST
	var/list/cargo_id_to_type = list()
	var/list/catalog_data = list() //What the catalog should look like

/subsystem/cargo/Initialize()

	var/turf/T = locate(1,1,1)

	if(fexists(CARGO_DIR))
		var/loaded_data = file2text(CARGO_DIR)
		var/line_count = 0
		for(var/line in splittext(loaded_data,"\n"))
			line_count++
			var/atom/movable/P = text2path(trim(line))
			if(!P)
				log_error("Cargo Subsystem: Could not parse line [line_count] of [CARGO_DIR].")
				continue
			P = new P(T)
			INITIALIZE(P)
			GENERATE(P)
			FINALIZE(P)
			P.invisibility = 101
			P.loc = null
			var/md5_hash = copytext(rustg_hash_string(RUSTG_HASH_MD5,line),1,6)
			cargo_id_to_type[md5_hash] = P
			sortTim(cargo_id_to_type,/proc/cmp_path_dsc,associative=TRUE)

	var/item_count = 1

	var/list/cached_text = ""
	for(var/md5 in cargo_id_to_type)
		var/obj/item/I = cargo_id_to_type[md5]
		var/actual_name = I.name
		actual_name = replacetextEx(actual_name,"\improper","")
		var/desired_text = "# [actual_name]\n\n## [I.desc_extended]\n\n### Order Code: [md5]\n\n### Value: [I.get_value()]\n\n"
		cached_text += desired_text
		item_count++
		if(item_count >= 5)
			catalog_data += cached_text
			cached_text = ""
			item_count = 1

	return ..()