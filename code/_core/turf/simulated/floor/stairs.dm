/turf/simulated/floor/stair
	name = "stairs"
	icon = 'icons/turf/floor/stairs.dmi'
	icon_state = "stair"
	layer = LAYER_FLOOR_TILE

	destruction_turf = /turf/simulated/floor/plating

/turf/simulated/floor/stair/Exit(atom/movable/O, atom/newloc)
	if(is_observer(O))
		return ..()
	var/turf/above_turf = locate(x,y,z+1)
	var/turf/targeted_above_turf = get_step(above_turf, dir)
	if(get_turf(newloc) == get_step(src, dir))
		if(!is_floor(targeted_above_turf))
			return ..()
		O.force_move(targeted_above_turf)
	return ..()

/turf/simulated/floor/stair/Enter(atom/movable/enterer, atom/oldloc)
	if(is_observer(enterer))
		return ..()
	if(get_step(oldloc, dir) != get_turf(src))
		return FALSE
	return ..()

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
