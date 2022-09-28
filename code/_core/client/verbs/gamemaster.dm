/client/verb/speed_up_setup()

	set name = "Speed up Setup"
	set category = "Admin"

	if(!SSgamemode || !SSgamemode.active_gamemode)
		to_chat(span("warning","The gamemode is still being setup!"))
		return FALSE

	SSgamemode.active_gamemode.round_time = 1000000

	log_admin("[src.get_debug_name()] sped up setup.")

/client/verb/force_specific_event()
	set name = "Force Specific Event"
	set category = "Fun"

	var/list/refactored_list = list()

	for(var/k in SSevents.all_events)
		var/event/E = SSevents.all_events[k]
		refactored_list["[E]"] = E

	sortTim(refactored_list,/proc/cmp_path_asc)

	var/desired_event = input("What event would you like to run?","Event Manager") as null|anything in refactored_list

	if(!desired_event)
		return FALSE

	var/event/E = refactored_list[desired_event]

	SSevents.trigger_event(E)

	log_admin("[src.get_debug_name()] triggered a specific event ([E.name]).")


/client/verb/add_points()

	set name = "Add Gamemode Points"
	set category = "Fun"

	var/gamemode/G = SSgamemode.active_gamemode

	var/points_to_add = input("How many points would you like to add? Current: [G.points].","Add points.",0) as num
	G.points += points_to_add

	log_admin("[src.get_debug_name()] added [points_to_add] points to current gamemode.")


/client/verb/spawn_from_path(var/object as text) //TODO: Make this work.
	set name = "Spawn Object"
	set desc = "Spawn an object."
	set category = "Fun"

	if(!object)
		return FALSE

	if(object[1] != "/")
		object = "/" + object

	var/last_checker = copytext(object,-1,0)
	if(last_checker == "/")
		object = copytext(object,1,-1)

	var/valid_path = text2path(object)

	if(!valid_path)
		src.to_chat(span("warning","\"[object]\" isn't a valid path."))
		return FALSE

	var/list/valid_objects = typesof(valid_path)

	var/valid_count = length(valid_objects)

	if(!valid_count)
		src.to_chat(span("warning","\"[object]\" returned no valid types."))
		return FALSE

	var/selection
	if(valid_count != 1)
		selection = input("Spawn object.","Spawn object") as null|anything in valid_objects
		if(!selection)
			return FALSE
	else
		selection = valid_objects[1]

	var/turf/T
	if(mob)
		T = get_step(src.mob,src.mob.dir)
	if(!T)
		T = get_turf(src.mob)

	var/atom/A = selection
	A = new A(T)
	INITIALIZE(A)
	if(is_atom(A))
		var/atom/O = A
		O.set_dir(mob ? mob.dir : SOUTH)
		GENERATE(O)
	FINALIZE(A)

	log_admin("[src.get_debug_name()] spawned [A.get_debug_name()].")

	return TRUE




/client/verb/smite_living(var/mob/living/target)

	set name = "Smite Living"
	set category = "Fun"

	var/mob/living/L

	if(!target)
		var/list/valid_targets = list()

		for(var/k in all_players)
			valid_targets += k

		for(L in view(src.mob,VIEW_RANGE))
			valid_targets |= L

		L = input("What do you wish to crush?","Crush Target") as null|anything in valid_targets

		if(!L) return FALSE

	else L = target

	var/confirm = input("Are you sure you want to crush [L.name]? This will kill them instantly...","Cursh Confirmation","Cancel") as null|anything in list("Yes","No","Cancel")

	if(confirm != "Yes") return FALSE

	var/turf/T = get_turf(L)
	play_sound('sound/meme/cbt.ogg',T)
	CALLBACK("\ref[L]_smite",15,L,/mob/living/proc/smite)

	log_admin("[L.get_debug_name()] was smited by [src.get_debug_name()].")


/client/verb/break_bones(var/mob/living/advanced/target)

	set name = "Break Bones"
	set category = "Fun"

	var/mob/living/advanced/L

	if(!target)
		var/list/valid_targets = list()

		for(var/k in all_players)
			valid_targets += k

		for(L in view(src.mob,VIEW_RANGE))
			valid_targets |= L

		L = input("Who do you wish to break?","Break Target") as null|anything in valid_targets

		if(!L) return FALSE

	else
		L = target

	var/confirm = input("Are you sure you want to break all the bones in [L.name]\s body? This will hurt...","Break Confirmation","Cancel") as null|anything in list("Yes","No","Cancel")

	if(confirm != "Yes") return FALSE

	for(var/k in L.labeled_organs)
		var/obj/item/organ/O = L.labeled_organs[k]
		O.break_bone(FALSE,FALSE)

	L.visible_message(span("danger","Every bone in [L.name]'s body breaks!"),span("danger","Every bone in your body breaks!"))
	play_sound('sound/effects/bone_crack.ogg',get_turf(L))

	log_admin("[L.get_debug_name()] was broken by [src.get_debug_name()].")

