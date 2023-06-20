SUBSYSTEM_DEF(fuckup)
	name = "Fuckup Subsystem"
	desc = "Fixes savedata fuckups that are caused via bugs."
	priority = SS_ORDER_CONFIG

	var/list/all_fuckups = list()

/subsystem/fuckup/Initialize()

	for(var/k in subtypesof(/fuckup/))
		var/fuckup/FU = k
		FU = new k
		all_fuckups += FU

	log_subsystem(name,"Initialized [length(all_fuckups)] fucks.")

	. = ..()

/subsystem/fuckup/proc/apply_fuckup(var/fuckup/FU)

	allow_loading = FALSE

	for(var/mob/living/advanced/player/P in all_mobs_with_clients)
		if(P.loyalty_tag != "NanoTrasen") //Antag?
			continue
		if(P.client)
			P.client.to_chat(span("danger","As part of a savefile cleaning initiative, you were forced to save your character. All progress has been saved."))
		P.force_logout()
		CHECK_TICK_HARD

	var/save_dir = "data/users/"

	var/save_files_applied_to = 0

	for(var/ckey in flist(save_dir))
		CHECK_TICK_HARD
		for(var/local_file_dir in flist("[save_dir][ckey]characters/"))
			CHECK_TICK_HARD
			var/full_file_dir = "[save_dir][ckey]characters/[local_file_dir]"
			var/file_contents = rustg_file_read(full_file_dir)
			file_contents = json_decode(file_contents)
			file_contents = FU.apply(file_contents)
			rustg_file_write(json_encode(file_contents),full_file_dir)
			log_debug("Successfully applied data for [full_file_dir].")
			save_files_applied_to += 1

	log_debug("Successfully applied fuckup \"[FU.name]\" to [save_files_applied_to] save files.")

	allow_loading = TRUE