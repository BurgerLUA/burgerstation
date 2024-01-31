/ability/
	var/name = "ability"
	var/desc = "What does it do?"
	var/icon = 'icons/hud/ability.dmi'
	var/icon_state = "none"

	var/resource_type = MANA
	var/cost = 100
	var/cooldown = SECONDS_TO_DECISECONDS(1)
	var/cooldown_end = 0
	var/toggle = FALSE //Set to true if this is an ability that toggles.

	var/category

/ability/proc/activate(var/mob/caller)
	var/atom/target
	var/list/params
	var/location
	if(caller.client)
		target = caller.client.last_object
		params = caller.client.last_params
		location = caller.client.last_location
	else if(is_living(caller))
		var/mob/living/L = caller
		if(L.ai)
			target = L.ai.objective_attack
			location = get_turf(L.ai.objective_attack)
		params = list(PARAM_ICON_X=16,PARAM_ICON_Y=16)
	if(!src.on_cast_pre(caller,target,location,params))
		return FALSE
	return src.on_cast(caller,target,location,params)

/ability/proc/is_active(var/mob/caller)
	return FALSE

/ability/proc/on_cast_pre(var/mob/caller,var/atom/target,location,params)

	if(world.time < cooldown_end)
		return FALSE

	switch(resource_type)
		if(HEALTH)
			if(caller.health && caller.health.health_current < cost)
				return FALSE
			caller.health.adjust_loss_smart(brute=-cost)
		if(STAMINA)
			if(caller.health && caller.health.stamina_current < cost)
				return FALSE
			caller.health.adjust_stamina(-cost)
		if(MANA)
			if(caller.health && caller.health.mana_current < cost)
				return FALSE
			caller.health.adjust_mana(-cost)
	if(resource_type && is_living(caller))
		var/mob/living/L = caller
		QUEUE_HEALTH_UPDATE(L)

	cooldown_end = world.time + cooldown

	return TRUE

/ability/proc/on_cast(var/mob/caller,var/atom/target,location,params)
	return TRUE