/client/verb/give_credits(var/dosh_amount as num)
	set name = "Give Credits"
	set category = "Cheat"

	var/mob/living/advanced/player/P = input("Who do you want to give money to?") as null|mob in all_players

	if(!P)
		return FALSE

	var/added_currency = P.adjust_currency(dosh_amount)
	to_chat(span("notice","You gave [P.name] [added_currency] credits."))

	log_admin("[src.get_debug_name()] gave [P.get_debug_name()] [added_currency] credits.")

/client/verb/rejuvenate()
	set name = "Rejuvenate Player"
	set category = "Admin"

	var/list/valid_players = list()

	for(var/mob/living/L in all_mobs_with_clients)
		if(!L.ckey)
			continue
		var/final_name = "[L.name][L.dead ? "(DEAD)" : ""]"
		valid_players[final_name] = L

	valid_players["Cancel"] = "Cancel"

	var/choice = input("Who do you want to rejuvenate?","Player Rejuvenation") as null|anything in valid_players

	if(!choice || choice == "Cancel")
		to_chat(span("notice","You decide not to revive anyone."))
		return FALSE

	var/mob/living/L = valid_players[choice]

	if(!L) return FALSE

	if(!L.ckey_last)
		src.to_chat(span("danger","This player is currently not in this corpse anymore."))
		return FALSE

	L.resurrect()
	to_chat(span("notice","You rejuvenated [L.name]."))

	log_admin("[src.get_debug_name()] rejuvenated [L.get_debug_name()].")

/client/verb/force_round_end()
	set name = "Force Round End (DANGER)"
	set category = "Admin"

	var/confirm = input("Are you sure you want to end the round in a NanoTrasen Victory?","NanoTrasen Victory") in list("Yes","No","Cancel")|null

	if(confirm != "Yes")
		return FALSE

	world.end(WORLD_END_NANOTRASEN_VICTORY,FALSE)

	log_admin("[src.get_debug_name()] forced the round to end.")


/client/verb/ic_announcement()

	set name = "Make IC Announcement"
	set category = "Fun"

	var/sender = input("Who should the sender be?","Message Sender") as text | null
	if(!sender)
		return FALSE

	var/message = input("What should the message be?", "Message") as message | null
	if(!message)
		return FALSE

	var/header = input("What should the header be?", "Message Header") as text | null
	if(!header)
		return FALSE

	announce(sender,header,message,sound_to_play='sound/alert/airplane.ogg')

	log_admin("[src.get_debug_name()] made an IC announcement from [sender].")

	return TRUE


/client/verb/ooc_announcement()

	set name = "Make OOC Announcement"
	set category = "Admin"


	var/message = input("What should the message be?", "Message") as message | null
	if(!message)
		return FALSE

	broadcast_to_clients("<b>[src] announces:</b><p>&emsp;[message]</p>")

	log_admin("[src.get_debug_name()] made an OOC announcement: [message]")

	return TRUE

/client/verb/force_vote()
	set name = "Force Vote End"
	set category = "Admin"

	for(var/k in SSvote.active_votes)
		var/vote/V = k
		qdel(V)

	log_admin("[src.get_debug_name()] forced all votes to end.")


/client/verb/add_language()
	set name = "Add Language"
	set category = "Cheat"

	var/mob/living/advanced/player/P = input("Who do you want to add a language to?","Add Language") as null|mob in all_players

	if(!P)
		return FALSE

	var/list/valid_languages = list()

	for(var/k in SSlanguage.all_languages)
		var/language/L = SSlanguage.all_languages[k]
		valid_languages += L

	var/language/L = input("What language do you wish to add to \the [P.name]?","Add Language") as null|anything in valid_languages

	if(!L)
		return FALSE

	P.known_languages[L.id] = TRUE

	log_admin("[src.get_debug_name()] added the language [L.get_debug_name()] to [P.get_debug_name()].")

	return TRUE


/client/verb/remove_language()
	set name = "Remove Language"
	set category = "Cheat"

	var/mob/living/advanced/player/P = input("Who do you want to remove a language from?","Remove Language") as null|mob in all_players

	if(!P)
		return FALSE

	var/list/valid_languages = list()

	for(var/k in P.known_languages)
		var/language/L = SSlanguage.all_languages[k]
		valid_languages += L

	var/language/L = input("What language do you wish to remove from \the [P.name]?","Remove Language") as null|anything in valid_languages

	if(!L)
		return FALSE

	P.known_languages -= L.id

	log_admin("[src.get_debug_name()] removed the language [L.get_debug_name()] to [P.get_debug_name()].")

	return TRUE

