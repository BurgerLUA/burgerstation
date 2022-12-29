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

/health/turf/New(var/desired_owner)

	. = ..()

	damage_icon_turn = rand(1,4)

	var/turf/T = owner
	if(T.material_id)
		var/material/M = SSmaterials.all_materials[T.material_id]
		if(M && M.armor)
			armor = M.armor

/health/turf/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)

	. = ..()

	if(.)

		var/turf/simulated/T = owner

		if(health_current <= 0)
			T.on_destruction(attacker,TRUE)
		else
			var/desired_damage_icon = (1 - health_current/health_max)*(length(turf_damage_icons)+1)
			desired_damage_icon = FLOOR(desired_damage_icon,1)
			if(last_damage_icon != desired_damage_icon)
				T.overlays.Cut()
				T.update_overlays()
				if(desired_damage_icon > 0)
					T.add_overlay(turf_damage_icons[desired_damage_icon][damage_icon_turn])
				last_damage_icon = desired_damage_icon

