/mob/living/simple/silicon/drone
	name = "bodyguard drone"
	icon_state = "drone0"

	health = /health/mob/living/simple/drone/

	movement_delay = 2

	health_base = 1000
	stamina_base = 500
	mana_base = 100

	armor = /armor/borg/military

	iff_tag = "Gabber"
	loyalty_tag = "Gabber"

	damage_type = /damagetype/squats/

	ai = /ai/bodyguard_drone

	level = 15

	var/mob/living/simple/owner //Not to be confused with master.


/mob/living/simple/silicon/drone/Destroy()
	. = ..()
	owner =  null