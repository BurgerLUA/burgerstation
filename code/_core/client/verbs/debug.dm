var/global/list/debug_verbs = list(
	/client/verb/make_war,
	/client/verb/stealth_test,
	/client/verb/check_lights,
	/client/verb/reload_badwords,
	/client/verb/force_save_all,
	/client/verb/stress_test,
	/client/verb/force_screech,
	/client/verb/create_vote,
	/client/verb/var_edit,
	/client/verb/change_variable,
	/client/verb/set_mob_to_null,
	/client/verb/add_loadout_to_mob,
	/client/verb/force_save_deathbox,
	/client/verb/force_load_deathbox,
	/client/verb/force_save_banks,
	/client/verb/view_dps,
	/client/verb/view_dph,
	/client/verb/view_killtime,
	/client/verb/test_ranged_weapons,
	/client/verb/debug_flash,
	/client/proc/debug_variables,
	/client/proc/spawn_atom,
	/client/verb/test_astar,
	/client/verb/print_garbage,
	/client/verb/set_skill,
	/client/verb/set_attribute,
	/client/verb/horde_test_preview,
	/client/verb/test_rust_g,
	/client/verb/debug_current_chunk,
	/client/verb/debug_weapon_value,
	/client/verb/swarm_test,
	/client/verb/destroy_everything,
	/client/verb/subsystem_debug
)


var/global/list/destroy_everything_whitelist = list(
	/obj/item/,
	/obj/decal/,
	/obj/effect/,
	/obj/structure/,
	/mob/living/advanced/npc,
	/mob/living/simple,
)

/client/verb/destroy_everything()
	set name = "Destroy EVERYTHING (DANGER)"
	set category = "Debug"

	var/desired_choice = input("Are you sure you wish to spawn every movable object in the game and then destroy it?","Cause Hell","Cancel") as null|anything in list("Yes","No","Cancel")

	if(desired_choice != "Yes")
		return TRUE

	var/list/valid_turfs = list()
	for(var/turf/simulated/T in orange(VIEW_RANGE*0.5,mob))
		if(T.density || T.has_dense_atom)
			continue
		valid_turfs += T

	if(!length(valid_turfs))
		return TRUE

	for(var/j in destroy_everything_whitelist)
		for(var/k in subtypesof(j))
			var/atom/movable/M = new k(pick(valid_turfs))
			INITIALIZE(M)
			GENERATE(M)
			FINALIZE(M)
			qdel(M)
			sleep(-1)



/client/verb/view_dps()
	set name = "View DPS of Weapons"
	set category = "Debug"

	var/text_to_send = ""

	for(var/k in SSbalance.stored_dps)
		var/v = SSbalance.stored_dps[k]
		text_to_send += "[k]: [v] DPS<br>"

	src << browse("<body>[text_to_send]</body>","window=help")

/client/verb/view_dph()
	set name = "View DPH of Weapons"
	set category = "Debug"

	var/text_to_send = ""

	for(var/k in SSbalance.stored_dph)
		var/v = SSbalance.stored_dph[k]
		text_to_send += "[k]: [v] DPH<br>"

	src << browse("<body>[text_to_send]</body>","window=help")

/client/verb/view_killtime()
	set name = "View Killtime of Weapons"
	set category = "Debug"

	var/text_to_send = ""

	for(var/k in SSbalance.stored_killtime)
		var/v = SSbalance.stored_killtime[k]
		text_to_send += "[k]: [v] seconds<br>"

	src << browse("<body>[text_to_send]</body>","window=help")


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
		M.ai.debug = TRUE
		M.ai.set_active(TRUE)

/*
/client/verb/generate_map_icon()
	set name = "Map Test (DANGER)"
	set category = "Debug"

	var/confirm = input("Are you sure you want to generate a map icon?","Map Generation") in list("Yes","No","Cancel")|null

	if(confirm != "Yes")
		return FALSE

	var/found_tiles = 0
	var/error_tiles = 0
	var/icon/I = ICON_INVISIBLE
	I.Crop(1,1,world.maxx,world.maxy) //Match it to the world size.
	for(var/x=1,x<=world.maxx,x++)
		for(var/y=1,y<=world.maxy,y++)
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

			CHECK_TICK_HARD

	to_chat("Found [found_tiles] tiles, with [error_tiles] errored tiles.")
	to_chat("Icon: [new/image(I)].")
	src << ftp(I,"map_[src.mob.z].png")
*/

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
		if(F.is_occupied(PLANE_MOVABLE))
			continue
		possible_NT += F

	for(var/turf/simulated/floor/F in range(src.view*0.4,S_T))
		if(F.is_occupied(PLANE_MOVABLE))
			continue
		possible_SY += F

	for(var/i=1,i<=20,i++)
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


