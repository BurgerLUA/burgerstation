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
		var/turf/T = get_turf(owner)
		if(T) new/obj/effect/temp/status_effect(T,clamp(duration,10,100),"[uppertext(name)]!")

	return TRUE

/status_effect/proc/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)
	return TRUE

/status_effect/proc/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)
	return TRUE

/status_effect/soul_trap
	name = "Soul Trap"
	desc = "You've been soul trapped!"
	id = SOULTRAP
	minimum = 10
	maximum = 600

	affects_dead = FALSE

/status_effect/soul_trap/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(victim.is_player_controlled())
		return FALSE

	return ..()


/status_effect/stun
	name = "Stunned"
	desc = "You're stunned!"
	id = STUN
	minimum = 5
	maximum = 40

	affects_dead = FALSE


/status_effect/stun/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	owner.remove_status_effect(STAGGER)
	owner.remove_status_effect(PARRIED)
	owner.remove_status_effect(SHOVED)



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

	if(owner.ignite(magnitude,source) && !initial_fire)
		owner.visible_message(span("danger","\The [owner.name] is set on fire!"),span("danger","You're set on fire!"))

/status_effect/parried
	name = "Parried"
	desc = "You're parried!"
	id = PARRIED
	minimum = 1
	maximum = 10

	affects_dead = FALSE


/status_effect/parried/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(!attacker || victim.horizontal || victim.anchored)
		return FALSE

	. = ..()

/status_effect/parried/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	. = ..()


	var/desired_move_dir = get_dir(source,owner)
	var/old_dir = owner.dir
	var/result = owner.Move(get_step(owner,desired_move_dir))
	owner.dir = old_dir
	owner.move_delay = max(owner.move_delay,duration)
	if(!result) //We can't move.
		var/list/movement = direction_to_pixel_offset(desired_move_dir)
		animate(owner,pixel_x = movement[1] * TILE_SIZE, pixel_y = movement[2] * TILE_SIZE,time = 1)
		var/stun_time = max(duration,10)
		owner.add_status_effect(STUN,stun_time,stun_time)
		spawn(1)
			animate(owner,pixel_x = 0, pixel_y = 0,time = max(0,stun_time - 1))


/status_effect/shoved
	name = "Shoved"
	desc = "You're shoved!"
	id = SHOVED
	minimum = 1
	maximum = 10

	affects_dead = FALSE

/status_effect/shoved/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(!attacker || victim.horizontal || victim.anchored)
		return FALSE

	. = ..()

/status_effect/shoved/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	. = ..()

	var/desired_move_dir = get_dir(source,owner)
	var/old_dir = owner.dir
	var/result = owner.Move(get_step(owner,desired_move_dir))
	owner.dir = old_dir
	owner.move_delay = max(owner.move_delay,duration)
	if(!result) //We can't move.
		var/list/movement = direction_to_pixel_offset(desired_move_dir)
		animate(owner,pixel_x = movement[1] * TILE_SIZE, pixel_y = movement[2] * TILE_SIZE,time = 1)
		spawn(1)
			var/stun_time = max(duration,10)
			owner.add_status_effect(STUN,stun_time,stun_time)
			animate(owner,pixel_x = 0, pixel_y = 0,time = max(0,stun_time - 1))



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

	return ..()

/status_effect/staggered/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	owner.move_delay = max(owner.move_delay,duration)

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
	owner.stamina_regen_delay = max(owner.stamina_regen_delay,owner.is_player_controlled() ? SECONDS_TO_DECISECONDS(4) : SECONDS_TO_DECISECONDS(10))
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
	owner.stamina_regen_delay = 0

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

	. = ..()

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
		var/list/desired_color_mod = list(
			power,0,0,0,
			0,power,0,0,
			0,0,power,0,
			0,0,0,1,
			0,0,0,0
		)
		owner.update_eyes()
		owner.add_color_mod("druggy",desired_color_mod)

	return TRUE

/status_effect/druggy/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)
	if(owner && owner.client)
		owner.remove_color_mod("druggy")
	return TRUE


/status_effect/stressed
	name = "Stressed"
	desc = "You're stressed!"
	id = STRESSED
	minimum = 10
	maximum = 30

	affects_dead = FALSE

/status_effect/stressed/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)

	if(owner && owner.client)
		var/list/desired_color_mod = list(
			0.33,0.33,0.33,0,
			0.33,0.33,0.33,0,
			0.33,0.33,0.33,0,
			0,0,0,1,
			0,0,0,0
		)
		owner.update_eyes()
		owner.add_color_mod("stressed",desired_color_mod)

/status_effect/stressed/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)
	if(owner && owner.client)
		owner.remove_color_mod("stressed")
	return TRUE



/status_effect/mana_void
	name = "Mana Void"
	desc = "You've been mana voided!"
	id = MANAVOID
	minimum = 10
	maximum = 100


/status_effect/mana_void/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	owner.mana_regen_buffer = -1000

/status_effect/stressed/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)
	owner.mana_regen_buffer = max(0,owner.mana_regen_buffer)

/status_effect/slow
	name = "Slowed"
	desc = "You've been slowed!"
	id = SLOW
	minimum = 10
	maximum = 300

/status_effect/consencrated
	name = "Consencrated"
	desc = "You've been consencrated!"
	id = CONSECRATED
	minimum = 50
	maximum = 600


/status_effect/consencrated/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	. = ..()

	if(!.)
		return FALSE

	if(!victim || !victim.health)
		return FALSE

	var/list/defense = victim.health.get_defense(null,null,TRUE)

	if(defense[HOLY] > defense[DARK])
		return FALSE

	return TRUE

/status_effect/consencrated/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)
	. = ..()
	owner.burn_regen_buffer -= 5 * TICKS_TO_SECONDS(LIFE_TICK)

/status_effect/cursed
	name = "Cursed"
	desc = "You've been cursed!"
	id = CURSED
	minimum = 50
	maximum = 600

/status_effect/cursed/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	. = ..()

	if(!.)
		return FALSE

	if(!victim || !victim.health)
		return FALSE

	var/list/defense = victim.health.get_defense(null,null,TRUE)

	if(defense[HOLY] < defense[DARK])
		return FALSE

	return TRUE

/status_effect/cursed/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)
	. = ..()
	owner.brute_regen_buffer -= 5 * TICKS_TO_SECONDS(LIFE_TICK)



/status_effect/blighted
	name = "Blighted"
	desc = "You've been blighted!"
	id = BLIGHTED
	minimum = 50
	maximum = 600

/status_effect/blighted/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)
	. = ..()
	owner.brute_regen_buffer = min(owner.brute_regen_buffer,0)
	owner.burn_regen_buffer = min(owner.burn_regen_buffer,0)
	owner.tox_regen_buffer = min(owner.tox_regen_buffer,0)
	owner.pain_regen_buffer = min(owner.pain_regen_buffer,0)
	owner.rad_regen_buffer = min(owner.rad_regen_buffer,0)
	owner.sanity_regen_buffer = min(owner.sanity_regen_buffer,0)
	owner.mana_regen_buffer = min(owner.mana_regen_buffer,0)
	owner.stamina_regen_buffer = min(owner.stamina_regen_buffer,0)