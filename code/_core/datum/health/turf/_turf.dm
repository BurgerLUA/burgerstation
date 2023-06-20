var/global/list/image/turf_damage_icons = new/list(5,4)

/proc/setup_turf_damage_icons()

	for(var/i=1,i<=5,i++) for(var/d=1,d<=4,d++)
		var/icon/I = new('icons/turf/damage.dmi',"[i]")
		var/turn_direction = (d-1)*90
		if(turn_direction > 0)
			I.Turn(turn_direction)
		turf_damage_icons[i][d] = I

	return TRUE

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
		owner.on_destruction()
		return .

	var/desired_damage_icon = (1 - health_current/health_max)*(length(turf_damage_icons)+1)
	desired_damage_icon = FLOOR(desired_damage_icon,1)
	if(last_damage_icon != desired_damage_icon)
		owner.update_sprite()
		if(desired_damage_icon > 0)
			owner.add_overlay(turf_damage_icons[desired_damage_icon][damage_icon_turn])
		last_damage_icon = desired_damage_icon

