/turf/simulated/floor/stair
	name = "stairs"
	icon = 'icons/turf/floor/stairs.dmi'
	icon_state = "stair"
	layer = LAYER_FLOOR_TILE

	safe_fall = TRUE

	map_color = "#FFFFFF"

	exposed = FALSE

	health_base = 300

/turf/simulated/floor/stair/ztravel
	health_base = 0

/turf/simulated/floor/stair/ztravel/Exit(atom/movable/O, atom/newloc)

	. = ..()

	if(is_observer(O))
		return .

	if(. && get_step(src,dir) == newloc) //Going uuuuuuuup.
		var/turf/T = locate(x,y,z+1)
		if(T && !T.density_down)
			var/turf/T2 = get_step(T,dir)
			if(T2)
				O.Move(T2)
			return FALSE //Don't do regular movement.


/turf/simulated/floor/stair/ztravel/wood
	color = "#724C34"
	footstep = /footstep/wood

/turf/simulated/floor/stair/wood/
	color = "#724C34"
	footstep = /footstep/wood

/turf/simulated/floor/stair/wood/rich
	color = "#A05120"

/turf/simulated/floor/stair/wood/dock
	color = "#7F604B"

/turf/simulated/floor/stair/cult
	color = "#33241B"
	footstep = /footstep/wood

	destruction_turf = /turf/simulated/floor/basalt

/*
/turf/simulated/floor/stair/force_below
	color = "#555555"

/turf/simulated/floor/stair/force_below/New(var/desired_loc)

	var/turf/TB = locate(x,y,z-1)

	TB.change_turf(/turf/simulated/floor/stair)
	TB.dir = dir
	TB.icon_state = icon_state

	src.change_turf(/turf/simulated/openspace)
*/


/turf/simulated/floor/stair/city
	color = "#CCBAAD"

