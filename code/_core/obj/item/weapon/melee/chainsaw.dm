/obj/item/weapon/melee/energy/chainsaw/
	name = "chainsaw"
	desc = "When you solve your problems with a chainsaw, you never have the same problem twice!"
	desc_extended =  "It's a chainsaw. Turn it on and watch as everything you hit with it becomes chunky soup."
	icon = 'icons/obj/item/weapons/melee/swords/chainsaw.dmi'
	damage_type = /damagetype/melee/sword/chainsaw

	can_wield = TRUE

	size = SIZE_4
	weight = 20

	var/next_chain_time = 0

	var/last_bump_hit = 0

	value = 500

/obj/item/weapon/melee/energy/chainsaw/think()

	if(world.time >= next_chain_time)
		if(last_bump_hit >= world.time - 5)
			play_sound('sound/weapons/chainsaw/loop_bump.ogg',get_turf(src), volume = 20,range_max=VIEW_RANGE)
		else
			play_sound('sound/weapons/chainsaw/loop.ogg',get_turf(src),volume = 20,range_max=VIEW_RANGE)

		if(is_inventory(loc))
			var/obj/hud/inventory/I = loc
			if(!I.click_flags)
				stop()
		else
			stop()

		next_chain_time = world.time + 5

	return ..()

/obj/item/weapon/melee/energy/chainsaw/proc/can_start(var/mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(!is_inventory(src.loc))
		caller.to_chat(span("warning","You need to be holding the chainsaw in order to start it!"))
		return FALSE

	var/obj/hud/inventory/I = src.loc
	if(!I.click_flags)
		caller.to_chat(span("warning","You need to be holding the chainsaw in order to start it!"))
		return FALSE

	return TRUE


/obj/item/weapon/melee/energy/chainsaw/proc/start(var/mob/caller)
	enabled = TRUE
	start_thinking(src)
	damage_type = /damagetype/melee/sword/chainsaw/on
	play_sound('sound/weapons/chainsaw/start.ogg',get_turf(src),range_max=VIEW_RANGE)
	update_sprite()
	return TRUE

/obj/item/weapon/melee/energy/chainsaw/proc/stop(var/mob/caller)
	enabled = FALSE
	stop_thinking(src)
	damage_type = /damagetype/melee/sword/chainsaw
	play_sound('sound/weapons/chainsaw/stop.ogg',get_turf(src),range_max=VIEW_RANGE)
	update_sprite()
	return TRUE

/obj/item/weapon/melee/energy/chainsaw/proc/pull_chain(var/mob/caller)

	if(prob(25))
		start(caller)
	else
		try_start(caller)

	return TRUE

/obj/item/weapon/melee/energy/chainsaw/proc/try_start(var/mob/caller)
	if(caller.is_busy())
		caller.to_chat(span("warning","You're already busy with a task!"))
		return FALSE

	PROGRESS_BAR(caller,src,20,.proc/pull_chain,caller)
	PROGRESS_BAR_CONDITIONS(caller,src,	.proc/can_start,caller)
	play_sound('sound/weapons/chainsaw/pull.ogg',get_turf(src),range_max=VIEW_RANGE)

	return TRUE

/obj/item/weapon/melee/energy/chainsaw/click_self(var/mob/caller)

	if(is_living(caller))
		var/mob/living/L = caller
		if(L.ai)
			if(enabled)
				stop(caller)
			else
				start(caller)
			return TRUE

	INTERACT_CHECK
	INTERACT_DELAY(5)

	if(enabled)
		stop(caller)
	else
		try_start(caller)

	return TRUE

/obj/item/weapon/melee/energy/chainsaw/should_cleave(var/atom/attacker,var/atom/victim,var/list/params)

	if(enabled && wielded)
		return TRUE

	return ..()