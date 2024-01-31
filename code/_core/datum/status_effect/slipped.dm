/status_effect/slip
	name = "Slipped"
	desc = "You slipped!"
	id = SLIP
	minimum = SECONDS_TO_DECISECONDS(1)
	maximum = SECONDS_TO_DECISECONDS(4)
	default_duration = SECONDS_TO_DECISECONDS(1)

	affects_dead = FALSE

/status_effect/slip/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	play_sound('sound/effects/slip.ogg',get_turf(owner),range_max=VIEW_RANGE)
	owner.add_status_effect(STUN,30,30,source = source,stealthy = TRUE)
	var/vel_magnitude = clamp(magnitude * 0.5,0,TILE_SIZE-1)
	if(vel_magnitude > TILE_SIZE*0.5)
		var/throw_dir = owner.move_dir
		var/list/throw_offset = direction_to_pixel_offset(throw_dir)
		owner.throw_self(owner,null,16,16,throw_offset[1]*vel_magnitude,throw_offset[2]*vel_magnitude, steps_allowed = clamp(CEILING(magnitude/20,1),1,6))
