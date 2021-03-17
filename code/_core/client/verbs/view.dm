/client/verb/jump_to_player()
	set name = "Jump to Player"
	set category = "View"

	//sortTim(all_mobs_with_clients,/proc/cmp_path_asc)

	var/mob/choice = input("Who would you like to jump to?","Jump to Mob") as null|mob in all_mobs_with_clients
	if(!choice || choice == mob)
		to_chat(span("warning","Invalid mob."))
		return FALSE

	var/turf/T = get_turf(choice)
	if(!T)
		to_chat(span("warning","Invalid turf."))
		return FALSE

	mob.force_move(T)

	to_chat(span("notice","You jumped to [choice]'s location."))
	if(is_living(mob))
		log_admin("[src.get_debug_name()] jumped to [choice.get_debug_name()]'s (mob) location.")

/client/verb/jump_to_mob()
	set name = "Jump to Mob"
	set category = "View"

	//sortTim(all_mobs,/proc/cmp_path_asc)

	var/mob/choice = input("Who would you like to jump to?","Jump to Mob") as null|mob in all_mobs
	if(!choice || choice == mob)
		to_chat(span("warning","Invalid mob."))
		return FALSE

	var/turf/T = get_turf(choice)
	if(!T)
		to_chat(span("warning","Invalid turf."))
		return FALSE

	mob.force_move(T)

	to_chat(span("notice","You jumped to [choice]'s location."))
	if(is_living(mob))
		log_admin("[mob.get_debug_name()] jumped to [choice.get_debug_name()]'s location.")

/client/verb/jump_to_client()

	set name = "Jump to Client"
	set category = "View"

	var/valid_choices = list()
	for(var/k in all_mobs_with_clients)
		var/mob/M = k
		if(!M.client)
			continue
		valid_choices[M.client] = M
	valid_choices["Cancel"] = "Cancel"

	var/choice = input("Which client do you wish to jump to?","Jump to Client","Cancel") as null|anything in valid_choices

	if(!choice || choice == "Cancel")
		src.to_chat(span("notice","You decide not to jump to anyone."))
		return FALSE

	var/mob/M = valid_choices[choice]

	if(!M)
		src.to_chat(span("warning","Invalid mob."))
		return FALSE

	var/turf/T = get_turf(M)

	if(!T)
		src.to_chat(span("warning","Invalid turf."))
		return FALSE

	mob.force_move(T)

	to_chat(span("notice","You jumped to [M.client]'s location."))
	if(is_living(mob))
		log_admin("[src.get_debug_name()] jumped to [M.get_debug_name()]'s location.")

/client/verb/orbit_player()
	set name = "Orbit Player"
	set category = "View"

	//sortTim(all_mobs_with_clients,/proc/cmp_path_asc)

	var/mob/choice = input("Who would you like to orbit?","Orbit Mob") as null|mob in all_mobs_with_clients
	if(!choice || choice == mob)
		to_chat(span("warning","Invalid mob."))
		return FALSE

	var/turf/T = get_turf(choice)
	if(!T)
		to_chat(span("warning","Invalid turf."))
		return FALSE

	if(is_living(mob))
		to_chat(span("warning","Cannot orbit as a living mob."))
		return FALSE

	if(mob.observing)
		mob.observing.observers -= src
		mob.observing = null

	mob.force_move(T)
	choice.observers |= mob
	mob.observing = choice

	to_chat(span("notice","You orbit [choice]."))

/client/verb/orbit_mob()
	set name = "Orbit Mob"
	set category = "View"

	//sortTim(all_mobs,/proc/cmp_path_asc)

	var/mob/choice = input("Who would you like to orbit?","Orbit Mob") as null|mob in all_mobs
	if(!choice || choice == mob)
		to_chat(span("warning","Invalid mob."))
		return FALSE

	var/turf/T = get_turf(choice)
	if(!T)
		to_chat(span("warning","Invalid turf."))
		return FALSE

	if(is_living(mob))
		to_chat(span("warning","Cannot orbit as a living mob."))
		return FALSE

	if(mob.observing)
		mob.observing.observers -= src
		mob.observing = null

	mob.force_move(T)
	choice.observers += mob
	mob.observing = choice

	to_chat(span("notice","You orbit [choice]."))

/client/verb/jump_to_area()
	set name = "Jump to Area"
	set category = "View"

	var/list/coverted_choice = list()
	for(var/k in SSarea.all_areas)
		var/area/A = SSarea.all_areas[k]
		coverted_choice["[A]"] = A

	var/choice = input("What area would you like to jump to?","Jump to Area") as null|anything in coverted_choice
	if(!choice)
		to_chat(span("warning","Invalid area."))
		return FALSE

	var/area/A = coverted_choice[choice]

	var/turf/T = locate(A.average_x,A.average_y,A.z)
	if(!T)
		to_chat(span("warning","Invalid turf."))
		return FALSE

	mob.force_move(T)

	to_chat(span("notice","You jumped to [A]'s location."))
	log_admin("[src] jumped to [A]'s (area) location.")


/client/verb/adjust_nightvision()
	set name = "Adjust Nightvision"
	set category = "View"

	if(!mob)
		return FALSE

	var/desired_nightvision = input("What is your desired lighting alpha? (0 to 255)","Lighting Alpha",mob.lighting_mods["verb"] ? mob.lighting_mods["verb"] : 255) as null|num

	if(isnum(desired_nightvision))
		desired_nightvision = clamp(desired_nightvision,0,254)
		mob.add_lighting_mod("verb",desired_nightvision)
	else
		mob.remove_lighting_mod("verb")