/client/verb/create_explosion()
	set name = "Create Explosion"
	set category = "Fun"

	var/turf/T = get_turf(mob)

	var/desired_strength = input("What do you wish the explosion strength to be? Max: 10000","Explosion Strength",40) as num|null

	if(!desired_strength || desired_strength <= 0)
		return FALSE

	desired_strength = min(desired_strength,10000)

	log_admin("[src.get_debug_name()] created a [desired_strength] strength explosion at [T.get_debug_name()].")

	explode(T,desired_strength,mob,mob,"Admin")

/client/verb/rain_gold()
	set name = "Rain Gold"
	set category = "Fun"

	var/turf/T = get_turf(mob)

	if(T)
		create_gold_drop(T,100)

	log_admin("[src.get_debug_name()] made it rain gold at [T.get_debug_name()].")

/client/verb/safe_force_control()
	set name = "Safe Force Control"
	set category = "Fun"

	var/list/valid_bodies = list()

	for(var/mob/living/L in view(src.mob,VIEW_RANGE))
		valid_bodies |= L

	var/mob/living/desired_body = input("What body would you like to take control of?","Control Body") as null|anything in valid_bodies

	if(!desired_body)
		src.to_chat(span("notice","You decide not to take control of anyone."))
		return FALSE

	if(desired_body.ckey || desired_body.ckey_last)
		src.to_chat(span("warning","This body already has a soul!"))
		return FALSE

	var/C_ckey = input("Who do you want to take over the body?","Control Body") as null|anything in all_clients
	if(!C_ckey)
		src.to_chat(span("notice","You decide not to take control of anyone."))
		return FALSE

	var/client/C = CLIENT(C_ckey)

	if(!C || !istype(C.mob,/mob/abstract/observer/))
		src.to_chat(span("warning","This client is currently in control of a non-observer mob!"))
		return FALSE

	if(desired_body.ckey || desired_body.ckey_last) //Double checked.
		src.to_chat(span("warning","This body already has a soul!"))
		return FALSE

	if(is_player(desired_body))
		var/mob/living/advanced/player/P = desired_body
		if(!P.death_ckey || P.death_ckey != C.ckey)
			src.to_chat(span("warning","This body does not belong to this soul!"))
			return FALSE

	if(desired_body.ai)
		QDEL_NULL(desired_body.ai)

	C.control_mob(desired_body)

	src.to_chat(span("notice","You forced [C.ckey] to take control of [desired_body.name]."))

	log_admin("[src.get_debug_name()] safely forced [C.get_debug_name()] to take control of [desired_body.get_debug_name()].")


/client/verb/send_squad()
	set name = "Send Squad"
	set category = "Fun"

	var/desired_victim = input("Who would you like to send the squad towards?","Send Squad") as null|anything in all_players

	if(!desired_victim)
		return TRUE

	var/list/possible_squads = list(
		"Syndicate" = /mob/living/advanced/npc/syndicate,
		"Beefmen" = /mob/living/advanced/npc/beefman,
		"Xenos" = /mob/living/simple/xeno/drone,
		"Spacecarp" = /mob/living/simple/spacecarp/,
		"Abductors" = /mob/living/advanced/npc/abductor,
		"Ashwalkers" = /mob/living/advanced/npc/ashwalker/hunter,
		"Pirates" = /mob/living/advanced/npc/pirate_crew/ranged,
		"Revs" = /mob/living/advanced/npc/rev,
		"Space Soldiers" = /mob/living/advanced/npc/space_soldier,
		"Tax Collectors" = /mob/living/advanced/npc/tax_man,
		"Zombies" = /mob/living/advanced/npc/zombie/civilian,
		"Custom..." = "Custom...",
		"Cancel" = "Cancel"
	)

	var/desired_squad = input("What would you like to send?","Send Squad","Cancel") as null|anything in possible_squads

	if(!desired_squad || desired_squad == "Cancel")
		return FALSE

	if(desired_squad == "Custom...")
		desired_squad = input("Enter the path name of the mob that you'd like to send.","Send Squad") as null|text

		if(!desired_squad)
			return FALSE

		desired_squad = text2path(desired_squad)

		if(!ispath(desired_squad,/mob/))
			return FALSE

		desired_squad = text2path(desired_squad)
	else
		desired_squad = possible_squads[desired_squad]

	if(!SShorde.send_squad(desired_victim,desired_squad,bypass_restrictions=TRUE,debug=TRUE))
		src.to_chat(span("warning","Could not send a squad to this player. Could not find a valid path."))

