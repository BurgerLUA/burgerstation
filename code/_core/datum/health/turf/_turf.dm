var/global/list/image/turf_damage_icons = list(
	new/image('icons/turf/damage.dmi',"1"),
	new/image('icons/turf/damage.dmi',"2"),
	new/image('icons/turf/damage.dmi',"3"),
	new/image('icons/turf/damage.dmi',"4"),
	new/image('icons/turf/damage.dmi',"5"),
	new/image('icons/turf/damage.dmi',"6")
)


/health/turf/
	organic = FALSE
	var/last_damage_icon = 0

/health/turf/New(var/desired_owner)

	. = ..()

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
			var/desired_damage_icon = (1 - health_current/health_max)*(length(turf_damage_icons) + 1)
			desired_damage_icon = CEILING(desired_damage_icon,1)
			if(last_damage_icon != desired_damage_icon && desired_damage_icon >= 1 && desired_damage_icon <= length(turf_damage_icons))
				T.overlays.Cut()
				T.update_overlays()
				T.add_overlay(turf_damage_icons[desired_damage_icon])
				last_damage_icon = desired_damage_icon

