/obj/item/weapon/melee/energy/chainsaw/
	name = "chainsaw"
	desc = "When you solve your problems with a chainsaw, you never have the same problem twice!"
	desc_extended =  "It's a chainsaw. Turn it on and watch as everything you hit with it becomes chunky soup."
	icon = 'icons/obj/item/weapons/melee/swords/chainsaw.dmi'
	damage_type = /damagetype/melee/sword/chainsaw
	damage_type_on = /damagetype/melee/sword/chainsaw/on

	can_wield = TRUE

	size = SIZE_4
	weight = 20

	var/next_chain_time = 0

	var/last_bump_hit = 0

	value = 300

	rarity = RARITY_UNCOMMON

/obj/item/weapon/melee/energy/chainsaw/think()

	if(world.time >= next_chain_time)
		if(last_bump_hit >= world.time - 5)
			play_sound('sound/weapons/melee/chainsaw/loop_bump.ogg',get_turf(src), volume = 20,range_max=VIEW_RANGE)
		else
			play_sound('sound/weapons/melee/chainsaw/loop.ogg',get_turf(src),volume = 20,range_max=VIEW_RANGE)

		if(is_inventory(loc))
			var/obj/hud/inventory/I = loc
			if(!I.click_flags)
				stop()
		else
			stop()

		next_chain_time = world.time + 5

	return ..()

/obj/item/weapon/melee/energy/chainsaw/proc/can_start(mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(!is_inventory(src.loc))
		caller.to_chat(span("warning","You need to be holding the chainsaw in order to start it!"))
		return FALSE

	var/obj/hud/inventory/I = src.loc
	if(!I.click_flags)
		caller.to_chat(span("warning","You need to be holding the chainsaw in order to start it!"))
		return FALSE

	return TRUE


/obj/item/weapon/melee/energy/chainsaw/proc/start(mob/caller)
	enabled = TRUE
	START_THINKING(src)
	damage_type = damage_type_on
	play_sound('sound/weapons/melee/chainsaw/start.ogg',get_turf(src),range_max=VIEW_RANGE)
	update_sprite()
	return TRUE

/obj/item/weapon/melee/energy/chainsaw/proc/stop(mob/caller)
	enabled = FALSE
	STOP_THINKING(src)
	damage_type = initial(damage_type)
	play_sound('sound/weapons/melee/chainsaw/stop.ogg',get_turf(src),range_max=VIEW_RANGE)
	update_sprite()
	return TRUE

/obj/item/weapon/melee/energy/chainsaw/proc/pull_chain(mob/caller)

	if(prob(25))
		start(caller)
	else
		try_start(caller)

	return TRUE

/obj/item/weapon/melee/energy/chainsaw/proc/try_start(mob/caller)
	if(caller.is_busy())
		caller.to_chat(span("warning","You're already busy with a task!"))
		return FALSE

	PROGRESS_BAR(caller,src,20,src::pull_chain(),caller)
	PROGRESS_BAR_CONDITIONS(caller,src,	src::can_start(),caller)
	play_sound('sound/weapons/melee/chainsaw/pull.ogg',get_turf(src),range_max=VIEW_RANGE)

	return TRUE

/obj/item/weapon/melee/energy/chainsaw/click_self(mob/caller,location,control,params)

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

/obj/item/weapon/melee/energy/chainsaw/should_cleave(atom/attacker,atom/victim,list/params)

	if(enabled && wielded)
		return TRUE

	return ..()