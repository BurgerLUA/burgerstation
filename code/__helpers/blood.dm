#define BLOOD_LIMIT 3 //Maximum of how many blood particles there are on a turf.

/proc/create_blood(var/obj/effect/cleanable/blood/desired_effect, var/turf/simulated/desired_loc,var/desired_color = "#FFFFFF",var/desired_x,var/desired_y,var/bypass_blood_limit=FALSE)

	desired_x = clamp(desired_x,-TILE_SIZE*1.5,TILE_SIZE*1.5)
	desired_y = clamp(desired_y,-TILE_SIZE*1.5,TILE_SIZE*1.5)

	var/tile_offset_x = FLOOR(desired_x/TILE_SIZE,1)
	var/tile_offset_y = FLOOR(desired_y/TILE_SIZE,1)

	if(tile_offset_x || tile_offset_y)
		desired_loc = locate(desired_loc.x + tile_offset_x, desired_loc.y + tile_offset_y, desired_loc.z)

	if(!desired_loc)
		return null

	if(!istype(desired_loc))
		return null

	if(!bypass_blood_limit && desired_loc.blood_level_hard > BLOOD_LIMIT)
		return null

	var/obj/effect/cleanable/blood/B = new desired_effect(desired_loc,desired_color)
	B.pixel_x = -tile_offset_x
	B.pixel_y = -tile_offset_y
	desired_x += B.pixel_x
	desired_y += B.pixel_y
	animate(B,pixel_x = clamp(desired_x,-8,8), pixel_y = clamp(desired_y,-8,8), time = 3)
	return B