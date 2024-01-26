//For npcs only.

/status_effect/rage
	name = "Rage"
	desc = "You're filled with rage!"
	id = RAGE

	minimum = 5 SECONDS
	maximum = 30 SECONDS
	default_duration = 10 SECONDS

	affects_dead = FALSE

/status_effect/rage/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	owner.add_status_effect(UNDYING,magnitude,duration,stealthy=TRUE)
	owner.add_status_effect(ADRENALINE,magnitude,duration,stealthy=TRUE)
	owner.do_say("RRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!!")
	if(duration == -1 && !owner.is_player_controlled(owner))
		owner.color = "#FF0000"
