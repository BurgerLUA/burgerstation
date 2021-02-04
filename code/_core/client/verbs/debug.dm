/client/verb/print_cleaning_log()

	set name = "Print Cleaning Log (DANGER)"
	set category = "Debug"

	var/final_text = "<h1>Cleaned Objects</h1>"

	for(var/k in SSdelete.cleaning_log)
		final_text += "[k]<br>"

	final_text += "<h1>Queued Objects</h1>"

	for(var/k in SSdelete.objects_to_delete)
		var/datum/D = k
		var/value = SSdelete.objects_to_delete[k]
		final_text += "[D.get_debug_name()] ([ (value - world.time)/10] seconds left)<br>"

	final_text += "<h1>Queued Objects (SAFE)</h1>"

	for(var/k in SSdelete.objects_to_delete_safe)
		var/datum/D = k
		var/value = SSdelete.objects_to_delete_safe[k]
		final_text += "[D.get_debug_name()] ([ (value - world.time)/10] seconds left)<br>"

	src << browse("<head><style>[STYLESHEET]</style></head><body style='font-size:75%'>[span("debug",final_text)]</body>","window=help")

client/verb/air_test(var/pressure as num)
	set name = "Air Test (DANGER)"
	set category = "Debug"

	if(mob)
		var/turf/simulated/S = get_turf(mob)
		if(S)
			S.air_contents["oxygen"] += pressure
			SSair.update_turf_air(S)

	return TRUE

/client/verb/check_lights()
	set name = "Check Lights (DANGER)"
	set category = "Debug"

	var/confirm = input("Are you sure you want to check the lights?","Light Checking") in list("Yes","No","Cancel")|null

	if(confirm != "Yes")
		return FALSE

	var/mob_z = mob.z

	to_chat(span("notice","Generating light spaces..."))

	for(var/obj/structure/interactive/lighting/L in world)
		if(L.z != mob_z)
			continue
		for(var/turf/T in view((0.5 + L.desired_light_power*0.5)*L.desired_light_range,L))
			T.color = "#00FF00"

	to_chat(span("notice","All light spaces have been generated."))

/client/verb/stealth_test()
	set name = "Stealth Test"
	set category = "Debug"

	var/list/offset = direction_to_pixel_offset(mob.dir)

	var/turf/T = locate(mob.x + offset[1]*5, mob.y + offset[2]*5, mob.z)
	if(T)
		var/mob/living/advanced/npc/syndicate/M = new(T)
		M.dir = mob.dir
		INITIALIZE(M)
		FINALIZE(M)
		M.ai.set_active(TRUE)

/client/verb/generate_map_icon()
	set name = "Map Test (DANGER)"
	set category = "Debug"

	var/confirm = input("Are you sure you want to generate a map icon?","Map Generation") in list("Yes","No","Cancel")|null

	if(confirm != "Yes")
		return FALSE

	var/found_tiles = 0
	var/error_tiles = 0
	var/icon/I = new/icon('icons/map_template.dmi',"map_template")
	for(var/x=1,x<=255,x++)
		for(var/y=1,y<=255,y++)
			var/turf/simulated/S = locate(x,y,src.mob.z)
			var/found_color = S.color
			if(!found_color)
				var/icon/I2 = S.icon
				if(!istype(I2))
					I2 = new/icon(S.icon,S.icon_state)
				found_color = I2.GetPixel(16,16)
			if(found_color)
				I.DrawBox(found_color,x,y)
				found_tiles++
			else
				error_tiles++

			sleep(-1)

	src << "Found [found_tiles] tiles, with [error_tiles] errored tiles."
	src << "Icon: [new/image(I)]."
	src << ftp(I,"map_[src.mob.z].png")


/client/verb/make_war()

	set name = "Make War Scene (DANGER)"
	set category = "Debug"

	var/turf/S_T = locate(src.mob.x+src.view,src.mob.y,src.mob.z)
	var/turf/N_T = locate(src.mob.x-src.view,src.mob.y,src.mob.z)

	if(!S_T || !N_T)
		return

	var/list/turf/possible_NT = list()
	var/list/turf/possible_SY = list()

	for(var/turf/simulated/floor/F in range(src.view*0.4,N_T))
		if(F.is_occupied(PLANE_OBJ))
			continue
		possible_NT += F

	for(var/turf/simulated/floor/F in range(src.view*0.4,S_T))
		if(F.is_occupied(PLANE_OBJ))
			continue
		possible_SY += F

	for(var/i=1,i<=8,i++)
		var/turf/S = pick(possible_SY)
		possible_SY -= S

		var/turf/N = pick(possible_NT)
		possible_NT -= N

		var/mob/living/advanced/npc/nanotrasen/N_NPC = new(N)
		N_NPC.dir = EAST
		INITIALIZE(N_NPC)
		FINALIZE(N_NPC)
		N_NPC.ai.set_active(TRUE)

		var/mob/living/advanced/npc/syndicate/S_NPC = new(S)
		S_NPC.dir = WEST
		INITIALIZE(S_NPC)
		FINALIZE(S_NPC)
		S_NPC.ai.set_active(TRUE)

/*
/client/verb/print_garbage()

	set category = "Debug"
	set name = "Print Debug"

	if(!length(ref_id_to_warning))
		usr.to_chat("Nothing has been found in the garbage warning system.")
		return TRUE

	var/final_text = "<h1>Found [length(ref_id_to_warning)] objects that refuse to be deleted.</h1>"

	for(var/ref_id in ref_id_to_warning)
		var/warning_count = ref_id_to_warning[ref_id]
		var/o_type = qdel_refs_to_type[ref_id]
		var/var_edit_text = "<a href=?var_edit_ref=[ref_id]>[ref_id]</a>"
		final_text += "<br>[var_edit_text]([o_type]) = ~[warning_count] seconds"

	usr << browse("<head><style>[STYLESHEET]</style></head><body>[final_text]</body>","window=garbage")
*/

