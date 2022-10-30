/status_effect/grab
	name = "Grab"
	desc = "You're grabbed!"
	id = GRAB
	minimum = 20
	maximum = 20
	default_duration = 20

/status_effect/grab/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(victim.has_status_effect(GRAB))
		return FALSE

	. = ..()

/status_effect/grab/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	if(is_living(source))
		var/mob/living/L = source
		if(allow_hostile_action(L.loyalty_tag,owner))
			L.add_status_effect(PARALYZE,5,5,source = source,stealthy = TRUE)
			if(!owner.dead && (owner.dir == source.dir || owner.horizontal)) //Grab from behind.
				owner.add_status_effect(PARALYZE,30,30,source = source,stealthy = TRUE)
				owner.add_status_effect(DISARM,30,30,source = source)
			else
				owner.add_status_effect(PARALYZE,5,5,source = source,stealthy = TRUE)

	play_sound('sound/weapons/fists/grab.ogg',get_turf(owner))

	. = ..()