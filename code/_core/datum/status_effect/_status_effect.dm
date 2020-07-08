/status_effect/
	var/name //Name of the Status Effect
	var/desc //Description of the status effect.
	var/id //Status effect description
	var/maximum = -1 //Maximium time, in deciseconds, that someone can have this effect. Set to -1 to ignore.
	var/minimum = -1 //Maximium time, in deciseconds, that someone can have this effect. Set to -1 to ignore.

/status_effect/proc/can_add_status_effect(var/atom/attacker,var/mob/living/victim)
	return TRUE

/status_effect/proc/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	if(ENABLE_DAMAGE_NUMBERS && !stealthy)
		new/obj/effect/temp/damage_number(owner.loc,clamp(duration,10,100),"[uppertext(name)]!")

	return TRUE

/status_effect/proc/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)
	return TRUE

/status_effect/proc/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)
	return TRUE

/status_effect/stun
	name = "Stunned"
	desc = "You're stunned!"
	id = STUN
	minimum = 5
	maximum = 40

/status_effect/sleeping
	name = "Sleeping"
	desc = "You're sleeping!"
	id = SLEEP
	minimum = 30
	maximum = 600

/status_effect/paralyzed
	name = "Paralyzed"
	desc = "You're paralyzed!"
	id = PARALYZE
	minimum = 10
	maximum = 80

/status_effect/fatigued
	name = "Fatigued"
	desc = "You're fatigued!"
	id = FATIGUE
	minimum = 10
	maximum = 100

/status_effect/fire
	name = "Fire"
	desc = "You're on fire!"
	id = FIRE
	minimum = 0
	maximum = 300

/status_effect/fire/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	. = ..()

	var/initial_fire = owner.on_fire

	if(owner.ignite(magnitude) && !initial_fire)
		owner.visible_message(span("danger","\The [owner.name] is set on fire!"))

	return .

/status_effect/staggered
	name = "Staggered"
	desc = "You're staggered!"
	id = STAGGER
	minimum = 1
	maximum = 10

/status_effect/staggered/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	. = ..()

	if(source)
		var/desired_move_dir = get_dir(source,owner)
		var/old_dir = owner.dir
		var/result = owner.Move(get_step(owner,desired_move_dir),desired_move_dir)
		owner.dir = old_dir
		owner.move_delay = max(owner.move_delay,duration)
		var/list/movement = direction_to_pixel_offset(desired_move_dir)
		if(!result) //We can move.
			animate(owner,pixel_x = movement[1] * TILE_SIZE, pixel_y = movement[2] * TILE_SIZE,time = 1)
			spawn(1)
				var/stun_time = max(duration,10)
				owner.add_status_effect(STUN,stun_time,stun_time)
				animate(owner,pixel_x = 0, pixel_y = 0,time = max(0,stun_time - 1))

	return .

/status_effect/confused
	name = "Confused"
	desc = "You're confused!"
	id = CONFUSED
	minimum = 10
	maximum = 100

/status_effect/critical
	name = "Critical"
	desc = "You're in critical condition!"
	id = CRIT

/status_effect/energized
	name = "Energized"
	desc = "You're filled with adrenaline!"
	id = ADRENALINE
	minimum = 100
	maximum = 600

/status_effect/resting
	name = "Resting"
	desc = "You're resting!"
	id = REST

/status_effect/disarm
	name = "Disarmed"
	desc = "You're disarmed!"
	id = DISARM
	minimum = 10
	maximum = 10

/status_effect/disarm/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.drop_held_objects(A.loc)
	else
		stealthy = TRUE

	return ..(owner,source,magnitude,duration,stealthy)

/status_effect/grab
	name = "Grab"
	desc = "You're grabbed!"
	id = GRAB
	minimum = 1
	maximum = 1

/status_effect/grab/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	if(source && is_living(source) && owner && !owner.dead && owner.dir == source.dir)
		var/mob/living/L = source
		if(L.loyalty_tag != owner.loyalty_tag)
			L.add_status_effect(PARALYZE,30,source = source,stealthy = TRUE)
			L.add_status_effect(DISARM,30,source = source)
			return ..()

	owner.add_status_effect(PARALYZE,10,10,source = source,stealthy = TRUE)
	return ..()

/status_effect/druggy
	name = "Druggy"
	desc = "You're druggy!"
	id = DRUGGY
	minimum = 100
	maximum = 3000

/status_effect/druggy/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)

	if(owner && owner.client)
		var/power = 1 + clamp(duration*0.1,0,min(5,magnitude*0.1))
		var/enlightenment_power = magnitude >= 70 ? max(0,power - 4)*0.5 : 0
		var/list/desired_color_mod = list(
			power,0,0,0,
			0,power,0,0,
			0,0,power,0,
			0,0,0,1,
			enlightenment_power,enlightenment_power,enlightenment_power,enlightenment_power
		)
		owner.update_eyes()
		owner.add_color_mod("druggy",desired_color_mod)

	return TRUE

/status_effect/druggy/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)
	if(owner && owner.client)
		owner.remove_color_mod("druggy")
	return TRUE