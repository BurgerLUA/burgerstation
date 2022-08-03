/turf/unsimulated/generation/ocean
	name = "ocean generation"
	icon_state = "ocean"

/turf/unsimulated/generation/ocean/path
	icon_state = "ocean_path"
	density = FALSE

/turf/unsimulated/generation/ocean/generate(var/size = WORLD_SIZE)

	if(!density)
		new /turf/simulated/floor/colored/sand/beach(src)
		if(src.loc.type == /area/) new /area/mission/beach(src)
		disallow_generation = TRUE
		return ..()

	var/x_seed = x / size
	var/y_seed = y / size

	var/max_instances = NOISE_INSTANCES
	var/noise = 0
	for(var/i=1,i<=max_instances,i++)
		noise += text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+i]]","[x_seed]","[y_seed]"))
	noise *= 1/max_instances
	if(NOISE_CURVES) noise = 0.5 + sin((noise+0.5)*NOISE_CURVES*180)*0.5



	new /turf/simulated/liquid/water/sea(src) //Not sure what the noise profile should be so its this for now.

	if(src.loc.type == /area/)
		new /area/mission/ocean(src)

	. = ..()