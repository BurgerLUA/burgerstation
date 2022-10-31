/status_effect/
	var/name //Name of the Status Effect
	var/desc //Description of the status effect.
	var/id //Status effect description
	var/maximum = -1 //Maximium time, in deciseconds, that someone can have this effect. Set to -1 to ignore.
	var/minimum = -1 //Maximium time, in deciseconds, that someone can have this effect. Set to -1 to ignore.

	var/default_magnitude = 100
	var/default_duration = -1

	var/affects_dead = TRUE

/status_effect/proc/modify_duration(var/atom/attacker,var/mob/living/owner,var/duration)
	return duration

/status_effect/proc/modify_magnitude(var/atom/attacker,var/mob/living/owner,var/magnitude)
	return magnitude

/status_effect/proc/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(victim.dead && !affects_dead)
		return FALSE

	return TRUE

/status_effect/proc/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	if(!stealthy)
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
	minimum = SECONDS_TO_DECISECONDS(4)
	maximum = SECONDS_TO_DECISECONDS(60)
	default_duration = SECONDS_TO_DECISECONDS(30)

	affects_dead = FALSE

/status_effect/soul_trap/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(victim.is_player_controlled())
		return FALSE

	. = ..()


/status_effect/stun
	name = "Stunned"
	desc = "You're stunned!"
	id = STUN
	minimum = SECONDS_TO_DECISECONDS(1)
	maximum = SECONDS_TO_DECISECONDS(4)
	default_duration = SECONDS_TO_DECISECONDS(1)

	affects_dead = FALSE

/status_effect/stun/modify_duration(var/atom/attacker,var/mob/living/owner,var/duration)
	if(owner.stun_immunity > 0)
		duration *= 0.25
	return duration

/status_effect/stun/modify_magnitude(var/atom/attacker,var/mob/living/owner,var/magnitude)
	if(owner.stun_immunity > 0)
		magnitude *= 0.25
	return magnitude

/status_effect/stun/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	owner.remove_status_effect(STAGGER)
	owner.remove_status_effect(PARRIED)
	owner.remove_status_effect(SHOVED)
	if(duration > 0 && magnitude > 0)
		owner.stun_immunity = max(owner.stun_immunity,owner.stun_immunity + duration*1.25 + SECONDS_TO_DECISECONDS(1))


/status_effect/sleeping
	name = "Sleeping"
	desc = "You're sleeping!"
	id = SLEEP
	minimum = SECONDS_TO_DECISECONDS(10)
	maximum = SECONDS_TO_DECISECONDS(60)
	default_duration = -1

	affects_dead = FALSE

/status_effect/sleeping/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	if(duration > 0 && magnitude > 0)
		owner.stun_immunity = max(owner.stun_immunity,owner.stun_immunity + duration*1.25 + SECONDS_TO_DECISECONDS(1))

/status_effect/sleeping/modify_duration(var/atom/attacker,var/mob/living/owner,var/duration)
	if(owner.stun_immunity > 0)
		duration *= 0.25
	return duration

/status_effect/sleeping/modify_magnitude(var/atom/attacker,var/mob/living/owner,var/magnitude)
	if(owner.stun_immunity > 0)
		magnitude *= 0.25
	return magnitude

/status_effect/paralyzed
	name = "Paralyzed"
	desc = "You're paralyzed!"
	id = PARALYZE
	minimum = 5
	maximum = SECONDS_TO_DECISECONDS(30)
	default_duration = SECONDS_TO_DECISECONDS(1)

	affects_dead = FALSE

/status_effect/paralyzed/modify_duration(var/atom/attacker,var/mob/living/owner,var/duration)
	if(owner.stun_immunity > 0)
		duration *= 0.25
	return duration

/status_effect/paralyzed/modify_magnitude(var/atom/attacker,var/mob/living/owner,var/magnitude)
	if(owner.stun_immunity > 0)
		magnitude *= 0.25
	return magnitude

/status_effect/paralyzed/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	if(duration > 0 && magnitude > 0)
		owner.stun_immunity = max(owner.stun_immunity,owner.stun_immunity + duration*1.25 + SECONDS_TO_DECISECONDS(1))

