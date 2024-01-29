/status_effect/slip
	name = "Slipped"
	desc = "You slipped!"
	id = SLIP
	minimum = 1 SECONDS
	maximum = 4 SECONDS
	default_duration = 1 SECONDS

	affects_dead = FALSE

/status_effect/slip/on_effect_added(mob/living/owner,atom/source,magnitude,duration,stealthy)
	. = ..()
	play_sound('sound/effects/slip.ogg',get_turf(owner),range_max=VIEW_RANGE)
	owner.add_status_effect(STUN,30,30,source = source,stealthy = TRUE)
	var/vel_magnitude = clamp(magnitude * 0.5,0,TILE_SIZE-1)
	if(vel_magnitude > TILE_SIZE*0.5)
		var/throw_dir = owner.move_dir
		var/list/throw_offset = direction_to_pixel_offset(throw_dir)
		owner.throw_self(owner,null,16,16,throw_offset[1]*vel_magnitude,throw_offset[2]*vel_magnitude, steps_allowed = clamp(CEILING(magnitude/20,1),1,6))
