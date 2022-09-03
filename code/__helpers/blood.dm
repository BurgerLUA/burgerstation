#define BLOOD_LIMIT 3
#define BLOOD_LIMIT_HARD 8 //Maximum of how many blood particles there are on a turf.

/proc/create_blood(var/obj/effect/cleanable/blood/desired_effect, var/turf/simulated/desired_loc,var/desired_color = "#FFFFFF",var/desired_x=0,var/desired_y=0,var/bypass_blood_limit=FALSE)

	if(!desired_loc)
		CRASH("No desired_loc provided!")

	//var/turf/actual_turf = desired_loc

	//Limit to a distance of 1 tile.

	if(desired_x >= TILE_SIZE)
		desired_x = min(desired_x,TILE_SIZE) * RAND_PRECISE(0.75,1)
	else if(desired_x <= -TILE_SIZE)
		desired_x = max(desired_x,-TILE_SIZE) * RAND_PRECISE(0.75,1)

	if(desired_y >= TILE_SIZE)
		desired_y = min(desired_y,TILE_SIZE) * RAND_PRECISE(0.75,1)
	else if(desired_y <= -TILE_SIZE)
		desired_y = max(desired_y,-TILE_SIZE) * RAND_PRECISE(0.75,1)

	var/tile_offset_x = FLOOR(desired_x/TILE_SIZE,1)
	var/tile_offset_y = FLOOR(desired_y/TILE_SIZE,1)

	desired_x = FLOOR(desired_x,1)
	desired_y = FLOOR(desired_y,1)

	if(tile_offset_x || tile_offset_y)
		desired_loc = locate(desired_loc.x + tile_offset_x, desired_loc.y + tile_offset_y, desired_loc.z)

	if(!istype(desired_loc)) //non-simulated
		return null

	if(!bypass_blood_limit)
		if(desired_loc.blood_level_hard > BLOOD_LIMIT_HARD)
			return null
		if(desired_loc.blood_level > BLOOD_LIMIT)
			return null

	var/obj/effect/cleanable/blood/B = new desired_effect(desired_loc,desired_color)
	//Move the blood to origin point.
	B.pixel_x = -tile_offset_x*TILE_SIZE
	B.pixel_y = -tile_offset_y*TILE_SIZE
	//Move the blood to desired location.
	if(desired_x || desired_y)
		animate(B,pixel_x = clamp(desired_x,-8,8), pixel_y = clamp(desired_y,-8,8), time = 3)
	return B