/client/verb/print_garbage()

	set category = "Debug"
	set name = "Print Garbage Collection"

	if(!length(qdel_refs_to_type))
		src.to_chat("Nothing has been found in the garbage collection system.")
		return TRUE

	var/final_text = ""

	var/datum/dummy_datum = new

	var/newest_ref_number = text2num("\ref[dummy_datum]",16)

	var/bad_qdels = 0
	for(var/ref_id in qdel_refs_to_type)
		var/o_type = qdel_refs_to_type[ref_id]
		var/datum/D = locate(ref_id)
		if(!D || D.type != o_type || !D.qdeleting)
			qdel_refs_to_type -= ref_id
			continue
		var/current_ref_number = text2num("\ref[D]",16)
		if(newest_ref_number < current_ref_number)
			continue
		var/var_edit_text = "<a href=?var_edit_ref=[ref_id]>[ref_id]</a>"
		final_text += "<br>[var_edit_text]([o_type])"
		bad_qdels++

	final_text = "<h1>Found [bad_qdels] objects that refused to be deleted.</h1>[final_text]"

	src << browse("<head><style>[STYLESHEET]</style></head><body>[final_text]</body>","window=garbage")

	qdel(dummy_datum)

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
				mobdata.save_character(P)
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

	for(var/turf/simulated/floor/S in range(VIEW_RANGE + ZOOM_RANGE,mob))
		if(!S.can_move_to())
			continue
		valid_turfs += S

	var/list/spawned_mobs = list()

	for(var/i=1,i<=50,i++)
		CHECK_TICK(50,FPS_SERVER)
		var/mob/living/advanced/npc/nanotrasen/ST = new(pick(valid_turfs))
		INITIALIZE(ST)
		GENERATE(ST)
		FINALIZE(ST)
		spawned_mobs += ST

	if(is_living(src.mob))
		for(var/k in spawned_mobs)
			var/mob/living/L = k
			if(L.ai)
				L.ai.set_move_objective(src.mob,astar=TRUE,follow=TRUE)


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

	var/mob/living/simple/xeno/queen/XQ = locate() in view(VIEW_RANGE,mob)

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

/client/verb/set_mob_to_null()
	set name = "Set Mob to Null (DANGER)"
	set category = "Debug"

	var/desired_input = input("Are you sure you want to set your mob to null? This exists to test a safety feature.","Set Mob to Null","Cancel") as null|anything in list("Yes","No","Cancel")

	if(desired_input == "Yes")
		mob.ckey = null
		mob = null
	else
		to_chat(span("notice","You decide not to do anything."))

/client/verb/add_loadout_to_mob()
	set name = "Add Loadout to Mob"
	set category = "Debug"

	var/list/possible_mobs = list()
	for(var/mob/living/advanced/A in view(VIEW_RANGE,src))
		possible_mobs += A

	for(var/mob/living/advanced/A in all_mobs_with_clients)
		possible_mobs |= A

	possible_mobs += "Cancel"

	var/mob/living/advanced/desired_mob = input("What mob would you like to give a loadout to?","Loadout Mob","Cancel") as null|anything in possible_mobs
	if(!desired_mob || desired_mob == "Cancel")
		to_chat(span("notice","You decide not to give a mob a loadout."))
		return FALSE

	var/loadouts_with_cancel = all_loadouts.Copy()
	loadouts_with_cancel["Cancel"] = "Cancel"

	var/desired_loadout = input("What loadout would you like to add to [desired_mob.name]?","Loadout Mob","Cancel") as null|anything in loadouts_with_cancel
	if(!desired_loadout || desired_loadout == "Cancel")
		to_chat(span("notice","You decide not to give a mob a loadout."))
		return FALSE

	desired_mob.equip_loadout(desired_loadout)

	log_admin("[src.get_debug_name()] gave a loadout ([desired_loadout]) to [desired_mob.get_debug_name()].")

