/ability/
	var/name = "ability"
	var/desc = "What does it do?"
	var/icon = 'icons/hud/ability.dmi'
	var/icon_state = "none"

	var/resource_type = MANA
	var/cost = 100
	var/cooldown = SECONDS_TO_DECISECONDS(1)
	var/cooldown_end = 0

/ability/proc/activate(var/mob/caller)
	var/atom/target
	if(caller.client)
		target = caller.client.last_object
	else if(is_living(caller))
		var/mob/living/L = caller
		if(L.ai)
			target = L.ai.objective_attack
	if(!src.on_cast_pre(caller,target))
		return FALSE
	return src.on_cast(caller,target)

/ability/proc/on_cast_pre(var/mob/caller,var/atom/target)

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

	cooldown_end = world.time + cooldown

	return TRUE

/ability/proc/on_cast(var/mob/caller,var/atom/target)
	return TRUE