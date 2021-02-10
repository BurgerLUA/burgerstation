/status_effect/
	var/name //Name of the Status Effect
	var/desc //Description of the status effect.
	var/id //Status effect description
	var/maximum = -1 //Maximium time, in deciseconds, that someone can have this effect. Set to -1 to ignore.
	var/minimum = -1 //Maximium time, in deciseconds, that someone can have this effect. Set to -1 to ignore.

	var/affects_dead = TRUE

/status_effect/proc/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(victim.dead && !affects_dead)
		return FALSE

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

	affects_dead = FALSE

/status_effect/sleeping
	name = "Sleeping"
	desc = "You're sleeping!"
	id = SLEEP
	minimum = 30
	maximum = 600

	affects_dead = FALSE

/status_effect/paralyzed
	name = "Paralyzed"
	desc = "You're paralyzed!"
	id = PARALYZE
	minimum = 10
	maximum = 80

	affects_dead = FALSE

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
		owner.visible_message(span("danger","\The [owner.name] is set on fire!"),span("danger","You're set on fire!"))

	return .

/status_effect/staggered
	name = "Staggered"
	desc = "You're staggered!"
	id = STAGGER
	minimum = 1
	maximum = 10

	affects_dead = FALSE

/status_effect/staggered/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(victim.horizontal)
		return FALSE

	if(victim.move_mod == 1)
		return FALSE

	return ..()

/status_effect/staggered/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	. = ..()

	if(source)
		var/desired_move_dir = get_dir(source,owner)
		var/old_dir = owner.dir
		var/result = owner.Move(get_step(owner,desired_move_dir))
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

/status_effect/slip
	name = "Slipped"
	desc = "You slipped!"
	id = SLIP
	minimum = 1
	maximum = 100

	affects_dead = FALSE

/status_effect/slip/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	play_sound('sound/effects/slip.ogg',get_turf(owner),range_max=VIEW_RANGE)
	owner.add_status_effect(STUN,30,30,source = source,stealthy = TRUE)
	var/throw_dir = owner.move_dir
	var/list/throw_offset = direction_to_pixel_offset(throw_dir)
	var/vel_magnitude = clamp(magnitude * 0.5,TILE_SIZE*0.5,TILE_SIZE-1)
	owner.throw_self(owner,null,16,16,throw_offset[1]*vel_magnitude,throw_offset[2]*vel_magnitude, steps_allowed = clamp(CEILING(magnitude/20,1),1,6))
	return .

/status_effect/confused
	name = "Confused"
	desc = "You're confused!"
	id = CONFUSED
	minimum = 10
	maximum = 100

	affects_dead = FALSE

/status_effect/critical
	name = "Critical"
	desc = "You're in critical condition!"
	id = CRIT

	affects_dead = FALSE

/status_effect/critical/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	owner.remove_status_effect(ADRENALINE)
	return ..()

/status_effect/paincrit
	name = "Paincrit"
	desc = "You're in pain!"
	id = PAINCRIT

	affects_dead = FALSE

/status_effect/paincrit/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	owner.remove_status_effect(PAINKILLER)
	return ..()

/status_effect/stamcrit
	name = "Stamcrit"
	desc = "You're too tired!"
	id = STAMCRIT
	minimum = 10
	maximum = 30

	affects_dead = FALSE

/status_effect/stamcrit/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	owner.remove_status_effect(ADRENALINE)
	return ..()

/status_effect/energized
	name = "Adrenaline"
	desc = "You're filled with adrenaline!"
	id = ADRENALINE
	minimum = 100 // 10 seconds
	maximum = 3 * 60 * 10 //5 minutes.

/status_effect/energized/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	. = ..()

	if(owner.health) owner.health.update_health(check_death=FALSE)
	owner.remove_status_effect(STAMCRIT)

	return .

/status_effect/resting
	name = "Resting"
	desc = "You're resting!"
	id = REST

	affects_dead = FALSE

/status_effect/disarm
	name = "Disarmed"
	desc = "You're disarmed!"
	id = DISARM
	minimum = 10
	maximum = 10

/status_effect/disarm/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.drop_hands(A.loc)
		for(var/obj/hud/inventory/I in A.inventory)
			if(I.grabbed_object)
				I.release_object()
	else
		stealthy = TRUE

	return ..()

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
			owner.add_status_effect(PARALYZE,30,30,source = source,stealthy = TRUE)
			owner.add_status_effect(DISARM,30,30,source = source)
			return ..()

	owner.add_status_effect(PARALYZE,10,10,source = source,stealthy = TRUE)

	return ..()

/status_effect/druggy
	name = "Druggy"
	desc = "You're druggy!"
	id = DRUGGY
	minimum = 100
	maximum = 3000

	affects_dead = FALSE

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