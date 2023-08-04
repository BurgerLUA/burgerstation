/health/turf/
	organic = FALSE
	var/last_damage_icon = 0
	var/damage_icon_turn = 1 //1 to 4


/health/turf/update_health_stats()
	. = ..()
	var/turf/simulated/T = owner
	if(T.material_id)
		var/material/M = MATERIAL(T.material_id)
		health_max += M.wall_health

/health/turf/New(var/desired_owner)

	. = ..()

	damage_icon_turn = rand(1,4)

	var/turf/simulated/T = owner
	if(T.material_id)
		var/material/M = MATERIAL(T.material_id)
		if(M && M.armor)
			armor = M.armor
	organic = T.organic

/health/turf/update_health()

	. = ..()

	if(!owner)
		return .

	if(health_current <= 0)
		if(owner.can_do_destruction())
			owner.on_destruction()
		return .

	var/desired_damage_icon = (1 - health_current/health_max)*(length(SSturf.turf_damage_icons)+1)
	desired_damage_icon = FLOOR(desired_damage_icon,1)
	if(last_damage_icon != desired_damage_icon)
		owner.update_sprite()
		if(desired_damage_icon > 0)
			owner.add_overlay(SSturf.turf_damage_icons[desired_damage_icon][damage_icon_turn])
		last_damage_icon = desired_damage_icon

