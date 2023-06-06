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


/*
/ability/projectile/
	name = "projectile ability"
	desc = "An ability that shoots a projectile."

	resource_type = MANA
	cost = 25
	cooldown = SECONDS_TO_DECISECONDS(1)

	var/obj/projectile/projectile_to_shoot
	var/damagetype/damage_type
	var/projectile_speed = TILE_SIZE - 1
	var/bullet_count = 1
	var/bullet_color = "#FFFFFF"
	var/view_punch = 0
	var/damage_multiplier = 1
	var/inaccuracy_modifier = 1
	var/penetrations = 0
	var/shoot_sound
	var/shoot_alert_to_use = ALERT_LEVEL_CAUTION


/ability/projectile/on_cast(var/mob/caller,var/atom/target,location,params)

	var/icon_pos_x = params[PARAM_ICON_X]
	var/icon_pos_y = params[PARAM_ICON_Y]

	var/desired_iff_tag
	var/desired_loyalty_tag

	var/desired_base_spread = 0

	if(is_living(caller))
		var/mob/living/L = caller
		desired_iff_tag = L.iff_tag
		desired_loyalty_tag = L.loyalty_tag

	caller.shoot_projectile(
		caller,
		target,
		location,
		params,
		projectile_to_shoot,
		damage_type,
		icon_pos_x,
		icon_pos_y,
		0,
		projectile_speed,
		bullet_count,
		bullet_color,
		view_punch,
		damage_multiplier,
		desired_iff_tag,
		desired_loyalty_tag,
		inaccuracy_modifier,
		desired_base_spread,
		penetrations
	)

	if(shoot_sound)
		var/turf/T = get_turf(caller)
		play_sound(shoot_sound,T,range_min = VIEW_RANGE*0.5, range_max=VIEW_RANGE + ZOOM_RANGE*3,tracked = "\ref[src]")
		if(shoot_alert_to_use)
			var/use_caller = TRUE
			if(is_living(caller))
				var/mob/living/L = caller
				if(L.ai) use_caller = FALSE
			create_alert(VIEW_RANGE + ZOOM_RANGE*3,T,use_caller ? caller : null,shoot_alert_to_use)

	return TRUE
*/