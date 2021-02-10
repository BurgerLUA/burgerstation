/client/verb/speed_up_setup()

	set name = "Speed up Setup"
	set category = "GameMaster"

	if(!SSgamemode || !SSgamemode.active_gamemode)
		to_chat(span("warning","The gamemode is still being setup!"))
		return FALSE

	SSgamemode.active_gamemode.round_time = 1000000

	log_admin("[src.get_debug_name()] sped up setup.")


/client/verb/force_random_event()
	set name = "Force Random Event"
	set category = "GameMaster"

	var/confirm = input("Are you sure you want to trigger a random event?","Random Event Trigger.") in list("Yes","No","Cancel")|null

	if(confirm != "Yes")
		return FALSE

	SSevents.next_event_time = 0

	log_admin("[src.get_debug_name()] forced a random event.")

/client/verb/force_specific_event()
	set name = "Force Specific Event"
	set category = "GameMaster"

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
	set category = "GameMaster"

	var/gamemode/G = SSgamemode.active_gamemode

	var/points_to_add = input("How many points would you like to add? Current: [G.points].","Add points.",0) as num
	G.points += points_to_add

	log_admin("[src.get_debug_name()] added [points_to_add] points to current gamemode.")


/client/verb/spawn_from_path(var/object as text) //TODO: Make this work.
	set name = "Spawn Object"
	set desc = "Spawn an object."
	set category = "GameMaster"

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

	if(valid_count == 1)
		var/datum/A = valid_objects[1]
		A = new A(usr.loc)
		INITIALIZE(A)
		GENERATE(A)
		FINALIZE(A)
		return TRUE

	var/selection = input("Spawn object.","Spawn object") as null|anything in valid_objects

	if(!selection)
		return FALSE

	var/datum/A = selection
	A = new A(usr.loc)
	INITIALIZE(A)
	FINALIZE(A)
	if(isobj(A))
		var/obj/O = A
		GENERATE(O)

	log_admin("[src.get_debug_name()] spawned [A.get_debug_name()].")

	return TRUE




/client/verb/smite_living()

	set name = "Smite Living"
	set category = "GameMaster"

	var/list/valid_targets = list()

	for(var/k in all_players)
		valid_targets += k

	for(var/mob/living/L in view(src.mob,VIEW_RANGE))
		valid_targets |= L

	var/mob/living/L = input("What do you wish to crush?","Crush Target") as null|anything in valid_targets

	if(!L) return FALSE

	var/confirm = input("Are you sure you want to crush [L.name]? This will kill them instantly...","Cursh Confirmation","Cancel") as null|anything in list("Yes","No","Cancel")

	if(confirm != "Yes") return FALSE

	var/turf/T = get_turf(L)
	play_sound('sound/meme/cbt.ogg',T)
	CALLBACK("\ref[L]_smite",15,L,/mob/living/proc/smite)

	log_admin("[L.get_debug_name()] was smited by [src.get_debug_name()].")


/client/verb/give_dosh(var/dosh_amount as num)
	set name = "Give Dosh"
	set category = "GameMaster"

	var/mob/living/advanced/player/P = input("Who do you want to give money to?") in all_players as mob|null

	if(!P)
		return FALSE

	var/added_currency = P.adjust_currency(dosh_amount)
	to_chat(span("notice","You gave [P.name] [added_currency] credits."))

	log_admin("[src.get_debug_name()] gave [P.get_debug_name()] [added_currency] credits.")

/client/verb/set_attribute(var/mob/mob as mob)

	set name = "Set Attribute Level"
	set category = "GameMaster"

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

	chosen_value = chosen_value

	L.set_attribute_level(chosen_attribute,chosen_value)

	to_chat(span("notice","Your [chosen_attribute] is now [L.get_attribute_level(chosen_attribute)]."))


/client/verb/set_skill(var/mob/mob as mob)

	set name = "Set Skill Level"
	set category = "GameMaster"

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

	chosen_value = chosen_value

	L.set_skill_level(chosen_skill,chosen_value)

	to_chat(span("notice","Your [chosen_skill] is now [L.get_skill_level(chosen_skill)]."))

/client/verb/rejuvenate_player()
	set name = "Rejuvenate Player"
	set category = "GameMaster"

	var/mob/living/advanced/player/P = input("Who do you want to rejuvenate?","Player Rejuvenation") in all_players as mob|null

	if(!P)
		return FALSE

	P.resurrect()
	to_chat(span("notice","You rejuvenated [P.name]."))

	log_admin("[src.get_debug_name()] rejuvenated [P.get_debug_name()].")