/client/verb/subsystem_report()
	set name = "Subsystem Report"
	set category = "Debug"

	var/report_string = "<h2>Subsystem Report</h2>CPU Usage: [CEILING(world.cpu,1)]%<br>Tick Usage: [CEILING(world.tick_usage,1)]%<br>"

	for(var/k in active_subsystems)
		var/subsystem/S = k
		if(S.last_run_duration || S.total_run_duration)
			report_string += "<b>[S.name]</b>: <pre>LAST: [S.last_run_duration], TOTAL: [S.total_run_duration].</pre><br>"

	report_string += "Subsystems that aren't listed have no registered overtime.."

	to_chat(report_string)

/client/verb/reload_badwords()
	set name = "Reload Badwords"
	set category = "Debug"
	SSbadwords.load_badwords()


/client/verb/force_save_all()
	set name = "Force Save Everyone (DANGER)"
	set category = "Debug"

	for(var/k in all_players)
		var/mob/living/advanced/player/P = k
		if(!P.ckey_last || !P.allow_save)
			continue
		try
			var/savedata/client/mob/mobdata = MOBDATA(P.ckey_last)
			if(mobdata)
				mobdata.save_character(P,force = TRUE)
			to_chat(span("notice","Saved [P.get_debug_name()]."))
		catch(var/exception/e)
			to_chat(span("danger","Could not save [P.get_debug_name()] due to a runtime error!"))
			log_error("[e] on [e.file]:[e.line]!")

/client/verb/stress_test()
	set name = "Stress Test (DANGER)"
	set category = "Debug"

	var/confirm = input("Are you sure you want to do this?","HELL.") in list("Yes","No","Cancel")|null

	if(confirm != "Yes")
		return FALSE

	var/list/valid_turfs = list()

	for(var/turf/simulated/floor/S in view(VIEW_RANGE + ZOOM_RANGE,mob))
		valid_turfs += S

	for(var/i=1,i<=60,i++)
		spawn
			var/mob/living/advanced/npc/syndicate/stress_test/ST = new(pick(valid_turfs))
			INITIALIZE(ST)
			GENERATE(ST)
			FINALIZE(ST)


/client/verb/create_vote()
	set name = "Test Vote (DANGER)"
	set category = "Debug"

	var/confirm = input("Are you sure you want to do this?","Vote Testing.") in list("Yes","No","Cancel")|null

	if(confirm != "Yes")
		return FALSE

	SSvote.create_vote(/vote/continue_round)

	return TRUE

/*
/client/verb/create_dummy_objective()
	set name = "Create Dummy Objective"
	set category = "Debug"

	var/gamemode/G = SSgamemode.active_gamemode

	G.add_objective(/objective/dummy)

	for(var/objective/dummy/D in G.active_objectives)
		D.update()

	sleep(100)

	for(var/objective/dummy/D in G.active_objectives)
		D.completed = TRUE
		D.update()

	return TRUE
*/


/client/verb/force_screech()
	set name = "Force Queen Screech"
	set category = "Debug"

	var/mob/living/simple/xeno/queen/XQ = locate() in view(mob,VIEW_RANGE)

	if(XQ)
		XQ.screech(TRUE)

/*	This was dumb
/client/verb/print_forcemove_table()
	set name = "Forcemove Table (DANGER)"
	set category = "Debug"

	sortTim(force_move_calls_per_type,/proc/cmp_numeric_dsc,associative=TRUE)

	for(var/k in force_move_calls_per_type)
		var/v = force_move_calls_per_type[k]
		src.to_chat("[k]: [v]")
*/


var/global/list/debug_verbs = list(
	/client/verb/print_cleaning_log,
	/client/verb/air_test,
	/client/verb/make_war,
	/client/verb/generate_map_icon,
	/client/verb/stealth_test,
	/client/verb/check_lights,
	/client/verb/subsystem_report,
	/client/verb/reload_badwords,
	/client/verb/force_save_all,
	/client/verb/stress_test,
	/client/verb/force_screech,
	/client/verb/create_vote,
	/client/verb/var_edit,
	/client/verb/change_variable,
	/client/verb/set_mob_to_null
)

/client/verb/show_debug_verbs()
	set name = "Show Debug Verbs"
	set category = "Menu"
	for(var/k in debug_verbs)
		verbs += debug_verbs
	verbs -= /client/verb/show_debug_verbs
	verbs += /client/verb/hide_debug_verbs

/client/verb/hide_debug_verbs()
	set name = "Hide Debug Verbs"
	set category = "Menu"
	for(var/k in debug_verbs)
		verbs -= debug_verbs
	verbs += /client/verb/show_debug_verbs
	verbs -= /client/verb/hide_debug_verbs

/client/verb/set_mob_to_null()
	set name = "Set Mob to Null (DANGER)"
	set category = "Debug"

	var/desired_input = input("Are you sure you want to set your mob to null? This exists to test a safety feature.","Set Mob to Null","Cancel") as null|anything in list("Yes","No","Cancel")

	if(desired_input == "Yes")
		mob.ckey = null
		mob = null
	else
		to_chat(span("notice","You decide not to do anything."))
