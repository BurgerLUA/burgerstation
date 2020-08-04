/turf/simulated/floor/chasm/
	name = "chasm"

	icon = 'icons/turf/floor/holes.dmi'
	icon_state = "floor"

	corner_icons = TRUE
	corner_category = "chasm"


/turf/simulated/floor/chasm/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)

	. = ..()

	if((is_living(O) || isobj(O)) && length(all_fall_markers))
		var/turf/T = get_turf(pick(all_fall_markers))
		O.visible_message(span("danger","\The [O.name] falls into \the [src.name]!"))
		if(is_living(O))
			var/mob/living/L = O
			L.send_pain(80)
		O.force_move(T)
		if(is_living(O))
			var/mob/living/L = O
			if(L.health)
				L.visible_message(span("danger","\The [O.name] falls from above and takes damage from the impact!"))
				for(var/i=1,i<=3,i++)
					L.health.adjust_brute_loss(-30)
				L.queue_health_update = TRUE
				L.send_pain(40)
				L.add_status_effect(STUN,30,30)
				play('sound/effects/impacts/meteor_impact.ogg',get_turf(L))
				create_alert(VIEW_RANGE,L,L,ALERT_LEVEL_NOISE)

	return .


/turf/simulated/floor/chasm/end/
	name = "end of the world"