/client/verb/force_round_end()
	set name = "Force Round End (DANGER)"
	set category = "GameMaster"

	var/confirm = input("Are you sure you want to end the round in a NanoTrasen Victory?","NanoTrasen Victory") in list("Yes","No","Cancel")|null

	if(confirm != "Yes")
		return FALSE

	world.end(WORLD_END_NANOTRASEN_VICTORY,FALSE)

	log_admin("[src.get_debug_name()] forced the round to end.")


/client/verb/ic_announcement()

	set name = "Make IC Announcement"
	set category = "GameMaster"

	var/sender = input("Who should the sender be?","Message Sender") as text | null
	if(!sender)
		return FALSE

	var/message = input("What should the message be?", "Message") as message | null
	if(!message)
		return FALSE

	var/header = input("What should the header be?", "Message Header") as text | null
	if(!header)
		return FALSE

	announce(sender,header,message,ANNOUNCEMENT_STATION,'sound/alert/airplane.ogg')

	log_admin("[src.get_debug_name()] made an IC announcement from [sender].")

	return TRUE

/client/verb/test_spook_station()
	set name = "Spook Station (DANGER)"
	set category = "GameMaster"

	var/confirm = input("Are you sure you wish to spook the station? This will kill all lights, batton all hatches, and stun everyone on board.","Oh god oh fuck.") as null|anything in list("Yes","No","Cancel")

	if(confirm != "Yes")
		return FALSE

	spook_station()

	log_admin("[src.get_debug_name()] spooked the station.")

	return TRUE

/proc/spook_station() //Lockdown everything, kill lights, ect.

	for(var/k in subtypesof(/area/burgerstation))
		CHECK_TICK(75,FPS_SERVER)
		var/area/A = AREA(k)
		if(!A) continue
		var/list/valid_hearers = list()
		for(var/mob/living/L in A.contents)
			CHECK_TICK(90,FPS_SERVER)
			L.add_status_effect(STUN,40,40)
			if(L.client)
				valid_hearers += L
				L.client.queued_shakes += 10
		play_sound_global('sound/effects/explosion/explosion_far.ogg',valid_hearers)
		for(var/obj/structure/interactive/lighting/T in A.contents)
			CHECK_TICK(75,FPS_SERVER)
			T.on_destruction(null,TRUE)
		for(var/obj/structure/interactive/door/alarm/D in A.contents)
			CHECK_TICK(75,FPS_SERVER)
			D.close(null,TRUE,TRUE)

/client/verb/test_syndicate_raid()
	set name = "Syndicate Raid (DANGER)"
	set category = "GameMaster"

	var/confirm = input("Are you sure you wish to raid the station? This will kill all lights, batton all hatches, and stun everyone on board.","Oh god oh fuck.") as null|anything in list("Yes","No","Cancel")
	if(confirm != "Yes")
		return FALSE

	var/gamemode/G = SSgamemode.active_gamemode

	if(!G)
		to_chat(span("warning","The game isn't setup yet!"))
		return FALSE

	G.points = min(G.points,15)
	G.handle_alert_level()

	log_admin("[src.get_debug_name()] forced a syndicate raid.")

/proc/raid_station()
	var/obj/shuttle_controller/syndicate_raid/SR = locate() in world
	var/area/A = get_area(SR)
	if(A.type == /area/transit/syndicate_raid/ship)
		log_error("Tried calling raid_station() despite it already being raided.")
		return FALSE
	SR.launch()


/client/verb/force_vote()
	set name = "Force Vote End"
	set category = "GameMaster"

	for(var/k in SSvote.active_votes)
		var/vote/V = k
		qdel(V)

	log_admin("[src.get_debug_name()] forced all votes to end.")


/client/verb/add_language()
	set name = "Add Language"
	set category = "GameMaster"

	var/mob/living/advanced/player/P = input("Who do you want to add a language to?","Add Language") in all_players as mob|null

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
	set category = "GameMaster"

	var/mob/living/advanced/player/P = input("Who do you want to remove a language from?","Remove Language") in all_players as mob|null

	if(!P)
		return FALSE

	var/list/valid_languages = list()

	for(var/k in P.known_languages)
		var/language/L = SSlanguage.all_languages[k]
		valid_languages += L

	var/language/L = input("What language do you wish to remvoe from \the [P.name]?","Remove Language") as null|anything in valid_languages

	if(!L)
		return FALSE

	P.known_languages -= L.id

	log_admin("[src.get_debug_name()] removed the language [L.get_debug_name()] to [P.get_debug_name()].")

	return TRUE