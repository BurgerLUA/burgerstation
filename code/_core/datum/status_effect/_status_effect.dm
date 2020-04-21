/status_effect/
	var/name //Name of the Status Effect
	var/desc //Description of the status effect.
	var/id //Status effect description

/status_effect/proc/on_effect_added(var/mob/living/owner,var/duration,var/atom/source)
	new/obj/effect/temp/damage_number(owner.loc,duration,"[uppertext(name)]!")
	return TRUE

/status_effect/proc/on_effect_removed(var/mob/living/owner,var/duration)
	return TRUE

/status_effect/stun
	name = "Stunned"
	desc = "You're stunned!"
	id = FLAG_STATUS_STUN

/status_effect/sleeping
	name = "Sleeping"
	desc = "You're sleeping!"
	id = FLAG_STATUS_SLEEP

/status_effect/paralyzed
	name = "Paralyzed"
	desc = "You're paralyzed!"
	id = FLAG_STATUS_PARALYZE

/status_effect/fatigued
	name = "Fatigued"
	desc = "You're fatigued!"
	id = FLAG_STATUS_FATIGUE

/status_effect/staggered
	name = "Staggered"
	desc = "You're staggered!"
	id = FLAG_STATUS_STAGGER

/status_effect/staggered/on_effect_added(var/mob/living/owner,var/duration,var/atom/source)

	. = ..()

	if(source)
		var/desired_move_dir = get_dir(source,owner)
		var/old_dir = owner.dir
		var/result = owner.Move(get_step(owner,desired_move_dir),desired_move_dir)
		owner.dir = old_dir
		if(!result)
			owner.move_delay = duration
			var/list/movement = direction_to_pixel_offset(desired_move_dir)
			animate(owner,pixel_x = movement[1] * TILE_SIZE, pixel_y = movement[2] * TILE_SIZE,time = 1)
			spawn(1)
				var/stun_time = max(duration,10)
				owner.add_stun(stun_time - 1)
				animate(owner,pixel_x = 0, pixel_y = 0,time = max(0,stun_time - 1))

	return .

/status_effect/confused
	name = "Confused"
	desc = "You're confused!"
	id = FLAG_STATUS_CONFUSED

/status_effect/critical
	name = "Critical"
	desc = "You're in critical condition!"
	id = FLAG_STATUS_CRIT

/status_effect/energized
	name = "Energized"
	desc = "You're filled with adrenaline!"
	id = FLAG_STATUS_ADRENALINE

/status_effect/resting
	name = "Resting"
	desc = "You're resting!"
	id = FLAG_STATUS_REST




