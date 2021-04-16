/obj/structure/interactive/vr_nuke
	name = "nuke"
	desc = "Bomb has been planted."
	desc_extended = "A powerful nuke. The Syndicate are supposed to move this to a special area while NanoTrasen are to prevent it from detonating."

	icon = 'icons/obj/structure/nuke.dmi'
	icon_state = "base"

	anchored = FALSE
	density = TRUE

	collision_flags = FLAG_COLLISION_WALL

	bullet_block_chance = 0

	var/state = 0
	//0 = idle
	//1 = unlocked
	//2 = armed
	//3 = disarmed
	//4 = exploded

	var/next_explode = -1

/obj/structure/interactive/vr_nuke/think()

	if(next_explode <= 0)
		return FALSE

	var/time_left = next_explode - world.time

	var/should_play = FALSE
	switch(time_left)
		if(0 to 100)
			should_play = TRUE
		if(100 to 200)
			should_play = !(1 % 5)
		if(200 to 300)
			should_play = !(1 % 10)

	if(should_play)
		play_sound('sound/effects/double_beep.ogg',get_turf(src))

	if(next_explode <= world.time)
		explode()
		return FALSE




	return TRUE













/obj/structure/interactive/vr_nuke/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/disk/nuke))
		INTERACT_CHECK
		INTERACT_DELAY(20)
		var/mob/living/L = caller

		if(L.loyalty_tag != "Syndicate")
			L.to_chat(span("notice","You don't know how to use this!"))
		else if(state == 0)
			unlock()
		else
			caller.to_chat(span("warning","\The [src.name] is already unlocked!"))

		return TRUE

	if(istype(object,/obj/hud/inventory))
		INTERACT_CHECK
		INTERACT_DELAY(20)
		if(state == 1) //Arm it!
			if(can_arm(caller))
				caller.visible_message(span("danger","\The [caller.name] starts arming \the [src.name]!"),span("warning","You begin to arm \the [src.name]!"))
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(8),.proc/arm,caller)
			PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_arm,caller)
		else if(state == 2)
			if(can_disarm(caller))
				caller.visible_message(span("danger","\The [caller.name] starts disarming \the [src.name]!"),span("warning","You begin to disarm \the [src.name]!"))
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(8),.proc/disarm,caller)
			PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_disarm,caller)


		return TRUE

/obj/structure/interactive/vr_nuke/proc/can_disarm(var/mob/living/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(caller.loyalty_tag != "NanoTrasen")
		return FALSE

	if(state != 2)
		return FALSE

	return TRUE


/obj/structure/interactive/vr_nuke/proc/can_arm(var/mob/living/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(caller.loyalty_tag != "Syndicate")
		return FALSE

	if(state != 1)
		return FALSE

	return TRUE

/obj/structure/interactive/vr_nuke/proc/unlock(var/mob/living/caller)
	caller.visible_message(span("danger","\The [caller.name] unlocks \the [src.name]!"),span("warning","You unlock \the [src.name]."))
	state = 1
	return TRUE

/obj/structure/interactive/vr_nuke/proc/arm(var/mob/living/caller)
	caller.visible_message(span("danger","\The [caller.name] arms \the [src.name]!"),span("warning","You arm \the [src.name]."))
	state = 2
	next_explode = world.time + 300 //30 seconds
	return TRUE

/obj/structure/interactive/vr_nuke/proc/disarm(var/mob/caller)
	caller.visible_message(span("danger","\The [caller.name] disarms \the [src.name]!"),span("warning","You disarm \the [src.name]."))
	state = 3
	if(istype(SSvirtual_reality.current_virtual_reality,/virtual_reality/team/nuke_ops/))
		var/virtual_reality/team/nuke_ops/NO = SSvirtual_reality.current_virtual_reality
		NO.check_gamemode_win()
	return TRUE

/obj/structure/interactive/vr_nuke/proc/explode()
	visible_message(span("danger","\The [src.name] explodes!"))
	state = 4
	if(istype(SSvirtual_reality.current_virtual_reality,/virtual_reality/team/nuke_ops/))
		var/virtual_reality/team/nuke_ops/NO = SSvirtual_reality.current_virtual_reality
		NO.check_gamemode_win()
	return TRUE