/client/verb/force_save_deathbox()
	set name = "Force Save Deathboxes"
	set category = "Debug"
	save_deathboxes()

/client/verb/force_load_deathbox()
	set name = "Force Load Deathbox"
	set category = "Debug"

	if(!is_player(mob))
		return FALSE

	var/mob/living/advanced/player/P = mob
	load_deathbox(P,null)

/client/verb/force_save_banks()
	set name = "Force Save Banks"
	set category = "Debug"
	save_banks()


/client/verb/test_ranged_weapons()
	set name = "Test Ranged Weapons"
	set category = "Debug"

	var/turf/T = get_turf(mob)

	for(var/k in subtypesof(/obj/item/weapon/ranged))
		var/obj/item/weapon/ranged/R = k
		if(initial(R.value) <= 0)
			continue
		R = new R(T)
		INITIALIZE(R)
		GENERATE(R)
		FINALIZE(R)

/client/verb/debug_flash()
	set name = "Flash Self"
	set category = "Debug"

	if(!is_living(mob))
		return FALSE

	var/mob/living/L = mob
	L.flash(SECONDS_TO_DECISECONDS(10))
	L.bang(SECONDS_TO_DECISECONDS(10))


/client/verb/test_astar()
	set name = "Test AStar"
	set category = "Debug"

	var/turf/start = get_turf(mob)

	if(!start)
		return FALSE

	var/list/possible_living = list()
	for(var/mob/living/L in range(mob,VIEW_RANGE))
		if(L == mob)
			continue
		possible_living += L

	if(!length(possible_living))
		return FALSE

	var/turf/end = get_turf(pick(possible_living))

	var/list/found_path = AStar_Circle(start,end,mob)

	if(!length(found_path))
		to_chat(span("notice","Can not find a path to [end.get_debug_name()]."))
	else
		to_chat(span("notice","Found [length(found_path)] tiles in path."))

	for(var/k in found_path)
		var/turf/T = k
		T.color = "#FF0000"

	return TRUE

/client/verb/set_attribute(var/mob/mob as mob)

	set name = "Set Attribute Level"
	set category = "Debug"

	if(!is_living(mob))
		return
	var/mob/living/L = mob

	var/list/valid_choices = list()

	for(var/k in L.attributes)
		valid_choices += k

	var/chosen_attribute = input("Which attribute do you wish to modify?","Modify Attribute") as null|anything in valid_choices

	if(!chosen_attribute)
		return

	var/chosen_value = input("Which value do you wish to set [chosen_attribute] to?","Modify Attribute") as num|null

	if(!chosen_value)
		return

	var/old_level = L.get_attribute_level(chosen_attribute)

	L.set_attribute_level(chosen_attribute,chosen_value)

	to_chat(span("notice","Your [chosen_attribute] is now [L.get_attribute_level(chosen_attribute)]."))

	log_admin("[src.get_debug_name()] set [L.get_debug_name()]'s  [chosen_attribute] from [old_level] to [chosen_value].")


/client/verb/set_skill(var/mob/mob as mob)

	set name = "Set Skill Level"
	set category = "Debug"

	if(!is_living(mob))
		return
	var/mob/living/L = mob

	var/list/valid_choices = list()

	for(var/k in L.skills)
		valid_choices += k

	var/chosen_skill = input("Which skill do you wish to modify?","Modify Skill") as null|anything in valid_choices

	if(!chosen_skill)
		return

	var/chosen_value = input("Which value do you wish to set [chosen_skill] to?","Modify Skill") as num|null

	if(!chosen_value)
		return

	var/old_level = L.get_skill_level(chosen_skill)

	L.set_skill_level(chosen_skill,chosen_value)

	to_chat(span("notice","Your [chosen_skill] is now [L.get_skill_level(chosen_skill)]."))

	log_admin("[src.get_debug_name()] set [L.get_debug_name()]'s  [chosen_skill] from [old_level] to [chosen_value].")


