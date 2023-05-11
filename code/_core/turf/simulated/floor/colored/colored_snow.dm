#define MAX_DEPTH (VIEW_RANGE)

/turf/simulated/floor/colored/snow
	name = "snow"
	color = "#FFFFFF"
	layer = LAYER_FLOOR_WEATHER
	corner_category = "snow"

	footstep = /footstep/snow

	move_delay_modifier = 1.2

	material_id = /material/dirt/

	destruction_turf = /turf/simulated/floor/colored/dirt/snow

	color = "#EDF7F7"

	var/shore = FALSE
	var/depth = 0

	health_base = 200


/turf/simulated/floor/colored/snow/New(var/desired_loc)
	. = ..()
	if(depth == 0)
		depth = MAX_DEPTH

/turf/simulated/floor/colored/snow/Initialize()
	. = ..()
	shore = FALSE
	for(var/d in DIRECTIONS_CARDINAL)
		var/turf/simulated/floor/T = get_step(src,d)
		if(T.type != src.type && istype(T,/turf/simulated/floor/colored/grass) && T.organic)
			shore = TRUE
			break
	if(shore)
		for(var/turf/simulated/floor/colored/snow/S in oview(src,MAX_DEPTH))
			S.depth = min(S.depth,get_dist_real(S,src))

/turf/simulated/floor/colored/snow/Finalize()

	. = ..()

	var/blend_mod = depth/MAX_DEPTH

	var/turf/simulated/floor/colored/grass/G = /turf/simulated/floor/colored/grass

	color = blend_colors(initial(G.color),initial(src.color),blend_mod)
	map_color = color