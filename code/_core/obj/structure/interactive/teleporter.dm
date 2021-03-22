/obj/structure/interactive/teleporter
	name = "teleporter"
	desc = "Beam me up Scotty!"
	desc_extended = "A machine that is used for sending down or bringing up stuff through the power of nearly instantaneous molecular relaying."
	icon = 'icons/obj/structure/telesciencepads.dmi'
	icon_state = "pad-idle"
	var/teleport_cooldown = 0

/obj/structure/interactive/teleporter/clicked_on_by_object(mob/caller, atom/object, location, control, params)

	INTERACT_CHECK
	INTERACT_DELAY(10)
	SPAM_CHECK(10)

	if(!SSgamemode.active_gamemode.allow_launch)
		caller.to_chat(span("warning","The teleporter is still setting up, wait until given permission!"))
		return FALSE
	if(teleport_cooldown > world.time)
		caller.to_chat(span("warning","The teleporter is still on cooldown, wait some time before using it again!"))
		return FALSE
	if(!length(gps_list))
		caller.to_chat(span("warning","There are no active GPS currently, try again later!"))
		return FALSE
	var/choice1 = input("Send or Receive?", "Teleport Direction") in list("Send", "Receive", "Cancel")|null
	if(choice1 == "Cancel")
		caller.to_chat(span("notice","You decided against using the teleporter."))
		return FALSE
	var/obj/item/analyzer/gps/choice2 = input("Select the GPS for coordinates.", "GPS Selection") as null|anything in gps_list
	if(!choice2)
		return
	if(choice2.need_password)
		var/passwordcheck = input("Enter the password for this GPS.","GPS Password Entry") as null|text
		if(passwordcheck != choice2.assigned_number)
			caller.to_chat(span("notice","You entered the wrong password."))
			return FALSE
	var/turf/gpsTURF = get_turf(choice2)
	var/turf/srcTURF = get_turf(src)
	var/turf/callerTURF = get_turf(caller)
	if(!gpsTURF)
		caller.to_chat(span("warning","The GPS is currently not available, try again later!"))
		return FALSE
	if(teleport_cooldown > world.time)
		return FALSE
	if(get_dist(srcTURF, callerTURF) > 1)
		return FALSE
	var/item_counter = 0
	var/second_cooldown = 0
	switch(choice1)
		if("Send")
			for(var/atom/movable/A in srcTURF.contents)
				if(item_counter >= 25)
					break
				if(A.anchored)
					continue
				if(is_living(A))
					var/mob/living/aLiving = A
					if(aLiving.boss)
						continue
					if(aLiving.immortal)
						continue
					if(aLiving.ckey)
						second_cooldown += 15
					second_cooldown += 3
				if(istype(A, /obj/structure/interactive/crate))
					second_cooldown += 8
				play_sound('sound/effects/sparks4.ogg',get_turf(A),range_max=VIEW_RANGE)
				A.force_move(gpsTURF)
				play_sound('sound/effects/sparks4.ogg',get_turf(A),range_max=VIEW_RANGE)
				item_counter++
				second_cooldown += 2
		if("Receive")
			for(var/atom/movable/A in gpsTURF.contents)
				if(item_counter >= 25)
					break
				if(A.anchored)
					continue
				if(is_living(A))
					var/mob/living/aLiving = A
					if(aLiving.boss)
						continue
					if(aLiving.immortal)
						continue
					if(aLiving.ckey)
						second_cooldown += 15
					second_cooldown += 3
				if(istype(A, /obj/structure/interactive/crate))
					second_cooldown += 8
				play_sound('sound/effects/sparks4.ogg',get_turf(A),range_max=VIEW_RANGE)
				A.force_move(srcTURF)
				play_sound('sound/effects/sparks4.ogg',get_turf(A),range_max=VIEW_RANGE)
				item_counter++
				second_cooldown += 2
	teleport_cooldown = world.time + SECONDS_TO_DECISECONDS(second_cooldown)
	flick(icon, "pad-beam")