/client/verb/horde_test_preview()

	set name = "Horde Test Preview (DANGER)"
	set category = "Debug"

	var/desired_choice = input("Are you sure you wish to start the Horde Test preview? This cannot be reversed.","Horde Test Preview","Cancel") as null|anything in list("Yes","No","Cancel")

	if(desired_choice != "Yes")
		return

	var/confirmation = input("Type \"CONFIRM\" to confirm you wish to start a Horde Test Prewiew.") as text

	if(confirmation != "CONFIRM")
		return

	var/time_to_stop = world.time + SECONDS_TO_DECISECONDS(240)

	var/turf/target_turf = pick(horde_test_target_turfs)

	if(mob) mob.force_move(target_turf)

	if(is_observer(mob))
		var/mob/abstract/observer/O = mob
		O.show_hud(FALSE)

	for(var/k in horde_test_survivor_spawn_turfs)
		var/turf/T = k
		var/mob/living/advanced/npc/bandit/S = new(T)
		INITIALIZE(S)
		GENERATE(S)
		FINALIZE(S)
		if(S.ai)
			S.ai.set_active(TRUE)

	var/list/tracked_zombies = list()
	spawn while(world.time <= time_to_stop)
		for(var/k in tracked_zombies)
			var/mob/living/advanced/npc/zombie/normal/Z = k
			if(Z.dead) tracked_zombies -= Z
		sleep(SECONDS_TO_DECISECONDS(5))
		if(length(tracked_zombies) >= 8)
			continue
		var/turf/T = pick(horde_test_turfs)
		var/mob/living/advanced/npc/zombie/normal/Z = new(T)
		INITIALIZE(Z)
		GENERATE(Z)
		FINALIZE(Z)
		if(Z.ai)
			Z.ai.set_move_objective(target_turf)
		tracked_zombies += Z


/client/verb/test_rust_g()
	set name = "Test rust-g"
	set category = "Debug"
	src.to_chat(span("notice","rust-g version: [rustg_get_version()]"))
	var/noise_result = rustg_noise_get_at_coordinates("[rand(1,10000)]","0.5","0.5")
	src.to_chat(span("notice","Example noise: [noise_result]"))



/client/verb/debug_current_chunk()
	set name = "Debug Current Chunk"
	set category = "Debug"

	var/turf/T = get_turf(mob)
	var/chunk/C = CHUNK(T)

	debug_variables(C)


/client/verb/debug_weapon_value()
	set name = "Debug Weapon Value"
	set category = "Debug"

	var/desired_path = input("Please enter the desired path to debug.","Debug Weapon Value","/obj/item/weapon") as null|text
	if(!desired_path)
		return

	var/found_path = text2path(desired_path)
	if(!found_path)
		src.to_chat(span("notice","[desired_path] is not a valid path."))
		return

	if(!ispath(found_path,/obj/item/weapon/))
		src.to_chat(span("notice","[desired_path] is not a valid weapon path."))
		return

	var/obj/item/weapon/W = new found_path(get_turf(mob))
	INITIALIZE(W)
	GENERATE(W)
	FINALIZE(W)

	W.get_recommended_value(debug=TRUE)

	qdel(W)

/client/verb/swarm_test()
	set name = "Swarm Test"
	set category = "Debug"

	var/list/offset = direction_to_pixel_offset(mob.dir)

	var/ai/master_ai
	for(var/i=1,i<=8,i++)
		var/turf/T = locate(mob.x + offset[1]*8 + round(pick(-i,i)*0.5,1), mob.y + offset[2]*8 + round(pick(-i,i)*0.5,1), mob.z)
		if(T)
			var/mob/living/simple/xeno/hunter/M = new(T)
			M.dir = mob.dir
			INITIALIZE(M)
			GENERATE(M)
			FINALIZE(M)
			if(!master_ai)
				master_ai = M.ai
			else
				M.ai.set_master_ai(master_ai)
			M.ai.set_active(TRUE)


/client/verb/subsystem_debug()
	set name = "Subsystem Debug"
	set category = "Debug"

	var/list/valid_choices = list()

	for(var/k in active_subsystems)
		var/subsystem/S = k
		valid_choices["[S.priority]: [S.name]"] = S

	valid_choices["Cancel"] = "Cancel"

	var/choice = input("What Subsystem would you like to debug?","Subsystem Debug","Cancel") as null|anything in valid_choices

	if(!choice || choice == "Cancel")
		return FALSE

	var/subsystem/S = valid_choices[choice]
	debug_variables(S)