/status_effect/fire //This is entirely cosmetic.
	name = "Fire"
	desc = "You're on fire!"
	id = FIRE
	minimum = 0
	maximum = 300

	minimum = SECONDS_TO_DECISECONDS(5)
	maximum = SECONDS_TO_DECISECONDS(5)
	default_duration = SECONDS_TO_DECISECONDS(5)

/status_effect/fire/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	. = ..()

	var/initial_fire = owner.on_fire

	if(owner.ignite(magnitude,source) && !initial_fire)
		owner.visible_message(span("danger","\The [owner.name] is set on fire!"),span("danger","You're set on fire!"))

/status_effect/parried
	name = "Parried"
	desc = "You're parried!"
	id = PARRIED
	minimum = SECONDS_TO_DECISECONDS(1)
	maximum = SECONDS_TO_DECISECONDS(4)
	default_duration = SECONDS_TO_DECISECONDS(1)

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
	owner.next_move = max(owner.next_move,DECISECONDS_TO_TICKS(duration))
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
	minimum = SECONDS_TO_DECISECONDS(1)
	maximum = SECONDS_TO_DECISECONDS(4)
	default_duration = SECONDS_TO_DECISECONDS(1)

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
	owner.next_move = max(owner.next_move,DECISECONDS_TO_TICKS(duration))
	if(!result) //We can't move.
		var/list/movement = direction_to_pixel_offset(desired_move_dir)
		animate(owner,pixel_x = movement[1] * TILE_SIZE, pixel_y = movement[2] * TILE_SIZE,time = 1)
		spawn(1)
			var/stun_time = max(duration,10)
			owner.add_status_effect(STUN,stun_time,stun_time)
			animate(owner,pixel_x = 0, pixel_y = 0,time = max(0,stun_time - 1))

	play_sound('sound/weapons/fists/grab.ogg',get_turf(owner))

/status_effect/staggered
	name = "Staggered"
	desc = "You're staggered!"
	id = STAGGER
	minimum = SECONDS_TO_DECISECONDS(0.25)
	maximum = SECONDS_TO_DECISECONDS(1)
	default_duration = SECONDS_TO_DECISECONDS(1)
	affects_dead = FALSE

/status_effect/staggered/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(victim.horizontal)
		return FALSE

	return ..()

/status_effect/staggered/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	owner.next_move = max(owner.next_move,DECISECONDS_TO_TICKS(duration))

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
	var/throw_dir = owner.move_dir
	var/list/throw_offset = direction_to_pixel_offset(throw_dir)
	var/vel_magnitude = clamp(magnitude * 0.5,TILE_SIZE*0.5,TILE_SIZE-1)
	owner.throw_self(owner,null,16,16,throw_offset[1]*vel_magnitude,throw_offset[2]*vel_magnitude, steps_allowed = clamp(CEILING(magnitude/20,1),1,6))

/status_effect/confused
	name = "Confused"
	desc = "You're confused!"
	id = CONFUSED
	minimum = SECONDS_TO_DECISECONDS(1)
	maximum = SECONDS_TO_DECISECONDS(30)
	default_duration = SECONDS_TO_DECISECONDS(10)

	affects_dead = FALSE

/status_effect/critical
	name = "Critical"
	desc = "You're in critical condition!"
	id = CRIT

	default_magnitude = 100
	default_duration = -1

	affects_dead = FALSE

/status_effect/critical/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	owner.remove_status_effect(ADRENALINE)
	return ..()

/status_effect/paincrit
	name = "Paincrit"
	desc = "You're in pain!"
	id = PAINCRIT

	default_magnitude = 100
	default_duration = -1

	affects_dead = FALSE

/status_effect/paincrit/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	owner.remove_status_effect(PAINKILLER)
	return ..()

/status_effect/stamcrit
	name = "Stamcrit"
	desc = "You're too tired!"
	id = STAMCRIT

	default_magnitude = 100
	default_duration = -1

	affects_dead = FALSE

/status_effect/stamcrit/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	owner.remove_status_effect(ADRENALINE)
	owner.stamina_regen_delay = max(owner.stamina_regen_delay,owner.is_player_controlled() ? SECONDS_TO_DECISECONDS(4) : SECONDS_TO_DECISECONDS(10))
	return ..()

