/client/verb/jump_to_player()
	set name = "Jump to Player"
	set category = "View"

	sortTim(all_mobs_with_clients,/proc/cmp_path_asc)

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
	log_admin("[src] jumped to [choice]'s (mob) location.")

/client/verb/jump_to_mob()
	set name = "Jump to Mob"
	set category = "View"

	sortTim(all_mobs,/proc/cmp_path_asc)

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
	log_admin("[src] jumped to [choice]'s (mob) location.")

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