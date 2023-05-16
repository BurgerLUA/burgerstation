/turf/simulated/floor/chasm/
	name = "chasm"

	icon = 'icons/turf/floor/holes.dmi'
	icon_state = "floor"

	corner_icons = TRUE
	corner_category = "chasm"

	density_north = TRUE
	density_east = TRUE
	density_south = TRUE
	density_west = TRUE
	density_up = TRUE
	density_down = TRUE

	collision_flags = FLAG_COLLISION_WALL

	density = TRUE

	map_color = COLOR_BLACK

/*
/turf/simulated/floor/chasm/Crossed(atom/movable/O,atom/OldLoc)

	. = ..()

	if((is_living(O) || isobj(O)) && length(rift_markers))
		if(!O.finalized)
			return
		var/turf/T = get_turf(pick(rift_markers))
		O.visible_message(span("danger","\The [O.name] falls into \the [src.name]!"))
		if(is_living(O))
			var/mob/living/L = O
			L.send_pain_response(80)
		O.force_move(T)
		if(is_living(O))
			var/mob/living/L = O
			if(istype(L.health))
				L.visible_message(span("danger","\The [O.name] falls from above and takes damage from the impact!"))
				for(var/i=1,i<=3,i++)
					L.health.adjust_loss_smart(brute=-10)
				L.send_pain_response(40)
				L.add_status_effect(STUN,30,30)
				play('sound/effects/impacts/meteor_impact.ogg',get_turf(L))
				create_alert(VIEW_RANGE,T,L,ALERT_LEVEL_NOISE)

*/


/turf/simulated/floor/chasm/end/
	name = "end of the world"