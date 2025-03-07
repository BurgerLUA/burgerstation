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

/obj/item/weapon/melee/energy/chainsaw/proc/can_start(var/mob/activator)

	INTERACT_CHECK_NO_DELAY(src)

	if(!is_inventory(src.loc))
		activator.to_chat(span("warning","You need to be holding the chainsaw in order to start it!"))
		return FALSE

	var/obj/hud/inventory/I = src.loc
	if(!I.click_flags)
		activator.to_chat(span("warning","You need to be holding the chainsaw in order to start it!"))
		return FALSE

	return TRUE


/obj/item/weapon/melee/energy/chainsaw/proc/start(var/mob/activator)
	enabled = TRUE
	START_THINKING(src)
	damage_type = damage_type_on
	play_sound('sound/weapons/melee/chainsaw/start.ogg',get_turf(src),range_max=VIEW_RANGE)
	update_sprite()
	return TRUE

/obj/item/weapon/melee/energy/chainsaw/proc/stop(var/mob/activator)
	enabled = FALSE
	STOP_THINKING(src)
	damage_type = initial(damage_type)
	play_sound('sound/weapons/melee/chainsaw/stop.ogg',get_turf(src),range_max=VIEW_RANGE)
	update_sprite()
	return TRUE

/obj/item/weapon/melee/energy/chainsaw/proc/pull_chain(var/mob/activator)

	if(prob(25))
		start(activator)
	else
		try_start(activator)

	return TRUE

/obj/item/weapon/melee/energy/chainsaw/proc/try_start(var/mob/activator)
	if(activator.is_busy())
		activator.to_chat(span("warning","You're already busy with a task!"))
		return FALSE

	PROGRESS_BAR(activator,src,20,src::pull_chain(),activator)
	PROGRESS_BAR_CONDITIONS(activator,src,	src::can_start(),activator)
	play_sound('sound/weapons/melee/chainsaw/pull.ogg',get_turf(src),range_max=VIEW_RANGE)

	return TRUE

/obj/item/weapon/melee/energy/chainsaw/click_self(var/mob/activator,location,control,params)

	if(is_living(activator))
		var/mob/living/L = activator
		if(L.ai)
			if(enabled)
				stop(activator)
			else
				start(activator)
			return TRUE

	INTERACT_CHECK
	INTERACT_DELAY(5)

	if(enabled)
		stop(activator)
	else
		try_start(activator)

	return TRUE

/obj/item/weapon/melee/energy/chainsaw/should_cleave(var/atom/attacker,var/atom/victim,var/list/params)

	if(enabled && wielded)
		return TRUE

	return ..()