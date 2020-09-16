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
	set name = "Air Test"
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

	to_chat("Generating light spaces...")

	for(var/obj/structure/interactive/lighting/L in world)
		if(L.z != mob_z)
			continue
		for(var/turf/T in view((0.5 + L.desired_light_power*0.5)*L.desired_light_range,L))
			T.color = "#00FF00"

	to_chat("Done generating light spaces.")

/client/verb/test_round_end()
	set name = "Test Round End (DANGER)"
	set category = "Debug"

	var/confirm = input("Are you sure you want to end the round in a NanoTrasen Victory?","NanoTrasen Victory") in list("Yes","No","Cancel")|null

	if(confirm != "Yes")
		return FALSE

	world.end(WORLD_END_NANOTRASEN_VICTORY,FALSE)

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
		if(F.is_occupied())
			continue
		possible_NT += F

	for(var/turf/simulated/floor/F in range(src.view*0.4,S_T))
		if(F.is_occupied())
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


/client/verb/add_new_wikibot_entry(var/wikibot_question as text,var/wikibot_answer as text)
	set category = "Debug"
	set name = "Add New Wikibot Entry"

	if(!wikibot_question || !wikibot_answer)
		return FALSE

	var/list/new_question_keys = splittext(wikibot_question," ")

	if(SSwikibot)
		SSwikibot.add_new_wikibot_key(new_question_keys,wikibot_answer)

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


/client/verb/spawn_from_path(var/object as text) //TODO: Make this work.
	set name = "Spawn"
	set desc = "Spawn an object."
	set category = "Debug"

	if(!object)
		return FALSE

	if(object[1] != "/")
		object = "/" + object

	var/last_checker = copytext(object,-1,0)
	if(last_checker == "/")
		object = copytext(object,1,-1)

	var/valid_path = text2path(object)

	if(!valid_path)
		usr.to_chat("\"[object]\" isn't a valid path.")
		return FALSE

	var/list/valid_objects = typesof(valid_path)

	var/valid_count = length(valid_objects)

	if(!valid_count)
		usr.to_chat("\"[object]\" returned no valid types.")
		return FALSE

	if(valid_count == 1)
		var/datum/A = valid_objects[1]
		A = new A(usr.loc)
		INITIALIZE(A)
		GENERATE(A)
		FINALIZE(A)
		return TRUE

	var/selection = input("Spawn object.","Spawn object") as null|anything in valid_objects

	if(selection)
		var/datum/A = selection
		A = new A(usr.loc)
		INITIALIZE(A)
		FINALIZE(A)
		if(isobj(A))
			var/obj/O = A
			GENERATE(O)
		return TRUE

/client/verb/change_variable(var/datum/object as anything in view(), var/desired_varable_key as text, var/desired_varable_value as anything)

	set name = "Change Variable"
	set category = "Debug"

	if(desired_varable_value && istext(desired_varable_value))
		desired_varable_value = sanitize(desired_varable_value)

	if(object && is_datum(object) && desired_varable_key && desired_varable_value)
		object.vars[desired_varable_key] = desired_varable_value


/client/verb/var_edit(var/object as anything in view())
	set name = "Variable Edit"
	set category = "Debug"

	if(!object)
		return FALSE

	if(is_datum(object))

		var/datum/D = object

		var/returning_text = "<br><center>[object]</center>"

		for(var/k in D.vars)

			if(k == "vars" || k == "verbs")
				continue

			var/v = D.vars[k]
			var/line_text = "[k] = [get_value_text_for_debug(D,k,v)]"
			returning_text += "[line_text]<br>"

		src << browse("<head><style>[STYLESHEET]</style></head><body style='font-size:75%'>[span("debug",returning_text)]</body>","window=help")

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
			to_chat("Saved [P.get_debug_name()].")
		catch
			to_chat("COULD NOT SAVE [P.get_debug_name()]!")

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