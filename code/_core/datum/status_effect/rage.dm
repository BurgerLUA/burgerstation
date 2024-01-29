//For npcs only.

/status_effect/rage
	name = "Rage"
	desc = "You're filled with rage!"
	id = RAGE

	minimum = 5 SECONDS
	maximum = 30 SECONDS
	default_duration = 10 SECONDS

	affects_dead = FALSE

/status_effect/rage/on_effect_added(mob/living/owner,atom/source,magnitude,duration,stealthy)
	. = ..()
	owner.add_status_effect(UNDYING,magnitude,duration,stealthy=TRUE)
	owner.add_status_effect(ADRENALINE,magnitude,duration,stealthy=TRUE)
	owner.do_say("RRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!!")
	if(duration == -1 && !owner.is_player_controlled(owner))
		owner.color = "#FF0000"
