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

/ability/proc/activate(var/mob/activator)
	var/atom/target
	var/list/params
	var/location
	if(activator.client)
		target = activator.client.last_object
		params = activator.client.last_params
		location = activator.client.last_location
	else if(is_living(activator))
		var/mob/living/L = activator
		if(L.ai)
			target = L.ai.objective_attack
			location = get_turf(L.ai.objective_attack)
		params = list(PARAM_ICON_X=16,PARAM_ICON_Y=16)
	if(!src.on_cast_pre(activator,target,location,params))
		return FALSE
	return src.on_cast(activator,target,location,params)

/ability/proc/is_active(var/mob/activator)
	return FALSE

/ability/proc/on_cast_pre(var/mob/activator,var/atom/target,location,params)

	if(world.time < cooldown_end)
		return FALSE

	switch(resource_type)
		if(HEALTH)
			if(activator.health && activator.health.health_current < cost)
				return FALSE
			activator.health.adjust_loss_smart(brute=-cost)
		if(STAMINA)
			if(activator.health && activator.health.stamina_current < cost)
				return FALSE
			activator.health.adjust_stamina(-cost)
		if(MANA)
			if(activator.health && activator.health.mana_current < cost)
				return FALSE
			activator.health.adjust_mana(-cost)
	if(resource_type && is_living(activator))
		var/mob/living/L = activator
		QUEUE_HEALTH_UPDATE(L)

	cooldown_end = world.time + cooldown

	return TRUE

/ability/proc/on_cast(var/mob/activator,var/atom/target,location,params)
	return TRUE