/status_effect/adrenaline
	name = "Adrenaline"
	desc = "You're filled with adrenaline!"
	id = ADRENALINE

	minimum = SECONDS_TO_DECISECONDS(10)
	maximum = SECONDS_TO_DECISECONDS(300)
	default_duration = SECONDS_TO_DECISECONDS(30)

/status_effect/adrenaline/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	owner.remove_status_effect(STAMCRIT)
	owner.stamina_regen_delay = 0
	QUEUE_HEALTH_UPDATE(owner)

/status_effect/undying
	name = "Undying"
	desc = "You refuse to die!"
	id = UNDYING

	minimum = -1
	maximum = -1
	default_duration = -1

/status_effect/undying/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	QUEUE_HEALTH_UPDATE(owner)

/status_effect/resting
	name = "Resting"
	desc = "You're resting!"
	id = REST

	minimum = -1
	maximum = -1
	default_duration = -1

	affects_dead = FALSE

/status_effect/disarm
	name = "Disarmed"
	desc = "You're disarmed!"
	id = DISARM
	minimum = 0
	maximum = 0
	default_duration = 0

/status_effect/disarm/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.drop_hands(A.loc)
		for(var/k in A.inventories_by_id)
			var/obj/hud/inventory/I = A.inventories_by_id[k]
			if(I.grabbed_object)
				I.release_object()
	else
		stealthy = TRUE

	return ..()

/status_effect/druggy
	name = "Druggy"
	desc = "You're druggy!"
	id = DRUGGY

	minimum = SECONDS_TO_DECISECONDS(10)
	maximum = SECONDS_TO_DECISECONDS(300)
	default_duration = SECONDS_TO_DECISECONDS(60)

	affects_dead = FALSE

/status_effect/stressed
	name = "Stressed"
	desc = "You're stressed!"
	id = STRESSED

	minimum = SECONDS_TO_DECISECONDS(10)
	maximum = SECONDS_TO_DECISECONDS(300)
	default_duration = SECONDS_TO_DECISECONDS(60)

	affects_dead = FALSE

/status_effect/painkiller
	name = "Painkiller"
	desc = "You're under the influence of painkillers!"
	id = PAINKILLER

	minimum = SECONDS_TO_DECISECONDS(10)
	maximum = SECONDS_TO_DECISECONDS(300)
	default_duration = SECONDS_TO_DECISECONDS(60)

	affects_dead = TRUE

/status_effect/mana_void
	name = "Mana Void"
	desc = "You've been mana voided!"
	id = MANAVOID
	minimum = 0
	maximum = 0
	default_duration = 0

/status_effect/mana_void/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	owner.mana_regen_buffer = -1000

/status_effect/stressed/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)
	owner.mana_regen_buffer = max(0,owner.mana_regen_buffer)

/status_effect/slow
	name = "Slowed"
	desc = "You've been slowed!"
	id = SLOW

	minimum = SECONDS_TO_DECISECONDS(4)
	maximum = SECONDS_TO_DECISECONDS(30)
	default_duration = SECONDS_TO_DECISECONDS(10)

/status_effect/consencrated
	name = "Consencrated"
	desc = "You've been consencrated!"
	id = CONSECRATED

	minimum = SECONDS_TO_DECISECONDS(10)
	maximum = SECONDS_TO_DECISECONDS(300)
	default_duration = SECONDS_TO_DECISECONDS(60)


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

	minimum = SECONDS_TO_DECISECONDS(10)
	maximum = SECONDS_TO_DECISECONDS(300)
	default_duration = SECONDS_TO_DECISECONDS(60)

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

	minimum = SECONDS_TO_DECISECONDS(10)
	maximum = SECONDS_TO_DECISECONDS(300)
	default_duration = SECONDS_TO_DECISECONDS(60)

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


/status_effect/immortal
	name = "Immortal"
	desc = "You're immortal. Congrats, cheater."
	id = IMMORTAL

	affects_dead = TRUE

	minimum = SECONDS_TO_DECISECONDS(1)
	maximum = SECONDS_TO_DECISECONDS(10)
	default_duration = -1


/status_effect/last_breath
	name = "Last Breath"
	desc = "You're on your last legs!"
	id = CRITPROTECTION
	minimum = SECONDS_TO_DECISECONDS(1)
	maximum = SECONDS_TO_DECISECONDS(1)
	default_duration = SECONDS_TO_DECISECONDS(1)

	affects_dead = FALSE