/ability/magic/projectile/
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


/ability/magic/projectile/on_cast(var/mob/activator,var/atom/target,location,params)

	var/icon_pos_x = params[PARAM_ICON_X]
	var/icon_pos_y = params[PARAM_ICON_Y]

	var/desired_iff_tag
	var/desired_loyalty_tag

	var/desired_base_spread = 0

	if(is_living(activator))
		var/mob/living/L = activator
		desired_iff_tag = L.iff_tag
		desired_loyalty_tag = L.loyalty_tag

	activator.shoot_projectile(
		activator,
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
		var/turf/T = get_turf(activator)
		play_sound(shoot_sound,T,range_min = VIEW_RANGE*0.5, range_max=VIEW_RANGE + ZOOM_RANGE*3,tracked = "\ref[src]")
		if(shoot_alert_to_use)
			var/use_activator = TRUE
			if(is_living(activator))
				var/mob/living/L = activator
				if(L.ai) use_activator = FALSE
			create_alert(VIEW_RANGE + ZOOM_RANGE*3,T,use_activator ? activator : null,shoot_alert_to_use)

	return TRUE